function [P1_mean, P2_mean, P3_mean] = Main(T_var, PATH_var, LOAD_var)

    PATH = PATH_var;
    LOAD = LOAD_var;
    Nucleation_Sites = 1;

    Temperature = T_var;

    clc;
    rng(1)

    %% Setup stuff
    Constants;
    Setup;
    AxesSetup;
    HomoStrainSetup;
    
    load('Setup_Mats');

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