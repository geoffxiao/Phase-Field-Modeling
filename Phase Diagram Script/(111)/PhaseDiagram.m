% Phase diagram
Us_range = [-2 : 0.05 : 2] * 1e-2;
BTO_pct_range = [1 : -0.1 : 0];
Temperature_var = 27; % in C
    
% for BTO_pct_var = BTO_pct_range
%     
%     Us = 0; % doesn't matter
%     BTO_pct = BTO_pct_var;
%     STO_pct = 1 - BTO_pct;
%     Temperature = Temperature_var;
%     
%     FundamentalConstants;
%     Setup;
%     AxesSetup;
%     TransformElasticTensor;
%     GreenTensorSetup;
%     
%     InfinitePlateSetup_vpa
%     ElectrostaticSetup_vpa;
%     
%     save(sprintf('Setup_Mats_BTO_pct%g.mat',BTO_pct),...
%         'strain_bc_mats_inv','strain_bc_mat_inv_korigin',...
%         'eigenvec_mat','eigenval_mat',...
%         'electric_bc_mats_inv','electric_bc_mats_inv_korigin',...
%         'Green_FilmRef_k_11','Green_FilmRef_k_12','Green_FilmRef_k_13',...
%         'Green_FilmRef_k_21','Green_FilmRef_k_22','Green_FilmRef_k_23',...
%         'Green_FilmRef_k_31','Green_FilmRef_k_32','Green_FilmRef_k_33');
% end

    
for Us_var = Us_range
    for BTO_pct_var = BTO_pct_range
        
        PATH_var = sprintf('./Us_%g/BTO_pct_%g/',Us_var*1e2,BTO_pct_var);
        STRING_var = sprintf('BTO_pct_%g',BTO_pct_var);
        final_str = sprintf('%sfinal__%g Us11__%g Us22__%gC__%gkV-cm__%s.mat',PATH_var,Us_var*1e2,Us_var*1e2,Temperature_var,0,STRING_var);
        if ( ~exist( final_str ) ) % Haven't computed yet
            Main(Us_var,PATH_var,STRING_var,BTO_pct_var,Temperature_var);
        end
        
    end
end