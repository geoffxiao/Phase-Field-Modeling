%%
% C_hom = constant
C11_hom = sym('C11_hom');
C12_hom = sym('C12_hom');
C44_hom = sym('C44_hom');

C_hom(1,1,1,1) = C11_hom; C_hom(2,2,2,2) = C11_hom; C_hom(3,3,3,3) = C11_hom;
C_hom(1,1,2,2) = C12_hom; C_hom(1,1,3,3) = C12_hom; C_hom(2,2,1,1) = C12_hom;
C_hom(2,2,3,3) = C12_hom; C_hom(3,3,1,1) = C12_hom; C_hom(3,3,2,2) = C12_hom;
C_hom(1,2,1,2) = C44_hom; C_hom(2,1,2,1) = C44_hom; C_hom(1,3,1,3) = C44_hom;
C_hom(3,1,3,1) = C44_hom; C_hom(2,3,2,3) = C44_hom; C_hom(3,2,3,2) = C44_hom;
C_hom(1,2,2,1) = C44_hom; C_hom(2,1,1,2) = C44_hom; C_hom(1,3,3,1) = C44_hom;
C_hom(3,1,1,3) = C44_hom; C_hom(2,3,3,2) = C44_hom; C_hom(3,2,2,3) = C44_hom;

%%
% C_het = spatially dependent in real space
C11_het = sym('C11_het_realspace');
C12_het = sym('C12_het_realspace');
C44_het = sym('C44_het_realspace');

C_het_realspace(1,1,1,1) = C11_het; C_het_realspace(2,2,2,2) = C11_het; C_het_realspace(3,3,3,3) = C11_het;
C_het_realspace(1,1,2,2) = C12_het; C_het_realspace(1,1,3,3) = C12_het; C_het_realspace(2,2,1,1) = C12_het;
C_het_realspace(2,2,3,3) = C12_het; C_het_realspace(3,3,1,1) = C12_het; C_het_realspace(3,3,2,2) = C12_het;
C_het_realspace(1,2,1,2) = C44_het; C_het_realspace(2,1,2,1) = C44_het; C_het_realspace(1,3,1,3) = C44_het;
C_het_realspace(3,1,3,1) = C44_het; C_het_realspace(2,3,2,3) = C44_het; C_het_realspace(3,2,3,2) = C44_het;
C_het_realspace(1,2,2,1) = C44_het; C_het_realspace(2,1,1,2) = C44_het; C_het_realspace(1,3,3,1) = C44_het;
C_het_realspace(3,1,1,3) = C44_het; C_het_realspace(2,3,3,2) = C44_het; C_het_realspace(3,2,2,3) = C44_het;

%%
% Green_homo's function in kspace
Green_homo_kspace = sym(zeros(3,3));
Green_homo_kspace(1,1) = sym('Green_homo_k_11'); Green_homo_kspace(2,1) = sym('Green_homo_k_21'); Green_homo_kspace(3,1) = sym('Green_homo_k_31');
Green_homo_kspace(1,2) = sym('Green_homo_k_12'); Green_homo_kspace(2,2) = sym('Green_homo_k_22'); Green_homo_kspace(3,2) = sym('Green_homo_k_32');
Green_homo_kspace(1,3) = sym('Green_homo_k_13'); Green_homo_kspace(2,3) = sym('Green_homo_k_23'); Green_homo_kspace(3,3) = sym('Green_homo_k_33');

%% 
% Eigenstrain calculated in real space
Eigenstrain_realspace = sym(zeros(3,3));
Eigenstrain_realspace(1,1) = sym( 'Eigenstrain_11' );
Eigenstrain_realspace(2,2) = sym( 'Eigenstrain_22' );
Eigenstrain_realspace(3,3) = sym( 'Eigenstrain_33' );
Eigenstrain_realspace(2,3) = sym( 'Eigenstrain_23' );
Eigenstrain_realspace(1,3) = sym( 'Eigenstrain_13' );
Eigenstrain_realspace(1,2) = sym( 'Eigenstrain_12' );
Eigenstrain_realspace(3,2) = Eigenstrain_realspace(2,3);
Eigenstrain_realspace(3,1) = Eigenstrain_realspace(1,3);
Eigenstrain_realspace(2,1) = Eigenstrain_realspace(1,2);

%% 
% homo strain BC = constants
TotalStrain_homo = sym(zeros(3,3));
for i = 1 : 3
for j = 1 : 3
    TotalStrain_homo(i,j) = sym( sprintf('TotalStrain_homo_%g%g',i,j) );
end
end

%% 
% kspace vectors, kx,ky,kz
k_grid = [sym('kx_grid_3D'), sym('ky_grid_3D'), sym('kz_grid_3D')];

%%

u_prev_kspace = [sym('u_1_k_prev'), sym('u_2_k_prev'), sym('u_3_k_prev')]; % previous iteration

% derivative of previous iteration in k space using kspace derivative
u_dl_prev_kspace = sym(zeros(3,3));
for k = 1 : 3
for l = 1 : 3
    u_dl_prev_kspace(k,l) = u_prev_kspace(k) * k_grid(l) * 1i;
end
end

% ifftn the kspace derivative (of prev. iteration) into real space to get real space derivative
u_dl_prev_realspace = sym(zeros(3,3));
for k = 1 : 3
for l = 1 : 3
    u_dl_prev_realspace(k,l) = sym( sprintf( 'real(ifftn(%s))',char(u_dl_prev_kspace(k,l)) ) );
end
end

for k = 1 : 3
for l = 1 : 3
    u_dl_prev_realspace(k,l) = sym( sprintf( 'u_%g_d%g_prev_realspace',k,l) );
end
end

u_next_kspace = sym(zeros(3,1)); % next iteration
for k = 1 : 3
    for i = 1 : 3
    for j = 1 : 3
    for l = 1 : 3
        
        inner = ( (C_hom(i,j,k,l) + C_het_realspace(i,j,k,l)) * ...
            (Eigenstrain_realspace(k,l) - TotalStrain_homo(k,l)) - ...
            C_het_realspace(i,j,k,l) * u_dl_prev_realspace(k,l) );
        if( inner ~= 0 )
            inner = sym( sprintf('fftn( %s )',char(inner)) );
        else
            inner = 0;
        end
        
        u_next_kspace(k) = u_next_kspace(k) + -1i * Green_homo_kspace(i,k) * k_grid(j) * inner;
            
    end
    end
    end
end

%%
for k = 1 : 3
for l = 1 : 3
    equ = 1i * k_grid(l) * u_prev_kspace(k);
    u_dl_prev_realspace(k,l) = sprintf('real(ifftn( %s ))', char(equ));
end 
end


%% Verification
u_kspace = [sym('u_1_k'), sym('u_2_k'), sym('u_3_k')];
LHS_k = sym(zeros(3,1));
RHS_k = sym(zeros(3,1));

u_dl_realspace = sym(zeros(3,3));
for k = 1 : 3
for l = 1 : 3
    u_dl_realspace(k,l) = sym( sprintf( 'u_%g_d%g_realspace',k,l) );
end
end

for i = 1 : 3
    for j = 1 : 3
    for k = 1 : 3
    for l = 1 : 3

        LHS_k(i) = LHS_k(i) + C_hom(i,j,k,l) * (-1) * k_grid(j) * k_grid(l) * u_kspace(k);

        inner = ( (C_hom(i,j,k,l) + C_het_realspace(i,j,k,l)) * ...
        (Eigenstrain_realspace(k,l) - TotalStrain_homo(k,l)) - ...
        C_het_realspace(i,j,k,l) * u_dl_realspace(k,l) );
        if( inner ~= 0 )
            inner = sym( sprintf('fftn( %s )',char(inner)) );
        else
            inner = 0;
        end

        RHS_k(i) = RHS_k(i) + 1i * k_grid(j) * inner;

    end
    end
    end
end