%% BFO
% All in MKS units

%% Energies, 0 = off, 1 = on
ELASTIC = 1; 
HET_ELASTIC_RELAX = 0 && ELASTIC;

ELECTRIC = 0;
SURFACE_DEPOL = 0;

LOAD = 0; % Load initial conditions from file
NUCLEATE = 0;

%% Grid 
Nx = 8; Ny = Nx; Nz = 36; % Grid Points
sub_index = 12; % where substrate starts, >= 1, at and below this index P = 0, substrate thickness
% sub_index = 0 to get no substrate part
interface_index = sub_index + 1;
film_index = 32; % where film ends, <= Nz, above this index, P = 0
Nz_film = film_index - sub_index; % film lies in the area between sub_index + 1 and film_index, film thickness
Nz_film_sub = film_index;

T = 27; % in C
Us = 1e-2; % unitless misfit strain

epsilon = 1e-2;
NOISE = 0;
saves = [0 : 1000 : 10000];

ThermConst = 0; % 0 no noise...

%% Elastic Tensor
Poisson_mod = 0.35;
Shear_mod = 0.69 * 1e11;
Elastic_mod = Shear_mod * 2 * (1 + Poisson_mod);

S11 = 1 / Elastic_mod;
S12 = -Poisson_mod / Elastic_mod;
S44 = (1 + Poisson_mod) / Elastic_mod;

C11 = (S11+S12)/((S11-S12)*(S11+2*S12));
C12 = -S12/((S11-S12)*(S11+2*S12));
C44 = 1/S44;


C = zeros(3,3,3,3);
C(1,1,1,1) = C11; C(2,2,2,2) = C11; C(3,3,3,3) = C11;
C(1,1,2,2) = C12; C(1,1,3,3) = C12; C(2,2,1,1) = C12;
C(2,2,3,3) = C12; C(3,3,1,1) = C12; C(3,3,2,2) = C12;
C(1,2,1,2) = C44; C(2,1,2,1) = C44; C(1,3,1,3) = C44;
C(3,1,3,1) = C44; C(2,3,2,3) = C44; C(3,2,3,2) = C44;
C(1,2,2,1) = C44; C(2,1,1,2) = C44; C(1,3,3,1) = C44;
C(3,1,1,3) = C44; C(2,3,3,2) = C44; C(3,2,2,3) = C44;

%% Electrostriction
Q11 = 0.032; 
Q12 = -0.016;
Q44 = 0.01;

q11 = C11 * Q11 + 2 * C12 * Q12;
q12 = C11 * Q12 + C12 * ( Q11 + Q12 );
q44 = 2 * C44 * Q44;

% q11_h = q11 + 2 * q12;
% q22_h = q11 - q12;
% C11_h = C11 + 2 * C12;
% C22_h = C11 - C12;
% 
% Q11 = (1/3) * ( (q11_h/C11_h) + (2 * q22_h/C22_h) );
% Q12 = (1/3) * ( (q11_h/C11_h) - (q22_h/C22_h) );
% Q44 = q44 / (2 * C44);

%% LGD Constants, stress free Pb Zr(1-x) Tix O3
% x = 1
a1_T = @(T) 4.9 * ((T-273)-1103) * 1e5; % T in C
a1 = a1_T(T);
a11 = 5.42 * 1e8;
a12 = 1.54 * 1e8;
a111 = 0;
a112 = 0; 
a123 = 0;
a1111 = 0;
a1112 = 0;
a1122 = 0;
a1123 = 0;

%% Simulation grid in real space
l_0 = 1e-9;
Lx = l_0*(Nx-1); Ly = l_0*(Ny-1); Lz = 0.5*l_0*(Nz-1);

% Set up real space axis
x_axis = linspace(0, Lx, Nx)'; y_axis = linspace(0, Ly, Ny)'; z_axis = linspace(0, Lz, Nz)';

%% VERY IMPORTANT STEP!! Let us redefine zero, otherwise the exp() term will make our matrix solving go to shit...
z_axis = z_axis - z_axis((round(Nz/2)));

dx = x_axis(2) - x_axis(1); dy = y_axis(2) - y_axis(1); dz = z_axis(2) - z_axis(1);
[x_grid, y_grid, z_grid] = meshgrid(x_axis, y_axis, z_axis);
% kx_grid(y,x,z)

%% Gradient Free Energy
a0 = abs(a1_T(25));
G110 = dx^2 * a0; 
G11 = 0.6 * G110;
G12 = 0; % anisotropic part

% G44 = G44'
H14 = 0; % H14 = G12 + G44 - G44'
H44 = 0.6 * G110; % H44 = G44 + G44'

%% Fourier space vectors -> Gradient energy terms and things that use air + film + sub
kx = 2*pi/Lx*[0:Nx/2 -Nx/2+1:-1]'; 
ky = 2*pi/Ly*[0:Ny/2 -Ny/2+1:-1]';
kz = 2*pi/Lz*[0:Nz/2 -Nz/2+1:-1]';
[kx_grid_3D,ky_grid_3D,kz_grid_3D] = meshgrid(kx,ky,kz);
[kx_grid_2D, ky_grid_2D] = meshgrid(kx, ky);

k_mag_3D = sqrt(kx_grid_3D.^2 + ky_grid_3D.^2 + kz_grid_3D.^2);
ex_3D = kx_grid_3D ./ k_mag_3D;
ey_3D = ky_grid_3D ./ k_mag_3D;
ez_3D = kz_grid_3D ./ k_mag_3D;

%% Run time setup
t_0 = 1/a0;
dt = 0.01/(a0);
RUN_TIME = 1; % time, not iterations
MAX_ITERATIONS = RUN_TIME / dt;

%%
if( sub_index > 0 )
    in_film = (z_grid > z_axis(sub_index)) & (z_grid <= z_axis(film_index));
    not_in_film = ~in_film;
    not_in_film = +not_in_film;
    in_film = +in_film;
else
    in_film = 1;
    not_in_film = 0;
end

%% Electrical
permittivity_0 = 8.85418782*1e-12;
k11 = 1000; k22 = k11; k33 = k11;
E_1_applied =  0; E_2_applied = 0; E_3_applied = 0;

%% Transform matrix
% Transform from crystal to global film reference
Transform = [1 0 0; 0 1/sqrt(2) 1/sqrt(2); 0 -1/sqrt(2) 1/sqrt(2)];

%% z axis 
h_film = z_axis(film_index); % end of film
h_sub = z_axis(1); % where substrate ends...limit of elastic deformation allowed in substrate
h_int = z_axis(interface_index);

%% Green's Tensor
Green = zeros(Nx,Ny,Nz,3,3);

% For each k vector find Green's Tensor
for k1 = 1 : Nx
for k2 = 1 : Ny
for k3 = 1 : Nz

    K_vec = [kx_grid_3D(k1,k2,k3) ky_grid_3D(k1,k2,k3) kz_grid_3D(k1,k2,k3)]; % Fourier space vector
    g_inv = zeros(3,3);
    for i_ind = 1 : 3
    for j_ind = 1 : 3
        for l_ind = 1 : 3
        for k_ind = 1 : 3
            g_inv(i_ind,j_ind) = g_inv(i_ind,j_ind) + C(i_ind,k_ind,j_ind,l_ind) * K_vec(k_ind) * K_vec(l_ind);
        end
        end
    end
    end
    
    Green(k1,k2,k3,:,:) = inv(g_inv);
    
end
end
end

Green((kx==0),(ky==0),(kz==0),:,:) = 0;

%% Nucleation sites, have 0 free energy change...
% Nucleation_Sites = +(rand(Nx,Ny,Nz) < (1-0.01)) .* in_film;
if( NUCLEATE )
    L = 5;
    Nucleation_Sites = ones(Nx,Ny,Nz);
    xy_edges = 8;
    z_edges = 2;
    for i = 1 : 7
        Nucleation_Sites(randi([xy_edges,Nx-L+1-xy_edges])+(0:L-1),randi([xy_edges,Ny-L+1-xy_edges])+(0:L-1),randi([z_edges,Nz-L+1-z_edges])+(0:L-1)) = 0;
    end

    % Percent of nucleation sites
    Nucleation_pct = abs(sum(sum(sum(Nucleation_Sites-1)))/(Nx*Ny*(film_index-interface_index+1)));
else
    Nucleation_Sites = 1;
end