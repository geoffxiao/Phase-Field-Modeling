%% Eigenstrains
Eigenstrain_11 = Q11 * P1.^2 + Q12 .* (P2.^2 + P3.^2);
Eigenstrain_22 = Q11 * P2.^2 + Q12 .* (P1.^2 + P3.^2);
Eigenstrain_33 = Q11 * P3.^2 + Q12 .* (P1.^2 + P2.^2);
Eigenstrain_23 = q44 * P2 .* P3 / ( 2 * C44 );
Eigenstrain_13 = q44 * P1 .* P3 / ( 2 * C44 );
Eigenstrain_12 = q44 * P1 .* P2 / ( 2 * C44 ); 
Eigenstrain_21 = Eigenstrain_12; Eigenstrain_31 = Eigenstrain_13; Eigenstrain_32 = Eigenstrain_23;

Eigenstrain_11_k = fftn(Eigenstrain_11);
Eigenstrain_22_k = fftn(Eigenstrain_22);
Eigenstrain_33_k = fftn(Eigenstrain_33);
Eigenstrain_23_k = fftn(Eigenstrain_23);
Eigenstrain_13_k = fftn(Eigenstrain_13);
Eigenstrain_12_k = fftn(Eigenstrain_12);
Eigenstrain_21_k = Eigenstrain_12_k; Eigenstrain_31_k = Eigenstrain_13_k; Eigenstrain_32_k = Eigenstrain_23_k;
