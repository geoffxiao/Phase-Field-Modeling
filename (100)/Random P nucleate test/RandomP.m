P1 = zeros( Nx, Ny, Nz ); P2 = P1; P3 = P1;

init_perturb = rand(Nx, Ny, Nz) > 0.5; % where to perturb
perturb_amt = abs( rand(Nx, Ny, Nz) - 0.5 ) * 1e-2; % how much to perturb
P1(init_perturb) = perturb_amt(init_perturb);
P1(~init_perturb) = -perturb_amt(~init_perturb);

init_perturb = rand(Nx, Ny, Nz) > 0.5;
perturb_amt = abs( rand(Nx, Ny, Nz) - 0.5 ) * 1e-2;
P2(init_perturb) = perturb_amt(init_perturb);
P2(~init_perturb) = -perturb_amt(~init_perturb);

init_perturb = rand(Nx, Ny, Nz) > 0.5;
perturb_amt = abs( rand(Nx, Ny, Nz) - 0.5 ) * 1e-2;
P3(init_perturb) = perturb_amt(init_perturb);
P3(~init_perturb) = -perturb_amt(~init_perturb);

L = 5;
init_sites = ones(Nx,Ny,Nz);
xy_edges = 8;
z_edges = 2;
for i = 1 : 7
    init_sites(randi([xy_edges,Nx-L+1-xy_edges])+(0:L-1),randi([xy_edges,Ny-L+1-xy_edges])+(0:L-1),randi([z_edges,Nz-L+1-z_edges])+(0:L-1)) = 0;
end

P1 = P1 + init_sites * 1e-1;
P2 = P2 + init_sites * 1e-1;
P3 = P3 + init_sites * 1e-1;

