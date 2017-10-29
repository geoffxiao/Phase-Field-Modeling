% Run inputs
LOAD = 1; % 1 = Load initial conditions from file called init.mat, 0 = random P initial conditions
E_1_applied = 0; E_2_applied = 0; E_3_applied = 0; % in V/m, 1e5 V/m = 1 kV/cm
T = 27; % in C
Us_11 = 0; % unitless misfit strain
Us_22 = Us_11; % anisotropic misfit strain
PATH = '.\';
STRING = 'BFO small Q44'; % Material Name
VPA_ELECTRIC_ON = 1; % numerical errors when doing electric energy, so we need to use vpa
VPA_ELASTIC_ON = 0;

%% ---- Nothing needed to modify below ---- %%
% BFO Constants http://www.mmm.psu.edu/JXZhang2008_JAP_Computersimulation.pdf

%% Convergence
epsilon = 1e-10; % convergence criterion
saves = [0 : 500 : 100000]; % save after this many iterations

%% Grid Size
Nx = 32; Ny = Nx; Nz = 32; % Grid Points
sub_index = 12; % where substrate starts, >= 1, at and below this index P = 0, substrate thickness
% sub_index = 0 to get no substrate part
interface_index = sub_index + 1;
film_index = 28; % where film ends, <= Nz, above this index, P = 0
Nz_film = film_index - sub_index; % film lies in the area between sub_index + 1 and film_index, film thickness
Nz_film_sub = film_index;

%% Energies, 0 = off, 1 = on
ELASTIC = 1;
HET_ELASTIC_RELAX = 1 && ELASTIC; % automatically 0 if no elastic energy 
% no heterogenous elastic relaxation if no elastic energy

ELECTRIC = 1;
SURFACE_DEPOL = 0; % depolarization energy due to uncompensated surface charges

NUCLEATE = 0; % nucleation sites, places that don't change during temporal evolution, 1 -> during hysteresis calcs

ThermConst = 0; % No thermal energy

%% Elastic Tensor
Poisson_Ratio = 0.35;
Shear_Mod = 0.69 * 1e11;

C11 = 2 * Shear_Mod * ( 1 - Poisson_Ratio ) / ( 1 - 2 * Poisson_Ratio );
C12 = 2 * Shear_Mod * Poisson_Ratio / ( 1 - 2 * Poisson_Ratio );
C44 = Shear_Mod;

C12 = 1.62 * 1e11;

C = zeros(3,3,3,3);
C(1,1,1,1) = C11; C(2,2,2,2) = C11; C(3,3,3,3) = C11;
C(1,1,2,2) = C12; C(1,1,3,3) = C12; C(2,2,1,1) = C12;
C(2,2,3,3) = C12; C(3,3,1,1) = C12; C(3,3,2,2) = C12;
C(1,2,1,2) = C44; C(2,1,2,1) = C44; C(1,3,1,3) = C44;
C(3,1,3,1) = C44; C(2,3,2,3) = C44; C(3,2,3,2) = C44;
C(1,2,2,1) = C44; C(2,1,1,2) = C44; C(1,3,3,1) = C44;
C(3,1,1,3) = C44; C(2,3,3,2) = C44; C(3,2,2,3) = C44;


%% Electrostriction
Q11 = 0.032; % Q1111 = Q11
Q12 = -0.016; % Q1122 = Q12
Q44 = 0.01 * 2; % 2 * Q1212 = Q44

q11 = C11 * Q11 + 2 * C12 * Q12;
q12 = C11 * Q12 + C12 * ( Q11 + Q12 );
q44 = 2 * C44 * Q44;

%% LGD Constants, stress free BTO
a1_T = @(T) 4.9 * ((T+273)-1103) * 1e5; % T in C
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

%% Simulation Size
l_0 = 0.5e-9;
Lx = l_0*(Nx-1); Ly = l_0*(Ny-1); Lz = l_0*(Nz-1);

%% Gradient Free Energy
a0 = abs(a1_T(25));
G110 = l_0^2 * a0; 
G11 = 0.6 * G110;

G12 = 0; % anisotropic part

% G44 = G44'
H14 = 0; % H14 = G12 + G44 - G44'
H44 = G11; % H44 = G44 + G44'

%% Run time setup
t_0 = 1/a0;
dt = 0.0125/(a0);
RUN_TIME = 1; % time, not iterations
MAX_ITERATIONS = RUN_TIME / dt;

%% Electrical
k_electric_11 = 500; k_electric_22 = k_electric_11; k_electric_33 = k_electric_11;