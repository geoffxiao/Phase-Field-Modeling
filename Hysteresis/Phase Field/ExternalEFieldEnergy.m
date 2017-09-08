%% External field
f1_ext_E = -E_1_applied .* in_film .* Nucleation_Sites;
f2_ext_E = -E_2_applied .* in_film .* Nucleation_Sites;
f3_ext_E = -E_3_applied .* in_film .* Nucleation_Sites;

f1_ext_E_2Dk = fft_2d_slices(f1_ext_E);
f2_ext_E_2Dk = fft_2d_slices(f2_ext_E);
f3_ext_E_2Dk = fft_2d_slices(f3_ext_E);
