function [] = Main(Us_var, PATH_var, STRING_var, BTO_pct_var, Temperature_var)
 
    Us = Us_var;
    Temperature = Temperature_var;
    PATH = PATH_var
    STRING = STRING_var;
    BTO_pct = BTO_pct_var; 
    STO_pct = 1 - BTO_pct;

    clc;
    rng(1)

    %% Setup stuff
    FundamentalConstants;
    Setup;
    AxesSetup;
    Nucleate;
    TransformElasticTensor;
    GreenTensorSetup;
    HomoStrainSetup;
    
    %% Load from setup file...
    load_file = sprintf('Setup_Mats_BTO_pct%g.mat',BTO_pct);
    if( exist(load_file) )
        load(load_file);
    else
        %% Setup energy stuff
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
    end

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

end
    