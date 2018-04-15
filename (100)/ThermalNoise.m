% Thermal Noise
ThermConst = k_boltzmann * Temperature / (dx * dy * dz);
Thermal_Noise_Sigma = sqrt(2 * ThermConst);

Thermal_Noise_1 = normrnd(0,Thermal_Noise_Sigma,Nx,Ny,Nz);
Thermal_Noise_2 = normrnd(0,Thermal_Noise_Sigma,Nx,Ny,Nz);
Thermal_Noise_3 = normrnd(0,Thermal_Noise_Sigma,Nx,Ny,Nz);

Thermal_Noise_1_2Dk = fft_2d_slices(Thermal_Noise_1) .* in_film .* Nucleation_Sites;
Thermal_Noise_2_2Dk = fft_2d_slices(Thermal_Noise_2) .* in_film .* Nucleation_Sites;
Thermal_Noise_3_2Dk = fft_2d_slices(Thermal_Noise_3) .* in_film .* Nucleation_Sites;