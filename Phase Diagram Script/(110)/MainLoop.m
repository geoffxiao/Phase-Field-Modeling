if( 7 ~= exist(PATH,'dir'))
    mkdir(PATH);
end

errors = zeros(saves(end),1);

while (c == 0 || error > epsilon) && c < saves(end)
    
    % saving 
    if( sum(c == saves) == 1 )        
    	save(sprintf('%s%g t__%g Us11__%g Us22__%gC__%gkV-cm__%s.mat',PATH,c,Us_11*1e2,Us_22*1e2,Temperature,E_1_applied_FilmRef/1e5,STRING),'P1_FilmRef','P2_FilmRef','P3_FilmRef');
    end
    
    % Previous iteration
    P1_FilmRef_prev_2Dk = P1_FilmRef_2Dk; 
    f1_prev_2Dk = f1_2Dk;

    P2_FilmRef_prev_2Dk = P2_FilmRef_2Dk;
    f2_prev_2Dk = f2_2Dk;     

    P3_FilmRef_prev_2Dk = P3_FilmRef_2Dk;
    f3_prev_2Dk = f3_2Dk;

    P1_FilmRef_prev = P1_FilmRef; 
    P2_FilmRef_prev = P2_FilmRef;
    P3_FilmRef_prev = P3_FilmRef;

    % Next iteration
    GradEnergy % d3_part uses previous P's
    P1_FilmRef_2Dk = (( P1_FilmRef_prev_2Dk + dt .* -f1_prev_2Dk + dt .* G1_d3_part ) ./ ( 1 + dt .* G1_no_d3 ));
    P2_FilmRef_2Dk = (( P2_FilmRef_prev_2Dk + dt .* -f2_prev_2Dk + dt .* G2_d3_part ) ./ ( 1 + dt .* G2_no_d3 ));
    P3_FilmRef_2Dk = (( P3_FilmRef_prev_2Dk + dt .* -f3_prev_2Dk + dt .* G3_d3_part ) ./ ( 1 + dt .* G3_no_d3 ));

    P1_FilmRef = ifft_2d_slices(P1_FilmRef_2Dk);
    P2_FilmRef = ifft_2d_slices(P2_FilmRef_2Dk);
    P3_FilmRef = ifft_2d_slices(P3_FilmRef_2Dk);
    
    CalcElasticEnergy
    CalcElecEnergy
    ThermalNoise;
    LandauEnergy
    SurfaceDepolEnergy
    ExternalEFieldEnergy

    f1_2Dk = f1_landau_2Dk + f1_elec_2Dk + f1_elastic_2Dk + f1_ext_E_2Dk + Thermal_Noise_1_2Dk;
    f2_2Dk = f2_landau_2Dk + f2_elec_2Dk + f2_elastic_2Dk + f2_ext_E_2Dk + Thermal_Noise_2_2Dk;
    f3_2Dk = f3_landau_2Dk + f3_elec_2Dk + f3_elastic_2Dk + f3_ext_E_2Dk + Thermal_Noise_3_2Dk + f3_surface_depol_2Dk;
        
    c = c + 1;
    
    % Progress
    error = max( [sum(sum(sum(abs(P1_FilmRef-P1_FilmRef_prev)))); sum(sum(sum(abs(P2_FilmRef-P2_FilmRef_prev)))); sum(sum(sum(abs(P3_FilmRef-P3_FilmRef_prev))))] );
    errors(c) = error;
    % print error
    if( mod(c, 50) == 0 )
        %Visualize
        drawnow
        error   
    end
    
end

SaveData