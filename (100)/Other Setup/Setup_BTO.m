% http://www.ems.psu.edu/~chen/publications/YL2005APL.pdf
SURFACE_DEPOL = 0;
Nx = 32; Ny = Nx; Nz = 36; % Grid Points
sub_index = 12; % where substrate starts, >= 1, at and below this index P = 0, substrate thickness
% sub_index = 0 to get no substrate part
interface_index = sub_index + 1;
film_index = 32; % where film ends, <= Nz, above this index, P = 0
Nz_film = film_index - sub_index; % film lies in the area between sub_index + 1 and film_index, film thickness
Nz_film_sub = film_index;

T = 25; % in C
Us = -1e-2;
epsilon = 1e-3;
NOISE = 0;
saves = [0 : 500 : 2000];

%% Elastic Tensor
% BTO
C11 = 1.78 * 1e11;
C12 = 0.964 * 1e11;
C44 = 1.22 * 1e11;

C = zeros(3,3,3,3);
C(1,1,1,1) = C11; C(2,2,2,2) = C11; C(3,3,3,3) = C11;
C(1,1,2,2) = C12; C(1,1,3,3) = C12; C(2,2,1,1) = C12;
C(2,2,3,3) = C12; C(3,3,1,1) = C12; C(3,3,2,2) = C12;
C(1,2,1,2) = C44; C(2,1,2,1) = C44; C(1,3,1,3) = C44;
C(3,1,3,1) = C44; C(2,3,2,3) = C44; C(3,2,3,2) = C44;
C(1,2,2,1) = C44; C(2,1,1,2) = C44; C(1,3,3,1) = C44;
C(3,1,1,3) = C44; C(2,3,3,2) = C44; C(3,2,2,3) = C44;

%% Electrostriction
Q11 = 0.10; 
Q12 = -0.034;
Q44 = 0.029;

q11 = C11 * Q11 + 2 * C12 * Q12;
q12 = C11 * Q12 + C12 * (Q11 + Q12);
q44 = 2 * C44 * Q44;

%% LGD Constants, stress free BTO
a1_T = @(T) 4.124 * (T - 115) * 1e5;
a1 = a1_T(T);
a11 = -2.097 * 1e8;
a12 = 7.974 * 1e8;
a111 = 1.294 * 1e9;
a112 = -1.950 * 1e9;
a123 = -2.5 * 1e9;
a1111 = 3.863 * 1e10;
a1112 = 2.529 * 1e10;
a1122 = 1.637 * 1e10;
a1123 = 1.367 * 1e10;

%%
b11 = 0.5*C11*(Q11^2 + 2*Q12^2) + C12*Q12*(2*Q11 + Q12);
b12 = C11*Q12*(2*Q11 + Q12) + C12*(Q11^2 + 3*Q12^2 + 2*Q11*Q12) + 2*C44*Q44^2;

%% Simulation grid in real space
l_0 = 1e-9;
Lx = l_0*(Nx-1); Ly = l_0*(Ny-1); Lz = 0.5*l_0*(Nz-1);

% Set up real space axis
x_axis = linspace(0, Lx, Nx)'; y_axis = linspace(0, Ly, Ny)'; z_axis = linspace(0, Lz, Nz)';

%% VERY IMPORTANT STEP!! Let us redefine zero, otherwise the exp() term will make our matrix solving go to shit...
z_axis = z_axis - z_axis((round(Nz/2)));

dx = x_axis(2) - x_axis(1); dy = y_axis(2) - y_axis(1); dz = z_axis(2) - z_axis(1);
[x_grid, y_grid, z_grid] = meshgrid(x_axis, y_axis, z_axis);

%% Gradient Free Energy
a0 = abs(a1_T(25));
G110 = dx^2 * a0; 
G11 = 0.6 * G110;
G14 = 0;
G44 = 0.6 * G110;

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
dt = 0.00125/(a0);
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
k11 = 10; k22 = k11; k33 = k11;
E_1_applied = 0; E_2_applied = 0; E_3_applied = 0;

%% z axis 
h_film = z_axis(film_index); % end of film
h_sub = z_axis(1); % where substrate ends...limit of elastic deformation allowed in substrate
h_int = z_axis(interface_index);