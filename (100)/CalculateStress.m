% Calculate Hetero Stress, Hetero Elastic Stress

% Elastic Strain = Total Strain (A + B) - Eigenstrain - HomoStrain
ElasticStrain_11 = TotalStrain_11 - Eigenstrain_11 - TotalStrain_homo_11(P1,P2,P3);
ElasticStrain_22 = TotalStrain_22 - Eigenstrain_22 - TotalStrain_homo_22(P1,P2,P3);
ElasticStrain_33 = TotalStrain_33 - Eigenstrain_33 - TotalStrain_homo_33(P1,P2,P3);
ElasticStrain_12 = TotalStrain_12 - Eigenstrain_12 - TotalStrain_homo_12(P1,P2,P3);
ElasticStrain_13 = TotalStrain_13 - Eigenstrain_13 - TotalStrain_homo_13(P1,P2,P3);
ElasticStrain_23 = TotalStrain_23 - Eigenstrain_23 - TotalStrain_homo_23(P1,P2,P3);

% Hetero Stress = C_ijkl * ElasticStrain_kl
HeteroStress_11 = ElasticStrain_11*C(1, 1, 1, 1) + ElasticStrain_12*C(1, 1, 1, 2) + ElasticStrain_12*C(1, 1, 2, 1) + ElasticStrain_13*C(1, 1, 1, 3) + ElasticStrain_13*C(1, 1, 3, 1) + ElasticStrain_22*C(1, 1, 2, 2) + ElasticStrain_23*C(1, 1, 2, 3) + ElasticStrain_23*C(1, 1, 3, 2) + ElasticStrain_33*C(1, 1, 3, 3);
HeteroStress_22 = ElasticStrain_11*C(2, 2, 1, 1) + ElasticStrain_12*C(2, 2, 1, 2) + ElasticStrain_12*C(2, 2, 2, 1) + ElasticStrain_13*C(2, 2, 1, 3) + ElasticStrain_13*C(2, 2, 3, 1) + ElasticStrain_22*C(2, 2, 2, 2) + ElasticStrain_23*C(2, 2, 2, 3) + ElasticStrain_23*C(2, 2, 3, 2) + ElasticStrain_33*C(2, 2, 3, 3);
HeteroStress_33 = ElasticStrain_11*C(3, 3, 1, 1) + ElasticStrain_12*C(3, 3, 1, 2) + ElasticStrain_12*C(3, 3, 2, 1) + ElasticStrain_13*C(3, 3, 1, 3) + ElasticStrain_13*C(3, 3, 3, 1) + ElasticStrain_22*C(3, 3, 2, 2) + ElasticStrain_23*C(3, 3, 2, 3) + ElasticStrain_23*C(3, 3, 3, 2) + ElasticStrain_33*C(3, 3, 3, 3);
HeteroStress_12 = ElasticStrain_11*C(1, 2, 1, 1) + ElasticStrain_12*C(1, 2, 1, 2) + ElasticStrain_12*C(1, 2, 2, 1) + ElasticStrain_13*C(1, 2, 1, 3) + ElasticStrain_13*C(1, 2, 3, 1) + ElasticStrain_22*C(1, 2, 2, 2) + ElasticStrain_23*C(1, 2, 2, 3) + ElasticStrain_23*C(1, 2, 3, 2) + ElasticStrain_33*C(1, 2, 3, 3);
HeteroStress_13 = ElasticStrain_11*C(1, 3, 1, 1) + ElasticStrain_12*C(1, 3, 1, 2) + ElasticStrain_12*C(1, 3, 2, 1) + ElasticStrain_13*C(1, 3, 1, 3) + ElasticStrain_13*C(1, 3, 3, 1) + ElasticStrain_22*C(1, 3, 2, 2) + ElasticStrain_23*C(1, 3, 2, 3) + ElasticStrain_23*C(1, 3, 3, 2) + ElasticStrain_33*C(1, 3, 3, 3);
HeteroStress_23 = ElasticStrain_11*C(2, 3, 1, 1) + ElasticStrain_12*C(2, 3, 1, 2) + ElasticStrain_12*C(2, 3, 2, 1) + ElasticStrain_13*C(2, 3, 1, 3) + ElasticStrain_13*C(2, 3, 3, 1) + ElasticStrain_22*C(2, 3, 2, 2) + ElasticStrain_23*C(2, 3, 2, 3) + ElasticStrain_23*C(2, 3, 3, 2) + ElasticStrain_33*C(2, 3, 3, 3);

% TotalStress = HeteroStress + HomoStress
% HomoStress from macroscopic BC
% Thin film: HomoStress_13 = HomoStress_23 = HomoStress_33 = 0