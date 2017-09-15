if( ELASTIC )
    CalculateStrain;

    b11 = 0.5*C11*(Q11^2 + 2*Q12^2) + C12*Q12*(2*Q11 + Q12);
    b12 = C11*Q12*(2*Q11 + Q12) + C12*(Q11^2 + 3*Q12^2 + 2*Q11*Q12) + 2*C44*Q44^2;

    f1_elastic = -( (q11.*TotalStrain_11 + q12.*TotalStrain_22 + q12.*TotalStrain_33) .* (2.*P1) + 2.*q44.*(TotalStrain_12 .* P2 + TotalStrain_13 .* P3) ) + (4 .* (b11) .* P1.^2 + 2 .* (b12) .* ( P2.^2 + P3.^2 )) .* P1;
    f2_elastic = -( (q11.*TotalStrain_22 + q12.*TotalStrain_11 + q12.*TotalStrain_33) .* (2.*P2) + 2.*q44.*(TotalStrain_12 .* P1 + TotalStrain_13 .* P3) ) + (4 .* (b11) .* P2.^2 + 2 .* (b12) .* ( P3.^2 + P1.^2 )) .* P2;
    f3_elastic = -( (q11.*TotalStrain_33 + q12.*TotalStrain_11 + q12.*TotalStrain_22) .* (2.*P3) + 2.*q44.*(TotalStrain_23 .* P2 + TotalStrain_13 .* P1) ) + (4 .* (b11) .* P3.^2 + 2 .* (b12) .* ( P1.^2 + P2.^2 )) .* P3;

    f1_elastic = f1_elastic .* in_film .* Nucleation_Sites;
    f2_elastic = f2_elastic .* in_film .* Nucleation_Sites;
    f3_elastic = f3_elastic .* in_film .* Nucleation_Sites;

    f1_elastic_2Dk = fft_2d_slices(f1_elastic);
    f2_elastic_2Dk = fft_2d_slices(f2_elastic);
    f3_elastic_2Dk = fft_2d_slices(f3_elastic);
else
    f1_elastic_2Dk = 0; f2_elastic_2Dk = 0; f3_elastic_2Dk = 0;
    f1_elastic = 0; f2_elastic = 0; f3_elastic = 0;
    TotalStrain_11 = 0; TotalStrain_22 = 0; 
    TotalStrain_33 = 0; TotalStrain_12 = 0; 
    TotalStrain_13 = 0; TotalStrain_23 = 0;
    u_1 = 0; u_2 = 0; u_3 = 0;
end