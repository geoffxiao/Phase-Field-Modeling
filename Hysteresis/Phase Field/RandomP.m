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