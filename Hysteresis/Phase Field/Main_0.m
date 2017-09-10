function [P1_mean, P2_mean, P3_mean] = Main_0(E1_var, E2_var, E3_var, Nucleation_Sites_var, PATH_var, LOAD_var)

    Nucleation_Sites = Nucleation_Sites_var;
    PATH = PATH_var;
    LOAD = LOAD_var;

    E_1_applied = E1_var;
    E_2_applied = E2_var;
    E_3_applied = E3_var;

    clc;
    rng(1)

    %% Setup stuff
    Constants;
    Setup;
    AxesSetup;
    GreenTensorSetup;
    HomoStrainSetup;

    %% Setup stuff
    if(VPA_ELASTIC_ON)
        InfinitePlateSetup_vpa;
    else
        InfinitePlateSetup;
    end

    if(VPA_ELECTRIC_ON)
        ElectrostaticSetup_vpa;
    else
        ElectrostaticSetup;
    end

    save('Setup_Mats','strain_bc_mats_inv','strain_bc_mat_inv_korigin',...
        'eigenvec_mat','eigenval_mat',...
        'electric_bc_mats_inv','electric_bc_mats_inv_korigin',...
        'Green_11','Green_12','Green_13',...
        'Green_21','Green_22','Green_23',...
        'Green_31','Green_32','Green_33');
    
    %% Initial conditions
    InitP;

    %% Energies
    CalcElasticEnergy
    CalcElecEnergy
    ThermalNoise
    LandauEnergy
    SurfaceDepolEnergy
    ExternalEFieldEnergy

    f1_2Dk = f1_landau_2Dk + f1_elec_2Dk + f1_elastic_2Dk + f1_ext_E_2Dk + Thermal_Noise_1_2Dk;
    f2_2Dk = f2_landau_2Dk + f2_elec_2Dk + f2_elastic_2Dk + f2_ext_E_2Dk + Thermal_Noise_2_2Dk;
    f3_2Dk = f3_landau_2Dk + f3_elec_2Dk + f3_elastic_2Dk + f3_ext_E_2Dk + Thermal_Noise_3_2Dk + f3_surface_depol_2Dk;


    c = 0; % Flag for do while loop
    error = inf;

    %% Main loop
    MainLoop
    
    P1_mean = vol_avg( P1 );
    P2_mean = vol_avg( P2 );
    P3_mean = vol_avg( P3 );
    
end