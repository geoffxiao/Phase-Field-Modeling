%% Calculate displacement field
C = sym(zeros(3,3,3,3));

C(1,1,1,1) = sym('C11'); C(2,2,2,2) = sym('C11'); C(3,3,3,3) = sym('C11');
C(1,1,2,2) = sym('C12'); C(1,1,3,3) = sym('C12'); C(2,2,1,1) = sym('C12');
C(2,2,3,3) = sym('C12'); C(3,3,1,1) = sym('C12'); C(3,3,2,2) = sym('C12');
C(1,2,1,2) = sym('C44'); C(2,1,2,1) = sym('C44'); C(1,3,1,3) = sym('C44');
C(3,1,3,1) = sym('C44'); C(2,3,2,3) = sym('C44'); C(3,2,3,2) = sym('C44');
C(1,2,2,1) = sym('C44'); C(2,1,1,2) = sym('C44'); C(1,3,3,1) = sym('C44');
C(3,1,1,3) = sym('C44'); C(2,3,3,2) = sym('C44'); C(3,2,2,3) = sym('C44');

e = sym(zeros(3,3));
e(1,1) = sym( 'e_11' );
e(2,2) = sym( 'e_22' );
e(3,3) = sym( 'e_33' );
e(2,3) = sym( 'e_23' );
e(1,3) = sym( 'e_13' );
e(1,2) = sym( 'e_12' );
e(3,2) = e(2,3);
e(3,1) = e(1,3);
e(2,1) = e(1,2);


s = sym(zeros(3,3));
for i = 1 : 3
for j = 1 : 3
    for k = 1 : 3
    for l = 1 : 3
        s(i,j) = s(i,j) + C(i,j,k,l) * e(k,l);
    end
    end
end
end

%%
%% Calculate displacement field
C = sym(zeros(3,3,3,3));

for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
    C(i,j,k,l) = sprintf('C(%d,%d,%d,%d)', i, j, k, l);
end
end
end
end

e = sym(zeros(3,3));
e(1,1) = sym( 'ElasticStrain_11' );
e(2,2) = sym( 'ElasticStrain_22' );
e(3,3) = sym( 'ElasticStrain_33' );
e(2,3) = sym( 'ElasticStrain_23' );
e(1,3) = sym( 'ElasticStrain_13' );
e(1,2) = sym( 'ElasticStrain_12' );
e(3,2) = e(2,3);
e(3,1) = e(1,3);
e(2,1) = e(1,2);

s = sym(zeros(3,3));
for i = 1 : 3
for j = 1 : 3
    for k = 1 : 3
    for l = 1 : 3
        s(i,j) = s(i,j) + C(i,j,k,l) * e(k,l);
    end
    end
end
end


%% Elastic Energy
F_ela = 0;

for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
    
   F_ela = F_ela + 0.5 * C(i,j,k,l) * e(i,j) * e(k,l);
    
end
end
end
end

collect(F_ela,['C11','C12','C44'])

%%


% Green's Tensor, k-space dependent Tensor (matrix)
Green = sym(zeros(3,3));
Green(1,1) = sym('Green(k1,k2,k3,1,1)'); Green(1,2) = sym('Green(k1,k2,k3,1,2)'); Green(1,3) = sym('Green(k1,k2,k3,1,3)');
Green(2,1) = sym('Green(k1,k2,k3,2,1)'); Green(2,2) = sym('Green(k1,k2,k3,2,2)'); Green(2,3) = sym('Green(k1,k2,k3,2,3)');
Green(3,1) = sym('Green(k1,k2,k3,3,1)'); Green(3,2) = sym('Green(k1,k2,k3,3,2)'); Green(3,3) = sym('Green(k1,k2,k3,3,3)');

%%
% Eigenstrain
% Eigenstress_ijkl = C_ijkl * Eigestrain_ijkl
Eigenstrain = sym(zeros(3,3));
Eigenstrain(1,1) = sym( 'Eigenstrain_11_k(k1,k2,k3)' );
Eigenstrain(2,2) = sym( 'Eigenstrain_22_k(k1,k2,k3)' );
Eigenstrain(3,3) = sym( 'Eigenstrain_33_k(k1,k2,k3)' );
Eigenstrain(2,3) = sym( 'Eigenstrain_23_k(k1,k2,k3)' );
Eigenstrain(1,3) = sym( 'Eigenstrain_13_k(k1,k2,k3)' );
Eigenstrain(1,2) = sym( 'Eigenstrain_12_k(k1,k2,k3)' );
Eigenstrain(3,2) = Eigenstrain(2,3);
Eigenstrain(3,1) = Eigenstrain(1,3);
Eigenstrain(2,1) = Eigenstrain(1,2);


% Fourier space vector
k_vec = sym(zeros(3,1)); k_vec(1) = sym('kx_grid(k1,k2,k3)'); k_vec(2) = sym('ky_grid(k1,k2,k3)'); k_vec(3) = sym('kz_grid(k1,k2,k3)');
u_mat = sym(zeros(3,1));
for i = 1 : 3
    for m = 1 : 3
    for j = 1 : 3
    for k = 1 : 3
    for l = 1 : 3

        u_mat(i) = u_mat(i) + sym('-1i') * Green(i,j) * C(j,m,k,l) * Eigenstrain(k,l) * k_vec(m);

    end
    end
    end
    end
end


%% Test if a solution
C = sym(zeros(3,3,3,3));

C(1,1,1,1) = sym('C11'); C(2,2,2,2) = sym('C11'); C(3,3,3,3) = sym('C11');
C(1,1,2,2) = sym('C12'); C(1,1,3,3) = sym('C12'); C(2,2,1,1) = sym('C12');
C(2,2,3,3) = sym('C12'); C(3,3,1,1) = sym('C12'); C(3,3,2,2) = sym('C12');
C(1,2,1,2) = sym('C44'); C(2,1,2,1) = sym('C44'); C(1,3,1,3) = sym('C44');
C(3,1,3,1) = sym('C44'); C(2,3,2,3) = sym('C44'); C(3,2,3,2) = sym('C44');
C(1,2,2,1) = sym('C44'); C(2,1,1,2) = sym('C44'); C(1,3,3,1) = sym('C44');
C(3,1,1,3) = sym('C44'); C(2,3,3,2) = sym('C44'); C(3,2,2,3) = sym('C44');

LHS = sym(zeros(3,1));
RHS = sym(zeros(3,1));

% Eigenstrain
Eigenstrain_k_space = sym(zeros(3,3));
Eigenstrain_k_space(1,1) = sym( 'Eigenstrain_11_k' );
Eigenstrain_k_space(2,2) = sym( 'Eigenstrain_22_k' );
Eigenstrain_k_space(3,3) = sym( 'Eigenstrain_33_k' );
Eigenstrain_k_space(2,3) = sym( 'Eigenstrain_23_k' );
Eigenstrain_k_space(1,3) = sym( 'Eigenstrain_13_k' );
Eigenstrain_k_space(1,2) = sym( 'Eigenstrain_12_k' );
Eigenstrain_k_space(3,2) = Eigenstrain_k_space(2,3);
Eigenstrain_k_space(3,1) = Eigenstrain_k_space(1,3);
Eigenstrain_k_space(2,1) = Eigenstrain_k_space(1,2);

e_k_space = sym(zeros(3,3));
e_k_space(1,1) = sym('e_11_k');
e_k_space(2,2) = sym('e_22_k');
e_k_space(3,3) = sym('e_33_k');
e_k_space(1,2) = sym('e_12_k');
e_k_space(1,3) = sym('e_13_k');
e_k_space(2,3) = sym('e_23_k');
e_k_space(3,2) = e_k_space(2,3);
e_k_space(3,1) = e_k_space(1,3);
e_k_space(2,1) = e_k_space(1,2);

u_k_space = [ sym('u_1_k'); sym('u_2_k'); sym('u_3_k') ];

k_mat = [ sym('kx_grid'); sym('ky_grid'); sym('kz_grid') ];

for i = 1 : 3
    for j = 1 : 3
    for k = 1 : 3
    for l = 1 : 3

        LHS(i) = LHS(i) + C(i,j,k,l) * u_k_space(k) * k_mat(j) * k_mat(l);
        RHS(i) = RHS(i) + -1i * C(i,j,k,l) * Eigenstrain_k_space(k,l) * k_mat(j);

    end
    end
    end
end

%% Eigenstrain calculate strain using Green's tensor
Eigenstrain_k_space = sym(zeros(3,3));
Eigenstrain_k_space(1,1) = sym( 'Eigenstrain_11_k(k1,k2,k3)' );
Eigenstrain_k_space(2,2) = sym( 'Eigenstrain_22_k(k1,k2,k3)' );
Eigenstrain_k_space(3,3) = sym( 'Eigenstrain_33_k(k1,k2,k3)' );
Eigenstrain_k_space(2,3) = sym( 'Eigenstrain_23_k(k1,k2,k3)' );
Eigenstrain_k_space(1,3) = sym( 'Eigenstrain_13_k(k1,k2,k3)' );
Eigenstrain_k_space(1,2) = sym( 'Eigenstrain_12_k(k1,k2,k3)' );
Eigenstrain_k_space(3,2) = Eigenstrain_k_space(2,3);
Eigenstrain_k_space(3,1) = Eigenstrain_k_space(1,3);
Eigenstrain_k_space(2,1) = Eigenstrain_k_space(1,2);

e_ij_k = sym(zeros(3,3));
k_vec = sym(zeros(3,1)); k_vec(1) = sym('kx_grid_3D(k1,k2,k3)'); k_vec(2) = sym('ky_grid_3D(k1,k2,k3)'); k_vec(3) = sym('kz_grid_3D(k1,k2,k3)');

for i = 1 : 3
for j = 1 : 3
    for n = 1 : 3
    for m = 1 : 3
        for k = 1 : 3
        for l = 1 : 3

            e_ij_k(i,j) = e_ij_k(i,j) + 0.5 * (k_vec(j) * Green(i,n) + k_vec(i) * Green(j,n)) * k_vec(m) * C(n,m,k,l) * Eigenstrain_k_space(k,l);

        end
        end
    end
    end
end
end

%% Strain using eigenstress
e_ij_k = sym(zeros(3,3));
k_vec = sym(zeros(3,1)); k_vec(1) = sym('kx_grid_3D(k1,k2,k3)'); k_vec(2) = sym('ky_grid_3D(k1,k2,k3)'); k_vec(3) = sym('kz_grid_3D(k1,k2,k3)');

Eigenstress_k_space = sym(zeros(3,3));
Eigenstress_k_space(1,1) = sym( 'Eigenstress_11_k(k1,k2,k3)' );
Eigenstress_k_space(2,2) = sym( 'Eigenstress_22_k(k1,k2,k3)' );
Eigenstress_k_space(3,3) = sym( 'Eigenstress_33_k(k1,k2,k3)' );
Eigenstress_k_space(2,3) = sym( 'Eigenstress_23_k(k1,k2,k3)' );
Eigenstress_k_space(1,3) = sym( 'Eigenstress_13_k(k1,k2,k3)' );
Eigenstress_k_space(1,2) = sym( 'Eigenstress_12_k(k1,k2,k3)' );
Eigenstress_k_space(3,2) = Eigenstress_k_space(2,3);
Eigenstress_k_space(3,1) = Eigenstress_k_space(1,3);
Eigenstress_k_space(2,1) = Eigenstress_k_space(1,2);
for i = 1 : 3
for j = 1 : 3
    for n = 1 : 3
    for m = 1 : 3

        e_ij_k(i,j) = e_ij_k(i,j) + 0.5 * (k_vec(j) * Green(i,n) + k_vec(i) * Green(j,n)) * k_vec(m) * Eigenstress_k_space(n,m);

    end
    end
end
end

        
%% Real space verification

% C_ijkl*d^2u_k/dr_j*dr_l = C_ijkl*dEigen_kl/dr_j
% u_diff_mat(j,l,k) --> u_k,jl --> d^2u_k/dr_j*dr_l
u_diff_mat = sym(zeros(3,3,3));
Eigenstrain_diff_mat = sym(zeros(3,3,3));

for k = 1 : 3
for l = 1 : 3
for j = 1 : 3
   
    Eigenstrain_diff_mat(k,l,j) = sym(sprintf('Eigenstrain_%g%g_d%g',k,l,j));
    u_diff_mat(k,l,j) = sym(sprintf('u_%g_d%g_d%g',k,l,j));
    
end
end
end

LHS = sym(zeros(3,1));
RHS = sym(zeros(3,1));

for i = 1 : 3
    for k = 1 : 3
    for j = 1 : 3
    for l = 1 : 3
    
        LHS(i) = LHS(i) + C(i,j,k,l) * u_diff_mat(k,l,j);
        RHS(i) = RHS(i) + C(i,j,k,l) * Eigenstrain_diff_mat(k,l,j);
    
    end
    end
    end
end


ks = ['x', 'y', 'z'];

for k = 1 : 3
for l = 1 : 3
for j = 1 : 3
   
    fprintf('u_%g_d%g_d%g = real(ifftn(u_%g .* -1 .* k%c_grid_3D .* k%c_grid_3D));',k,l,j,k,ks(l),ks(j));
    fprintf('\n');
end
end
end

for k = 1 : 3
for l = 1 : 3
for j = 1 : 3
   
    fprintf('Eigenstrain_%g%g_d%g = real(ifftn(Eigenstrain_%g%g .* 1i .* k%c_grid_3D));',k,l,j,k,l,ks(j));
    fprintf('\n');
end
end
end
%% YuLuan Li 2d confirmation
LHS_term1 = sym(zeros(3,1));
LHS_term2 = sym(zeros(3,1));
LHS_term3 = sym(zeros(3,1));
LHS = sym(zeros(3,1));

u_kspace_term1 = [sym('u_1_B_k'),       sym('u_2_B_k'),       sym('u_3_B_k')];
u_kspace_term2 = [sym('u_1_B_k_d3'),    sym('u_2_B_k_d3'),    sym('u_3_B_k_d3')];
u_kspace_term3 = [sym('u_1_B_k_d3_d3'), sym('u_2_B_k_d3_d3'), sym('u_3_B_k_d3_d3')];

k_2D = [sym('kx_grid_3D'),sym('ky_grid_3D')];

for i = 1 : 3
    
    for k = 1 : 3
    for alpha = 1 : 2
    for beta = 1 : 2
        LHS_term1(i) = LHS_term1(i) + C(i,alpha,k,beta) * 1i * k_2D(alpha) * 1i * k_2D(beta) * u_kspace_term1(k);
    end
    end
    end
    
    for k = 1 : 3
    for alpha = 1 : 2
        LHS_term2(i) = LHS_term2(i) + ( C(i,alpha,k,3) + C(i,3,k,alpha) ) * 1i * k_2D(alpha) * u_kspace_term2(k);        
    end
    end
 
    for k = 1 : 3
        LHS_term3(i) = LHS_term3(i) + C(i,3,k,3) * u_kspace_term3(k);
    end
    
end

for i = 1 : 3
    LHS(i) = LHS_term1(i) + LHS_term2(i) + LHS_term3(i);
end


%% Calculating hetero stress from hetero strain
% sigma_ij = C_ijkl * ( 1i * k_l * u_k - eigenstrain_kl )
sigma2_ij = sym(zeros(3,3));
u_k_space = [ sym('u_1_k'); sym('u_2_k'); sym('u_3_k') ];
k_mat = [ sym('kx_grid'); sym('ky_grid'); sym('kz_grid') ];

for i = 1 : 3
for j = 1 : 3
    
    for k = 1 : 3
    for l = 1 : 3
        sigma2_ij(i,j) = sigma2_ij(i,j) + C(i,j,k,l) * ...
            ( 0.5 * 1i * k_mat(l) * u_k_space(k) + 0.5 * 1i * k_mat(k) * u_k_space(l)  - Eigenstrain_k_space(k,l));
    end
    end
    
end
end

%% Calculating hetero stress from hetero strain
C = sym(zeros(3,3,3,3));

C(1,1,1,1) = sym('C11'); C(2,2,2,2) = sym('C11'); C(3,3,3,3) = sym('C11');
C(1,1,2,2) = sym('C12'); C(1,1,3,3) = sym('C12'); C(2,2,1,1) = sym('C12');
C(2,2,3,3) = sym('C12'); C(3,3,1,1) = sym('C12'); C(3,3,2,2) = sym('C12');
C(1,2,1,2) = sym('C44'); C(2,1,2,1) = sym('C44'); C(1,3,1,3) = sym('C44');
C(3,1,3,1) = sym('C44'); C(2,3,2,3) = sym('C44'); C(3,2,3,2) = sym('C44');
C(1,2,2,1) = sym('C44'); C(2,1,1,2) = sym('C44'); C(1,3,3,1) = sym('C44');
C(3,1,1,3) = sym('C44'); C(2,3,3,2) = sym('C44'); C(3,2,2,3) = sym('C44');

% Eigenstrain
Eigenstrain_k_space = sym(zeros(3,3));
Eigenstrain_k_space(1,1) = sym( 'Eigenstrain_11_k' );
Eigenstrain_k_space(2,2) = sym( 'Eigenstrain_22_k' );
Eigenstrain_k_space(3,3) = sym( 'Eigenstrain_33_k' );
Eigenstrain_k_space(2,3) = sym( 'Eigenstrain_23_k' );
Eigenstrain_k_space(1,3) = sym( 'Eigenstrain_13_k' );
Eigenstrain_k_space(1,2) = sym( 'Eigenstrain_12_k' );
Eigenstrain_k_space(3,2) = Eigenstrain_k_space(2,3);
Eigenstrain_k_space(3,1) = Eigenstrain_k_space(1,3);
Eigenstrain_k_space(2,1) = Eigenstrain_k_space(1,2);

% sigma_ij = C_ijkl * ( 1i * k_l * u_k - eigenstrain_kl )
sigma_ij = sym(zeros(3,3));
u_k_space = [ sym('u_1_k'); sym('u_2_k'); sym('u_3_k') ];
k_mat = [ sym('kx_grid_3D'); sym('ky_grid_3D'); sym('kz_grid_3D') ];

for i = 1 : 3
for j = 1 : 3
    
    for k = 1 : 3
    for l = 1 : 3
        sigma_ij(i,j) = sigma_ij(i,j) + C(i,j,k,l) * ( 1i * k_mat(l) * u_k_space(k) - Eigenstrain_k_space(k,l));
    end
    end
    
end
end

%% BC condition for het. strain
C = sym(zeros(3,3,3,3));

C(1,1,1,1) = sym('C11'); C(2,2,2,2) = sym('C11'); C(3,3,3,3) = sym('C11');
C(1,1,2,2) = sym('C12'); C(1,1,3,3) = sym('C12'); C(2,2,1,1) = sym('C12');
C(2,2,3,3) = sym('C12'); C(3,3,1,1) = sym('C12'); C(3,3,2,2) = sym('C12');
C(1,2,1,2) = sym('C44'); C(2,1,2,1) = sym('C44'); C(1,3,1,3) = sym('C44');
C(3,1,3,1) = sym('C44'); C(2,3,2,3) = sym('C44'); C(3,2,3,2) = sym('C44');
C(1,2,2,1) = sym('C44'); C(2,1,1,2) = sym('C44'); C(1,3,3,1) = sym('C44');
C(3,1,1,3) = sym('C44'); C(2,3,3,2) = sym('C44'); C(3,2,2,3) = sym('C44');

BC_film = sym(zeros(3,1));
u_A_k_space = [ sym('u_1_A_k'); sym('u_2_A_k'); sym('u_3_A_k') ];
k_mat = [ sym('kx_grid'); sym('ky_grid'); sym('kz_grid') ];
Eigenstrain_k_space;

for i = 1 : 3
    
    for k = 1 : 3
    for l = 1 : 3
    
        BC_film(i) = BC_film(i) + -C(i,3,k,l) * ( u_A_k_space(k) * 1i * k_mat(l) - Eigenstrain_k_space(k,l) );
        
    end
    end
    
end

%% Expand elastic energy
P1 = sym('P1'); P2 = sym('P2'); P3 = sym('P3');

C = sym(zeros(3,3,3,3));

C(1,1,1,1) = sym('C11'); C(2,2,2,2) = sym('C11'); C(3,3,3,3) = sym('C11');
C(1,1,2,2) = sym('C12'); C(1,1,3,3) = sym('C12'); C(2,2,1,1) = sym('C12');
C(2,2,3,3) = sym('C12'); C(3,3,1,1) = sym('C12'); C(3,3,2,2) = sym('C12');
C(1,2,1,2) = sym('C44'); C(2,1,2,1) = sym('C44'); C(1,3,1,3) = sym('C44');
C(3,1,3,1) = sym('C44'); C(2,3,2,3) = sym('C44'); C(3,2,3,2) = sym('C44');
C(1,2,2,1) = sym('C44'); C(2,1,1,2) = sym('C44'); C(1,3,3,1) = sym('C44');
C(3,1,1,3) = sym('C44'); C(2,3,3,2) = sym('C44'); C(3,2,2,3) = sym('C44');

Q11 = sym('Q11'); Q12 = sym('Q12'); Q44 = sym('Q44');

e_ij = [sym('e_11'), sym('e_12'), sym('e_13'); ... 
        sym('e_21'), sym('e_22'), sym('e_23'); ... 
        sym('e_31'), sym('e_32'), sym('e_33')];
Eigenstrain = sym(zeros(3,3));
Eigenstrain(1,1) = sym( 'Q11 * P1^2 + Q12 * (P2^2 + P3^2);' );
Eigenstrain(2,2) = sym( 'Q11 * P2^2 + Q12 * (P1^2 + P3^2)' );
Eigenstrain(3,3) = sym( 'Q11 * P3^2 + Q12 * (P1^2 + P2^2)' );
Eigenstrain(2,3) = sym( 'Q44 * P2 * P3' );
Eigenstrain(1,3) = sym( 'Q44 * P1 * P3' );
Eigenstrain(1,2) = sym( 'Q44 * P2 * P1' );
Eigenstrain(3,2) = Eigenstrain(2,3);
Eigenstrain(3,1) = Eigenstrain(1,3);
Eigenstrain(2,1) = Eigenstrain(1,2);

tot = sym('0');
for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
   
    tot = tot + 0.5 * C(i,j,k,l) * (e_ij(i,j) - Eigenstrain(i,j)) * (e_ij(k,l) - Eigenstrain(k,l));
    
end
end
end
end

tot_1 = diff(tot,P1);
tot_2 = diff(tot,P2);
tot_3 = diff(tot,P3);


%% 
e_k_lj = sym(zeros(3,3,3));
for k = 1 : 3
for l = 1 : 3
for j = 1 : 3
    e_k_lj(k,l,j) = sym(sprintf('u%g%g_%g',k,l,j));
end
end
end

i = 1;
tot = 0;
for k = 1 : 3
for l = 1 : 3
for j = 1 : 3

    tot = tot + C(i,j,k,l) * e_k_lj(k,l,j);

end
end
end


%%
% Green's Tensor,
Green = sym(zeros(3,3));
Green(1,1) = sym('G_11');
Green(2,2) = sym('G_22');
Green(3,3) = sym('G_33');
Green(1,2) = sym('G_12');
Green(1,3) = sym('G_13');
Green(2,3) = sym('G_23');
Green(2,1) = Green(1,2);
Green(3,1) = Green(1,3);
Green(3,2) = Green(2,3);

sigma = sym(zeros(3,3));
sigma(1,1) = sym('s_11');
sigma(2,2) = sym('s_22');
sigma(3,3) = sym('s_33');
sigma(1,2) = sym('s_12');
sigma(1,3) = sym('s_13');
sigma(2,3) = sym('s_23');
sigma(2,1) = sigma(1,2);
sigma(3,1) = sigma(1,3);
sigma(3,2) = sigma(2,3);

k_vec = [sym('k1'), sym('k2'), sym('k3')];

e_ij = sym(zeros(3,3));

for i = 1 : 3
for j = 1 : 3
   for n = 1 : 3
   for m = 1 : 3
      
       e_ij(i,j) = e_ij(i,j) + 0.5 * (k_vec(j) * Green(i,n) + k_vec(i) * Green(j,n)) * k_vec(m) * sigma(n,m);
       
   end
   end
end
end


%%

Z_k = sym(zeros(3,1));
e_grids = [sym('ex_3D'), sym('ey_3D'), sym('ez_3D')];
d_k = [sym('d1_k'), sym('d2_k'), sym('d3_k')];

L_k = sym(zeros(3,3));

for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
   L_k(i,j,k) = sym(sprintf('squeeze(L_k(%g,%g,%g))',i,j,k));
end
end
end

N_k = sym(zeros(3,3));
for m = 1 : 3
for p = 1 : 3
    for j = 1 : 3

        N_k(m,p) = N_k(m,p) + e_grids(j) * L_k(m,j,p);

    end
end
end

for p = 1 : 3
    for m = 1 : 3

        Z_k(p) = Z_k(p) + e_grids(m) * N_k(m,p) / d_k(m);

    end
end

V_k = sym(zeros(3,3));
for i = 1 : 3
for j = 1 : 3
   
    V_k(i,j) = sym(sprintf('V_k%g%g',i,j));
    
end
end

k_grids = [sym('kx_grid_3D'), sym('ky_grid_3D'), sym('kz_grid_3D')];

B_k_mnp = sym(zeros(3,3,3));
for n = 1 : 3
for m = 1 : 3
for p = 1 : 3
   
    B_k_mnp(m,n,p) = 0.5 * ( 1i * k_grids(n) * V_k(m,p) + 1i * k_grids(m) * V_k(n,p) );
    
end
end
end

tot = '';
for m = 1 : 3
for n = 1 : 3
for p = 1 : 3
   
    fprintf('B_k_mnp(:,:,:,%g,%g,%g)=%s\n',m,n,p,char(B_k_mnp(m,n,p)))
    
end
end
end

%%
syms C11 Q11 C12 Q12 q11 q12
eqns = [C11*Q11+2*C12*Q12 == q11, q12 == C11*Q12 + C12*(Q11+Q12)];
vars = [Q11,Q12];
[a,b] = solve(eqns,vars);

q11_h = q11 + 2 * q12;
q22_h = q11 - q12;

C11_h = C11 + 2 * C12;
C22_h = C11 - C12;

simplify((1/3) * ((q11_h/C11_h) + (2*q22_h/C22_h)) - a)
simplify((1/3) * ((q11_h/C11_h) - (q22_h/C22_h)) - b)

%% Calculate displacement field
q = sym(zeros(3,3,3,3));

q(1,1,1,1) = sym('q11'); q(2,2,2,2) = sym('q11'); q(3,3,3,3) = sym('q11');
q(1,1,2,2) = sym('q12'); q(1,1,3,3) = sym('q12'); q(2,2,1,1) = sym('q12');
q(2,2,3,3) = sym('q12'); q(3,3,1,1) = sym('q12'); q(3,3,2,2) = sym('q12');
q(1,2,1,2) = sym('q44/2'); q(2,1,2,1) = sym('q44/2'); q(1,3,1,3) = sym('q44/2');
q(3,1,3,1) = sym('q44/2'); q(2,3,2,3) = sym('q44/2'); q(3,2,3,2) = sym('q44/2');
q(1,2,2,1) = sym('q44/2'); q(2,1,1,2) = sym('q44/2'); q(1,3,3,1) = sym('q44/2');
q(3,1,1,3) = sym('q44/2'); q(2,3,3,2) = sym('q44/2'); q(3,2,2,3) = sym('q44/2');

L = sym(zeros(3,3,3));

delta = sym(eye(3,3));

P = [sym('P1'), sym('P2'), sym('P3')];

for m = 1 : 3
for j = 1 : 3
for p = 1 : 3
    for k = 1 : 3
    for l = 1 : 3
        
        L(m,j,p) = L(m,j,p) + q(m,j,k,l) * ( delta(k,p) * P(l) + P(k) * delta(l,p) );
    
    end
    end
end
end
end

%%
A=sym(zeros(6,6));
q22_h = sym('q22_h');
q12 = sym('q12');
q11 = sym('q11');
q44 = sym('q44');

B = sym(zeros(3,3));
for i = 1 : 6
for j = 1 : 6
    B(i,j) = sym(sprintf('B_%g%g',i,j));
end
end

% p = 1,2,3 ... A_pp
    for p = 1 : 3
        A(p,p) = q22_h^2*B(p,p) + A(p,p);
    end

    for p = 1 : 3
        for o = 1 : 3
            A(p,p) = 2*q12*q22_h*B(p,o) + A(p,p);
        end
    end

    for i = 1 : 3
        for p = 1 : 3
        for o = 1 : 3
            A(i,i) = A(i,i) + q12^2*B(p,o);
        end
        end
    end
    
A(1,2) = q22_h^2 * B(1,2);
for p = 1 : 3 
    A(1,2) = A(1,2) - q12*q22_h*B(p,3);
end

for p = 1 : 3
for o = 1 : 3
    A(1,2) = A(1,2) + q11*q12*B(p,o); 
end
end
A(2,1) = A(1,2);

A(1,3) = q22_h^2 * B(1,3);
for p = 1 : 3 
    A(1,3) = A(1,3) - q12*q22_h*B(p,2);
end

for p = 1 : 3
for o = 1 : 3
    A(1,3) = A(1,3) + q11*q12*B(p,o); 
end
end
A(3,1) = A(1,3);

A(2,3) = q22_h^2 * B(2,3);
for p = 1 : 3 
    A(2,3) = A(2,3) - q12*q22_h*B(p,1);
end

for p = 1 : 3
for o = 1 : 3
    A(2,3) = A(2,3) + q11*q12*B(p,o); 
end
end
A(3,2) = A(2,3);

% o = 4,5,6
for o = 4:6
    
   A(1,o) = q22_h*q44*B(1,o); 
   
   for p = 1 : 3
        A(1,o) = A(1,o) + q12*q44*B(p,o);
   end
   
end


% o = 4,5,6
for o = 4:6
    
   A(2,o) = q22_h*q44*B(2,o); 
  
   for p = 1 : 3
        A(2,o) = A(2,o) + q12*q44*B(p,o);
   end
   
end

% o = 4,5,6
for o = 4:6
    
   A(3,o) = q22_h*q44*B(3,o); 
  
   for p = 1 : 3
        A(3,o) = A(3,o) + q12*q44*B(p,o);
   end
   
end

for p = 4 : 6
for o = 4 : 6
   A(p,o) = A(p,o) + q44^2*B(p,o); 
end
end

for i = 1 : 6
for j = 1 : 6
   fprintf('A_%g%g=%s\n',i,j,char(A(i,j)));
end
end

%%
C = sym(zeros(3,3,3,3));

C(1,1,1,1) = sym('C11'); C(2,2,2,2) = sym('C11'); C(3,3,3,3) = sym('C11');
C(1,1,2,2) = sym('C12'); C(1,1,3,3) = sym('C12'); C(2,2,1,1) = sym('C12');
C(2,2,3,3) = sym('C12'); C(3,3,1,1) = sym('C12'); C(3,3,2,2) = sym('C12');
C(1,2,1,2) = sym('C44'); C(2,1,2,1) = sym('C44'); C(1,3,1,3) = sym('C44');
C(3,1,3,1) = sym('C44'); C(2,3,2,3) = sym('C44'); C(3,2,3,2) = sym('C44');
C(1,2,2,1) = sym('C44'); C(2,1,1,2) = sym('C44'); C(1,3,3,1) = sym('C44');
C(3,1,1,3) = sym('C44'); C(2,3,3,2) = sym('C44'); C(3,2,2,3) = sym('C44');

e = sym(zeros(3,3));
for i = 1 : 3
for j = 1 : i
   e(i,j) = sym(sprintf('e_%g%g',i,j)); 
end
end

e(1,2) = e(2,1); e(1,3) = e(3,1); e(2,3) = e(3,2);

tot = sym(zeros(3,1));
for i = 1 : 3
    for k = 1 : 3
    for l = 1 : 3
        tot(i) = tot(i) + C(i,3,k,l) * e(k,l);
    end
    end
end