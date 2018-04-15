clc;

%% Setup stuff
Constants;
Setup;
AxesSetup;
Nucleate;
GreenTensorSetup;
HomoStrainSetup;

%% Setup stuff
load_file_setup = sprintf('Setup_Mats_BTO_pct%g_%g%g%g.mat',BTO_pct,Nx,Ny,Nz);
if( exist(load_file_setup) )
    load(load_file_setup);
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
    save(load_file_setup,...
    'strain_bc_mats_inv','strain_bc_mat_inv_korigin',...
    'eigenvec_mat','eigenval_mat',...
    'electric_bc_mats_inv','electric_bc_mats_inv_korigin',...
    'Green_11','Green_12','Green_13',...
    'Green_21','Green_22','Green_23',...
    'Green_31','Green_32','Green_33');
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