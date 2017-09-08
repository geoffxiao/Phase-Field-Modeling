% Run inputs
LOAD = 0; % 1 = Load initial conditions from file called init.mat, 0 = random P initial conditions
E_1_applied_FilmRef = 0; E_2_applied_FilmRef = 0; E_3_applied_FilmRef = 0; % in V/m, 1e5 V/m = 1 kV/cm
T = 17; % in C
Us_11 = 0.5068e-2; % unitless misfit strain
Us_22 = Us_11; % anisotropic misfit strain
% BST composition
BTO_pct = 0.8; STO_pct = 1 - BTO_pct;





%% ---- Nothing needed to modify below ---- %%

%% Convergence
epsilon = 1e-2; % convergence criterion
saves = [0 : 1000 : 20000]; % save after this many iterations

%% Grid Size
Nx = 64; Ny = Nx; Nz = 36; % Grid Points
sub_index = 12; % where substrate starts, >= 1, at and below this index P = 0, substrate thickness
% sub_index = 0 to get no substrate part
interface_index = sub_index + 1;
film_index = 32; % where film ends, <= Nz, above this index, P = 0
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

%% BTO =  http://www.ems.psu.edu/~chen/publications/YL2005APL.pdf
C11_BTO = 1.78 * 1e11;
C12_BTO = 0.964 * 1e11;
C44_BTO = 1.22 * 1e11;

Q11_BTO = 0.10; 
Q12_BTO = -0.034;
Q44_BTO = 0.029;

a1_BTO = @(T) 4.124 * ( T - 115 ) * 1e5;
a11_BTO = -2.097 * 1e8;
a12_BTO = 7.974 * 1e8;
a111_BTO = 1.294 * 1e9;
a112_BTO = -1.950 * 1e9;
a123_BTO = -2.5 * 1e9;
a1111_BTO = 3.863 * 1e10;
a1112_BTO = 2.529 * 1e10;
a1122_BTO = 1.637 * 1e10;
a1123_BTO = 1.367 * 1e10;

%% STO, Table VII, Table I last column
% http://www.wolframalpha.com/input/?i=1+dyn%2Fcm%5E2
% 1 dyn/cm^2 = 0.1 Pa
C11_STO = 3.36 * 1e11;
C12_STO = 1.07 * 1e11;
C44_STO = 1.27 * 1e11;

% STO Yu Luan Li PRB 184112, Table II
% 1 cm^4 / esu^2 = 8.988 * 1e10 m^4 / C^2
% http://www.wolframalpha.com/input/?i=(1+cm)%5E4%2F(3.3356e-10+coulomb)%5E2
Q11_STO = 4.57 * 1e-2; 
Q12_STO = -1.348 * 1e-2;
Q44_STO = 0.957 * 1e-2;

% STO Yu Luan Li PRB 184112, Table III a1 (1st, from ref 6, 16, 22), Table
% VII a11, a12, a1
% Shirokov, Yuzyu, PRB 144118, Table I STO in parantheses

% 1 cm^2 * dyn / esu^2 = 8.9876 * 1e9 J * m^2 / C
a1_STO = @(T) 4.05 * 1e7 * ( coth( 54 / (T+273) ) - coth(54/30) );

% 1 cm^6 * dyn / esu^4 = 8.0776 * 1e20 J * m^5 / C^4
a11_STO = 17 * 1e8;
a12_STO = 13.7 * 1e8;

a111_STO = 0;
a112_STO = 0;
a123_STO = 0;
a1111_STO = 0;
a1112_STO = 0;
a1122_STO = 0;
a1123_STO = 0;

%% Elastic Tensor
C11 = C11_BTO * BTO_pct + C11_STO * STO_pct;
C12 = C12_BTO * BTO_pct + C12_STO * STO_pct;
C44 = C44_BTO * BTO_pct + C44_STO * STO_pct;

C = zeros(3,3,3,3);
C(1,1,1,1) = C11; C(2,2,2,2) = C11; C(3,3,3,3) = C11;
C(1,1,2,2) = C12; C(1,1,3,3) = C12; C(2,2,1,1) = C12;
C(2,2,3,3) = C12; C(3,3,1,1) = C12; C(3,3,2,2) = C12;
C(1,2,1,2) = C44; C(2,1,2,1) = C44; C(1,3,1,3) = C44;
C(3,1,3,1) = C44; C(2,3,2,3) = C44; C(3,2,3,2) = C44;
C(1,2,2,1) = C44; C(2,1,1,2) = C44; C(1,3,3,1) = C44;
C(3,1,1,3) = C44; C(2,3,3,2) = C44; C(3,2,2,3) = C44;

%% Electrostriction
q11_BTO = C11_BTO * Q11_BTO + 2 * C12_BTO * Q12_BTO;
q12_BTO = C11_BTO * Q12_BTO + C12_BTO * (Q11_BTO + Q12_BTO);
q44_BTO = 2 * C44_BTO * Q44_BTO;

q11_STO = C11_STO * Q11_STO + 2 * C12_STO * Q12_STO;
q12_STO = C11_STO * Q12_STO + C12_STO * (Q11_STO + Q12_STO);
q44_STO = 2 * C44_STO * Q44_STO;

q11 = q11_BTO * BTO_pct + q11_STO * STO_pct;
q12 = q12_BTO * BTO_pct + q12_STO * STO_pct;
q44 = q44_BTO * BTO_pct + q44_STO * STO_pct;

q11_h = q11 + 2 * q12;
q22_h = q11 - q12;
C11_h = C11 + 2 * C12;
C22_h = C11 - C12;

Q11 = (1/3) * ( (q11_h/C11_h) + (2 * q22_h/C22_h) );
Q12 = (1/3) * ( (q11_h/C11_h) - (q22_h/C22_h) );
Q44 = q44 / (2 * C44);

%% LGD Constants, stress free BTO
a1_T = @(T) a1_BTO(T) * BTO_pct + a1_STO(T) * STO_pct;
a1 = a1_T(T);
a11 = a11_BTO * BTO_pct + a11_STO * STO_pct;
a12 = a12_BTO * BTO_pct + a12_STO * STO_pct;
a111 = a111_BTO * BTO_pct + a111_STO * STO_pct;
a112 = a112_BTO * BTO_pct + a112_STO * STO_pct;
a123 = a123_BTO * BTO_pct + a123_STO * STO_pct;
a1111 = a1111_BTO * BTO_pct + a1111_STO * STO_pct;
a1112 = a1112_BTO * BTO_pct + a1112_STO * STO_pct;
a1122 = a1122_BTO * BTO_pct + a1122_STO * STO_pct;
a1123 = a1123_BTO * BTO_pct + a1123_STO * STO_pct;

%% Simulation Size
l_0 = 1e-9;
Lx = l_0*(Nx-1); Ly = l_0*(Ny-1); Lz = 0.5*l_0*(Nz-1);

%% Gradient Free Energy
a0 = abs(a1_T(25));
G110 = l_0^2 * a0; 
G11 = 0.6 * G110;
G12 = 0; % anisotropic part

% G44 = G44'
H14 = 0; % H14 = G12 + G44 - G44'
H44 = 0.6 * G110; % H44 = G44 + G44'

%% Run time setup
t_0 = 1/a0;
dt = 0.0125/(a0);
RUN_TIME = 1; % time, not iterations
MAX_ITERATIONS = RUN_TIME / dt;

%% Electrical
permittivity_0 = 8.85418782*1e-12;
k11 = 1000; k22 = k11; k33 = k11;