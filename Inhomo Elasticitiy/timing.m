iterations = [0, 1, 2, 3, 4, 5, 10, 15, 20, 25];
num_trials = 10;
trial_times = zeros(numel(iterations),num_trials);
RSS = trial_times;
counter = 1;
for ITERATIVE_PERTURBATIONS = iterations

    for trial = 1 : num_trials
        tic;
        CalculateStrain_testing;
        temp = toc;
        trial_times(trial, counter) = temp;
        
        u_1_d1_realspace = real(ifftn(kx_grid_3D.*u_1_k.*1i));
        u_1_d2_realspace = real(ifftn(ky_grid_3D.*u_1_k.*1i));
        u_1_d3_realspace = real(ifftn(kz_grid_3D.*u_1_k.*1i));       

        u_2_d1_realspace = real(ifftn(kx_grid_3D.*u_2_k.*1i));
        u_2_d2_realspace = real(ifftn(ky_grid_3D.*u_2_k.*1i));
        u_2_d3_realspace = real(ifftn(kz_grid_3D.*u_2_k.*1i));

        u_3_d1_realspace = real(ifftn(kx_grid_3D.*u_3_k.*1i));
        u_3_d2_realspace = real(ifftn(ky_grid_3D.*u_3_k.*1i));
        u_3_d3_realspace = real(ifftn(kz_grid_3D.*u_3_k.*1i));

        RHS_k = kx_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_1_d1_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_2_d2_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_3_d3_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_12).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d2_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_13).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d3_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_21).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d1_realspace).*1i + kx_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_31).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d1_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_1_d1_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_2_d2_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_3_d3_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_12).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d2_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_12 - TotalStrain_homo_21).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d1_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_23).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d3_realspace).*1i + ky_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_32).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d2_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_11 - TotalStrain_homo_11).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_1_d1_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_22 - TotalStrain_homo_22).*(C12_hom + C12_het_realspace) - C12_het_realspace.*u_2_d2_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_33 - TotalStrain_homo_33).*(C11_hom + C11_het_realspace) - C11_het_realspace.*u_3_d3_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_13).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_1_d3_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_23).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_2_d3_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_13 - TotalStrain_homo_31).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d1_realspace).*1i + kz_grid_3D.*fftn((Eigenstrain_23 - TotalStrain_homo_32).*(C44_hom + C44_het_realspace) - C44_het_realspace.*u_3_d2_realspace).*1i;
        LHS_k = - C11_hom.*kx_grid_3D.^2.*u_1_k - C44_hom.*kx_grid_3D.^2.*u_2_k - C44_hom.*kx_grid_3D.^2.*u_3_k - C11_hom.*ky_grid_3D.^2.*u_2_k - C44_hom.*ky_grid_3D.^2.*u_1_k - C44_hom.*ky_grid_3D.^2.*u_3_k - C11_hom.*kz_grid_3D.^2.*u_3_k - C44_hom.*kz_grid_3D.^2.*u_1_k - C44_hom.*kz_grid_3D.^2.*u_2_k - C12_hom.*kx_grid_3D.*ky_grid_3D.*u_1_k - C12_hom.*kx_grid_3D.*ky_grid_3D.*u_2_k - C44_hom.*kx_grid_3D.*ky_grid_3D.*u_1_k - C44_hom.*kx_grid_3D.*ky_grid_3D.*u_2_k - C12_hom.*kx_grid_3D.*kz_grid_3D.*u_1_k - C12_hom.*kx_grid_3D.*kz_grid_3D.*u_3_k - C44_hom.*kx_grid_3D.*kz_grid_3D.*u_1_k - C44_hom.*kx_grid_3D.*kz_grid_3D.*u_3_k - C12_hom.*ky_grid_3D.*kz_grid_3D.*u_2_k - C12_hom.*ky_grid_3D.*kz_grid_3D.*u_3_k - C44_hom.*ky_grid_3D.*kz_grid_3D.*u_2_k - C44_hom.*ky_grid_3D.*kz_grid_3D.*u_3_k;

        RHS = real(ifftn(RHS_k));
        LHS = real(ifftn(LHS_k));

        % r^2
        avg = mean(mean(mean(LHS)));
        SS_tot = sum(sum(sum( (LHS - avg).^2 )));
        SS_res = sum(sum(sum( (LHS - RHS).^2 )));
        r_sq = 1 - SS_res / SS_tot;
        
        RSS(trial, counter) = SS_res;
        

    end
    counter = counter + 1
    
end

%%
err_times = std(trial_times,1,1);
mean_times = mean(trial_times,1);

errorbar(iterations,mean_times,err_times);
axis([-5 30 0 2.5])
xlabel('Order of Approximation');
ylabel('Runtime (s)');


%%
err_rss = std(RSS,1,1);
mean_rss = mean(RSS,1);

errorbar(iterations,mean_rss,err_rss);
xlabel('Order of Approximation');
ylabel('Residual Sum of Squares');
axis([-5 30 0 3.5*1e38])