%% Nucleation sites, have 0 free energy change...
Setup

% Nucleation_Sites = +(rand(Nx,Ny,Nz) < (1-0.01)) .* in_film;
L = 5;
Nucleation_Sites = ones(Nx,Ny,Nz);
xy_edges = 8;
z_edges = 2;
for i = 1 : 7
    Nucleation_Sites(randi([xy_edges,Nx-L+1-xy_edges])+(0:L-1),randi([xy_edges,Ny-L+1-xy_edges])+(0:L-1),randi([z_edges,Nz-L+1-z_edges])+(0:L-1)) = 0;
end

% Percent of nucleation sites
Nucleation_Sites = 1;
Nucleation_pct = abs(sum(sum(sum(Nucleation_Sites-1)))/(Nx*Ny*(film_index-interface_index+1)));

%% Hysteresis Loops

% Run 0 kV/cm

%
Load = 1;
E_fields_tot = [0, 1e2, 1e3, 1e4, 1e5, 5e5, 1e6, 2e6, 3e6, 4e6, 5e6, 6e6, 7e6, 8e6, 9e6, 1e7];
E_vectors = [];
P_vectors = [];

%%
E_fields = E_fields_tot(2:end);

for E_1_applied = E_fields
    
    folder = sprintf('%gkV-cm',E_1_applied/1e5);
    mkdir(folder);
    cd(folder);
    movefile('../init.mat','./init.mat');

    addpath('../')    
    Main
    
    P_vectors = [P_vectors, mean(mean(mean(P1)))];
    E_vectors = [E_vectors, E_1_applied];
    
    final = sprintf('./final_%g_%gC_%gkV-cm.mat',Us*1e2,T,E_1_applied/1e5);
    copyfile(final,'../init.mat','f');
    cd('../');
    
end

%%
E_fields = E_fields_tot(1:end-1);
E_fields = fliplr(E_fields);

for E_1_applied = E_fields
    
    folder = sprintf('%g_2kV-cm',E_1_applied/1e5);
    mkdir(folder);
    cd(folder);
    movefile('../init.mat','./init.mat');
    
    addpath('../')
    Main
    
    P_vectors = [P_vectors, mean(mean(mean(P1)))];
    E_vectors = [E_vectors, E_1_applied];
    
    final = sprintf('./final_%g_%gC_%gkV-cm.mat',Us*1e2,T,E_1_applied/1e5);
    copyfile(final,'../init.mat','f');
    cd('../');
    
end

%%
E_fields = -E_fields_tot(2:end);

for E_1_applied = E_fields
    
    folder = sprintf('%gkV-cm',E_1_applied/1e5);
    mkdir(folder);
    cd(folder);
    movefile('../init.mat','./init.mat');
    
    addpath('../')
    Main
    
    P_vectors = [P_vectors, mean(mean(mean(P1)))];
    E_vectors = [E_vectors, E_1_applied];
    
    final = sprintf('./final_%g_%gC_%gkV-cm.mat',Us*1e2,T,E_1_applied/1e5);
    copyfile(final,'../init.mat','f');
    cd('../');
    
end

%%
E_fields = -E_fields_tot(1:end-1);
E_fields = fliplr(E_fields);

for E_1_applied = E_fields
    
    folder = sprintf('%g_2kV-cm',E_1_applied/1e5);
    mkdir(folder);
    cd(folder);
    movefile('../init.mat','./init.mat');
    
    addpath('../')
    Main
    
    P_vectors = [P_vectors, mean(mean(mean(P1)))];
    E_vectors = [E_vectors, E_1_applied];
    
    final = sprintf('./final_%g_%gC_%gkV-cm.mat',Us*1e2,T,E_1_applied/1e5);
    copyfile(final,'../init.mat','f');
    cd('../');
    
end

save('PE','P_vectors','E_vectors');