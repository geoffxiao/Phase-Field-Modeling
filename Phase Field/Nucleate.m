%% Nucleation sites, have 0 free energy change...
% Nucleation_Sites = +(rand(Nx,Ny,Nz) < (1-0.01)) .* in_film;
if( NUCLEATE )
    L = 5;
    Nucleation_Sites = ones(Nx,Ny,Nz);
    xy_edges = 8;
    z_edges = 2;
    for i = 1 : 7
        Nucleation_Sites(randi([xy_edges,Nx-L+1-xy_edges])+(0:L-1),randi([xy_edges,Ny-L+1-xy_edges])+(0:L-1),randi([z_edges,Nz-L+1-z_edges])+(0:L-1)) = 0;
    end

    % Percent of nucleation sites
    Nucleation_pct = abs(sum(sum(sum(Nucleation_Sites-1)))/(Nx*Ny*(film_index-interface_index+1)));
else
    Nucleation_Sites = 1;
end