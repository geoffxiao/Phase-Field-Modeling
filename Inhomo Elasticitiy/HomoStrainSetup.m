% Macroscopic BC, stress free eigenstrain
% TotalStrain_11_homo = @(P1, P2, P3) Q11 .* vol_avg(P1.^2) + Q12 .* (vol_avg(P2.^2) + vol_avg(P3.^2));
% TotalStrain_22_homo = @(P1, P2, P3) Q11 .* vol_avg(P2.^2) + Q12 .* (vol_avg(P3.^2) + vol_avg(P1.^2));
% TotalStrain_33_homo = @(P1, P2, P3) Q11 .* vol_avg(P3.^2) + Q12 .* (vol_avg(P1.^2) + vol_avg(P2.^2));
% TotalStrain_23_homo = @(P1, P2, P3) Q44 .* vol_avg(P2.*P3);
% TotalStrain_13_homo = @(P1, P2, P3) Q44 .* vol_avg(P1.*P3);
% TotalStrain_12_homo = @(P1, P2, P3) Q44 .* vol_avg(P1.*P2);

% TotalStrain_homo_11_func = @(P1, P2, P3) Us_11;
% TotalStrain_homo_22_func = @(P1, P2, P3) Us_22;
% TotalStrain_homo_12_func = @(P1, P2, P3) Us_12;
% TotalStrain_homo_33_func = @(P1, P2, P3) -( C12 * TotalStrain_homo_11_func(P1,P2,P3) + C12 * TotalStrain_homo_22_func(P1,P2,P3) ) / C44;
% TotalStrain_homo_23_func = @(P1, P2, P3) 0;
% TotalStrain_homo_13_func = @(P1, P2, P3) 0;

TotalStrain_homo_11_func = @(P1, P2, P3) 0;
TotalStrain_homo_22_func = @(P1, P2, P3) 0;
TotalStrain_homo_12_func = @(P1, P2, P3) 0;
TotalStrain_homo_33_func = @(P1, P2, P3) 0;
TotalStrain_homo_23_func = @(P1, P2, P3) 0;
TotalStrain_homo_13_func = @(P1, P2, P3) 0;

% TotalStrain_11_homo = @(P1, P2, P3) Us;
% TotalStrain_22_homo = @(P1, P2, P3) Us;
% TotalStrain_12_homo = @(P1, P2, P3) 0;
% TotalStrain_33_homo = @(P1, P2, P3) Q11 .* vol_avg(P3.^2) + Q12 .* (vol_avg(P1.^2) + vol_avg(P2.^2));
% TotalStrain_23_homo = @(P1, P2, P3) Q44 .* vol_avg(P2.*P3);
% TotalStrain_13_homo = @(P1, P2, P3) Q44 .* vol_avg(P1.*P3);