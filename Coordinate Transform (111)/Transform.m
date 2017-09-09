%%
% Change CalcElasticEnergy
% Change CalculateStrain
% CalcEigenstrains
% EigenstrainInFilm
% FilmRef_Transform_CrystalRef
% HomoStrainSetup

%% Transformation from crystal to global
% Transform_Matrix = [ sym('Transform_Matrix(1,1)') sym('Transform_Matrix(1,2)') sym('Transform_Matrix(1,3)'); ...
%                      sym('Transform_Matrix(2,1)') sym('Transform_Matrix(2,2)') sym('Transform_Matrix(2,3)'); ...
%                      sym('Transform_Matrix(3,1)') sym('Transform_Matrix(3,2)') sym('Transform_Matrix(3,3)') ];

Transform_Matrix = [ 0                      1/sqrt(2)               -1/sqrt(2); ...
                     -2/sqrt(6)             1/sqrt(6)               1/sqrt(6); ... 
                     1/sqrt(3)              1/sqrt(3)               1/sqrt(3) ];
 
%% Calculate elastic tensor transformed
C_CrystalRef = sym(zeros(3,3,3,3));

C11 = sym('C11');
C12 = sym('C12');
C44 = sym('C44');

C_CrystalRef(1,1,1,1) = C11; C_CrystalRef(2,2,2,2) = C11; C_CrystalRef(3,3,3,3) = C11;
C_CrystalRef(1,1,2,2) = C12; C_CrystalRef(1,1,3,3) = C12; C_CrystalRef(2,2,1,1) = C12;
C_CrystalRef(2,2,3,3) = C12; C_CrystalRef(3,3,1,1) = C12; C_CrystalRef(3,3,2,2) = C12;
C_CrystalRef(1,2,1,2) = C44; C_CrystalRef(2,1,2,1) = C44; C_CrystalRef(1,3,1,3) = C44;
C_CrystalRef(3,1,3,1) = C44; C_CrystalRef(2,3,2,3) = C44; C_CrystalRef(3,2,3,2) = C44;
C_CrystalRef(1,2,2,1) = C44; C_CrystalRef(2,1,1,2) = C44; C_CrystalRef(1,3,3,1) = C44;
C_CrystalRef(3,1,1,3) = C44; C_CrystalRef(2,3,3,2) = C44; C_CrystalRef(3,2,2,3) = C44;

C_FilmRef = sym(zeros(3,3,3,3));

for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
    
    for m = 1 : 3
    for n = 1 : 3
    for o = 1 : 3
    for p = 1 : 3

        C_FilmRef(i,j,k,l) = Transform_Matrix(i,m) * Transform_Matrix(j,n) * Transform_Matrix(k,o) * Transform_Matrix(l,p) * C_CrystalRef(m,n,o,p) + C_FilmRef(i,j,k,l);

    end
    end
    end
    end
    
end
end
end
end

%% Film Ref as a function of Crystal Ref
% P_CrystalRef = [sym('P1_CrystalRef'); sym('P2_CrystalRef'); sym('P3_CrystalRef')];
% P_FilmRef = sym(zeros(3,1));
% 
% for i = 1 : 3
%     for j = 1 : 3
%         P_FilmRef(i) = Transform_Matrix(i,j) * P_CrystalRef(j) + P_FilmRef(i);
%     end
% end

%%

% Express P in crystal as P in film reference to change Landau energies
P_FilmRef = [sym('P1_FilmRef'); sym('P2_FilmRef'); sym('P3_FilmRef')];
P_CrystalRef = sym(zeros(3,1));

P1_FilmRef = P_FilmRef(1);
P2_FilmRef = P_FilmRef(2);
P3_FilmRef = P_FilmRef(3);

for i = 1 : 3
    for j = 1 : 3
        P_CrystalRef(i) = Transform_Matrix(j,i) * P_FilmRef(j) + P_CrystalRef(i);
    end
end
    
% P in old axis expressed as new axis
P1_CrystalRef = P_CrystalRef(1);
P2_CrystalRef = P_CrystalRef(2);
P3_CrystalRef = P_CrystalRef(3);

%% Landau Energy
a1 = sym('a1');
a11 = sym('a11');
a12 = sym('a12');
a111 = sym('a111');
a112 = sym('a112');
a123 = sym('a123');
a1111 = sym('a1111');
a1112 = sym('a1112');
a1122 = sym('a1122');
a1123 = sym('a1123');

f_landau = a1 * (P1_CrystalRef^2 + P2_CrystalRef^2 + P3_CrystalRef^2) + ...
    a11 * (P1_CrystalRef^4 + P2_CrystalRef^4 + P3_CrystalRef^4) + ...
    a12 * (P1_CrystalRef^2*P2_CrystalRef^2 + P2_CrystalRef^2*P3_CrystalRef^2 + P1_CrystalRef^2*P3_CrystalRef^2) + ...
    a111 * (P1_CrystalRef^6 + P2_CrystalRef^6 + P3_CrystalRef^6) + ...
    a112 * (P1_CrystalRef^4 * (P2_CrystalRef^2 + P3_CrystalRef^2) + P2_CrystalRef^4 * (P1_CrystalRef^2 + P3_CrystalRef^2) + P3_CrystalRef^4 * (P1_CrystalRef^2 + P2_CrystalRef^2)) + ...
    a123 * (P1_CrystalRef^2*P2_CrystalRef^2*P3_CrystalRef^2) + ...
    a1111 * (P1_CrystalRef^8+P2_CrystalRef^8+P3_CrystalRef^8) + ...
    a1112 * (P1_CrystalRef^6 * (P2_CrystalRef^2 + P3_CrystalRef^2) + P2_CrystalRef^6 * (P1_CrystalRef^2 + P3_CrystalRef^2) + P3_CrystalRef^6 * (P1_CrystalRef^2 + P2_CrystalRef^2))+ ...
    a1122 * (P1_CrystalRef^4 * P2_CrystalRef^4 + P2_CrystalRef^4 * P3_CrystalRef^4 + P1_CrystalRef^4 * P3_CrystalRef^4) + ...
    a1123 * (P1_CrystalRef^4 * P2_CrystalRef^2 * P3_CrystalRef^2 + P2_CrystalRef^4 * P1_CrystalRef^2 * P3_CrystalRef^2 + P3_CrystalRef^4 * P1_CrystalRef^2 * P2_CrystalRef^2);

simplified_f_landau = collect(expand(f_landau),[a1,a11,a12,a111,a112,a123,a1111,a1112,a1122,a1123]);

f_landau_P1 = diff(simplified_f_landau,P1_FilmRef);
f_landau_P2 = diff(simplified_f_landau,P2_FilmRef);
f_landau_P3 = diff(simplified_f_landau,P3_FilmRef);

%% Transform eigenstrain
Q11 = sym('Q11'); Q12 = sym('Q12'); Q44 = sym('Q44');

% P1_CrystalRef = sym('P1_CrystalRef');
% P2_CrystalRef = sym('P2_CrystalRef');
% P3_CrystalRef = sym('P3_CrystalRef');

% Eigenstrain in crystal reference eigenstrain_ij = Q_ijkl * P_k * P_l
Eigenstrain_CrystalRef = sym(zeros(3,3));
Eigenstrain_CrystalRef(1,1) = (Q11 * P1_CrystalRef^2 + Q12 * (P2_CrystalRef^2 + P3_CrystalRef^2));
Eigenstrain_CrystalRef(2,2) = (Q11 * P2_CrystalRef^2 + Q12 * (P1_CrystalRef^2 + P3_CrystalRef^2));
Eigenstrain_CrystalRef(3,3) = (Q11 * P3_CrystalRef^2 + Q12 * (P1_CrystalRef^2 + P2_CrystalRef^2));
Eigenstrain_CrystalRef(1,2) = (Q44 * P1_CrystalRef * P2_CrystalRef);
Eigenstrain_CrystalRef(1,3) = (Q44 * P1_CrystalRef * P3_CrystalRef);
Eigenstrain_CrystalRef(2,3) = (Q44 * P2_CrystalRef * P3_CrystalRef);
Eigenstrain_CrystalRef(2,1) = Eigenstrain_CrystalRef(1,2);
Eigenstrain_CrystalRef(3,1) = Eigenstrain_CrystalRef(1,3);
Eigenstrain_CrystalRef(3,2) = Eigenstrain_CrystalRef(2,3);

% Transformed eigenstrain, expressed in film ref P
Eigenstrain_FilmRef = sym(zeros(3,3));
for i = 1 : 3
for j = 1 : 3
    for m = 1 : 3
    for n = 1 : 3        
        Eigenstrain_FilmRef(i,j) = Transform_Matrix(i,m) * Transform_Matrix(j,n) * Eigenstrain_CrystalRef(m,n) + Eigenstrain_FilmRef(i,j);
    end
    end
end
end

% Test symmetry of Eigenstrain_FilmRef
for i = 1 : 3
for j = 1 : 3
   if(Eigenstrain_FilmRef(i,j) ~= Eigenstrain_FilmRef(j,i))
       disp('X');
   end
end
end

Eigenstrain_FilmRef = collect(simplify(Eigenstrain_FilmRef),[Q11,Q12,Q44]);

for i = 1 : 3
for j = 1 : 3
    fprintf('Eigenstrain_FilmRef_%g%g = %s\n',i,j,char(Eigenstrain_FilmRef(i,j)));
end
end

%% Solve Mech equ.
% Green's Tensor, k-space dependent Tensor (matrix)
Green_FilmRef_k = sym(zeros(3,3));
Green_FilmRef_k(1,1) = sym('Green_FilmRef_k_11'); Green_FilmRef_k(2,1) = sym('Green_FilmRef_k_21'); Green_FilmRef_k(3,1) = sym('Green_FilmRef_k_31');
Green_FilmRef_k(1,2) = sym('Green_FilmRef_k_12'); Green_FilmRef_k(2,2) = sym('Green_FilmRef_k_22'); Green_FilmRef_k(3,2) = sym('Green_FilmRef_k_32');
Green_FilmRef_k(1,3) = sym('Green_FilmRef_k_13'); Green_FilmRef_k(2,3) = sym('Green_FilmRef_k_23'); Green_FilmRef_k(3,3) = sym('Green_FilmRef_k_33');

Eigenstrain_FilmRef_k = sym(zeros(3,3));
Eigenstrain_FilmRef_k(1,1) = sym( 'Eigenstrain_FilmRef_11_k' );
Eigenstrain_FilmRef_k(2,2) = sym( 'Eigenstrain_FilmRef_22_k' );
Eigenstrain_FilmRef_k(3,3) = sym( 'Eigenstrain_FilmRef_33_k' );
Eigenstrain_FilmRef_k(2,3) = sym( 'Eigenstrain_FilmRef_23_k' );
Eigenstrain_FilmRef_k(1,3) = sym( 'Eigenstrain_FilmRef_13_k' );
Eigenstrain_FilmRef_k(1,2) = sym( 'Eigenstrain_FilmRef_12_k' );
Eigenstrain_FilmRef_k(3,2) = Eigenstrain_FilmRef_k(2,3);
Eigenstrain_FilmRef_k(3,1) = Eigenstrain_FilmRef_k(1,3);
Eigenstrain_FilmRef_k(2,1) = Eigenstrain_FilmRef_k(1,2);

k_vec = sym(zeros(3,1)); k_vec(1) = sym('kx_grid_3D'); k_vec(2) = sym('ky_grid_3D'); k_vec(3) = sym('kz_grid_3D');

u_FilmRef_k_mat = sym(zeros(3,1));
for i = 1 : 3
    for m = 1 : 3
    for j = 1 : 3
    for k = 1 : 3
    for l = 1 : 3

        u_FilmRef_k_mat(i) = u_FilmRef_k_mat(i) + sym('-1i') * Green_FilmRef_k(i,j) * C_FilmRef(j,m,k,l) * Eigenstrain_FilmRef_k(k,l) * k_vec(m);

    end
    end
    end
    end
end

u_FilmRef_k_mat = collect(simplify(u_FilmRef_k_mat),[C11,C12,C44]);

%% Macroscopic homo strain boundary conditions
% Total strain = homo + hetero

TotalStrain_FilmRef_homo = sym(zeros(3,3)); % strain in transformed axes
TotalStrain_FilmRef_homo(1,1) = sym('TotalStrain_FilmRef_homo_11');
TotalStrain_FilmRef_homo(2,2) = sym('TotalStrain_FilmRef_homo_22');
TotalStrain_FilmRef_homo(3,3) = sym('TotalStrain_FilmRef_homo_33');
TotalStrain_FilmRef_homo(1,2) = sym('TotalStrain_FilmRef_homo_12');
TotalStrain_FilmRef_homo(1,3) = sym('TotalStrain_FilmRef_homo_13');
TotalStrain_FilmRef_homo(2,3) = sym('TotalStrain_FilmRef_homo_23');
TotalStrain_FilmRef_homo(2,1) = TotalStrain_FilmRef_homo(1,2);
TotalStrain_FilmRef_homo(3,1) = TotalStrain_FilmRef_homo(1,3);
TotalStrain_FilmRef_homo(3,2) = TotalStrain_FilmRef_homo(2,3);


Macroscopic_Homo_BC_Equs = sym(zeros(3,1));

for i = 1 : 3
   for k = 1 : 3
   for l = 1 : 3
        Macroscopic_Homo_BC_Equs(i) = Macroscopic_Homo_BC_Equs(i) + C_FilmRef(i,3,k,l) * TotalStrain_FilmRef_homo(k,l);
   end
   end
end

Macroscopic_Homo_BC_Equs(1) = Macroscopic_Homo_BC_Equs(1) == 0;
Macroscopic_Homo_BC_Equs(2) = Macroscopic_Homo_BC_Equs(2) == 0;
Macroscopic_Homo_BC_Equs(3) = Macroscopic_Homo_BC_Equs(3) == 0;

Macroscopic_Homo_BC_Equs_Solutions = solve(Macroscopic_Homo_BC_Equs,[TotalStrain_FilmRef_homo(1,3),TotalStrain_FilmRef_homo(2,3),TotalStrain_FilmRef_homo(3,3)]);
Macroscopic_Homo_BC_Equs_Solutions.TotalStrain_FilmRef_homo_13
Macroscopic_Homo_BC_Equs_Solutions.TotalStrain_FilmRef_homo_23
Macroscopic_Homo_BC_Equs_Solutions.TotalStrain_FilmRef_homo_33

%% Displacement field -> stress free film boundary conditions
% -C_FilmRef_i3kl * u_k,l A - eigenstrain_kl
bc_film_FilmRef_k = sym(zeros(3,1));

u_FilmRef_A_k = [sym('u_1_A_k'), sym('u_2_A_k'), sym('u_3_A_k')];
k_vectors = [sym('kx_grid_3D'), sym('ky_grid_3D'), sym('kz_grid_3D')];

for i = 1 : 3
    for k = 1 : 3
    for l = 1 : 3
        bc_film_FilmRef_k(i) = bc_film_FilmRef_k(i) + -C_FilmRef(i,3,k,l) * ( u_FilmRef_A_k(k) * k_vectors(l) * 1i - Eigenstrain_FilmRef_k(k,l) );
    end
    end
end

%% Total Strain
TotalStrain_FilmRef = sym(zeros(3,3)); % strain in transformed axes
TotalStrain_FilmRef(1,1) = sym('TotalStrain_FilmRef_11');
TotalStrain_FilmRef(2,2) = sym('TotalStrain_FilmRef_22');
TotalStrain_FilmRef(3,3) = sym('TotalStrain_FilmRef_33');
TotalStrain_FilmRef(1,2) = sym('TotalStrain_FilmRef_12');
TotalStrain_FilmRef(1,3) = sym('TotalStrain_FilmRef_13');
TotalStrain_FilmRef(2,3) = sym('TotalStrain_FilmRef_23');
TotalStrain_FilmRef(2,1) = TotalStrain_FilmRef(1,2);
TotalStrain_FilmRef(3,1) = TotalStrain_FilmRef(1,3);
TotalStrain_FilmRef(3,2) = TotalStrain_FilmRef(2,3);

%% elastic strain transformed
Elastic_Strain_FilmRef = sym(zeros(3,3)); % elastic strain e

for i = 1 : 3
for j = 1 : 3
    Elastic_Strain_FilmRef(i,j) = TotalStrain_FilmRef(i,j) - Eigenstrain_FilmRef(i,j);
end
end

%% Elastic energy

f_elastic = sym(0);
for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
    
    f_elastic = 0.5 * C_FilmRef(i,j,k,l) * Elastic_Strain_FilmRef(i,j) * Elastic_Strain_FilmRef(k,l) + f_elastic;
    
end
end
end
end

simplified_f_elastic = collect(expand(f_elastic),[TotalStrain_FilmRef(1,1),TotalStrain_FilmRef(2,2),TotalStrain_FilmRef(3,3),TotalStrain_FilmRef(1,2),TotalStrain_FilmRef(1,3),TotalStrain_FilmRef(2,3),P1_FilmRef,P2_FilmRef,P3_FilmRef]);
simplified_f_elastic_latex = latex(simplified_f_elastic);
simplified_f_elastic_latex = convert_latex(simplified_f_elastic_latex);

f_elastic_P1 = diff(f_elastic,P1_FilmRef);
f_elastic_P1 = collect(expand(f_elastic_P1),[TotalStrain_FilmRef(1,1),TotalStrain_FilmRef(2,2),TotalStrain_FilmRef(3,3),TotalStrain_FilmRef(1,2),TotalStrain_FilmRef(1,3),TotalStrain_FilmRef(2,3),P1_FilmRef,P2_FilmRef,P3_FilmRef]);
simplified_f_elastic_1_latex = convert_latex(latex(f_elastic_P1));


f_elastic_P2 = diff(f_elastic,P2_FilmRef);
f_elastic_P2 = collect(expand(f_elastic_P2),[TotalStrain_FilmRef(1,1),TotalStrain_FilmRef(2,2),TotalStrain_FilmRef(3,3),TotalStrain_FilmRef(1,2),TotalStrain_FilmRef(1,3),TotalStrain_FilmRef(2,3),P1_FilmRef,P2_FilmRef,P3_FilmRef]);

f_elastic_P3 = diff(f_elastic,P3_FilmRef);
f_elastic_P3 = collect(expand(f_elastic_P3),[TotalStrain_FilmRef(1,1),TotalStrain_FilmRef(2,2),TotalStrain_FilmRef(3,3),TotalStrain_FilmRef(1,2),TotalStrain_FilmRef(1,3),TotalStrain_FilmRef(2,3),P1_FilmRef,P2_FilmRef,P3_FilmRef]);


%% Electrostatic equation unchanged if isotropic kappa
Kappa_CrystalRef = sym(zeros(3,3));
Kappa_CrystalRef(1,1) = sym('k_electric_11');
Kappa_CrystalRef(2,2) = sym('k_electric_11');
Kappa_CrystalRef(3,3) = sym('k_electric_11');

Kappa_FilmRef = sym(zeros(3,3));

for i = 1 : 3
for j = 1 : 3
    for m = 1 : 3
    for n = 1 : 3
        Kappa_FilmRef(i,j) = Kappa_FilmRef(i,j) + Transform_Matrix(i,m) * Transform_Matrix(j,n) * Kappa_CrystalRef(m,n);
    end
    end
end
end

%% Test Kappa_FilmRef is isotropic
Kappa_FilmRef

% electrostatic equation has on the denominator -k_i * k_j * kappa_transformed_ij
electrostatic_denominator = sym(0);
fourier_vector = [sym('v1'),sym('v2'),sym('v3')];

for i = 1 : 3
for j = 1 : 3
    electrostatic_denominator = electrostatic_denominator + - fourier_vector(i) * fourier_vector(j) * Kappa_FilmRef(i,j);
end
end