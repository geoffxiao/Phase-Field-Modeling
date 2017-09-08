P1_FilmRef = zeros( Nx, Ny, Nz ); P2_FilmRef = P1_FilmRef; P3_FilmRef = P1_FilmRef;

init_perturb = rand(Nx, Ny, Nz) > 0.5; % where to perturb
perturb_amt = abs( rand(Nx, Ny, Nz) - 0.5 ) * 1e-2; % how much to perturb
P1_FilmRef(init_perturb) = perturb_amt(init_perturb);
P1_FilmRef(~init_perturb) = -perturb_amt(~init_perturb);

init_perturb = rand(Nx, Ny, Nz) > 0.5;
perturb_amt = abs( rand(Nx, Ny, Nz) - 0.5 ) * 1e-2;
P2_FilmRef(init_perturb) = perturb_amt(init_perturb);
P2_FilmRef(~init_perturb) = -perturb_amt(~init_perturb);

init_perturb = rand(Nx, Ny, Nz) > 0.5;
perturb_amt = abs( rand(Nx, Ny, Nz) - 0.5 ) * 1e-2;
P3_FilmRef(init_perturb) = perturb_amt(init_perturb);
P3_FilmRef(~init_perturb) = -perturb_amt(~init_perturb);