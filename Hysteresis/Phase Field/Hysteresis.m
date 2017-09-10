%% Hysteresis Loops
%
% E field               0
% -------------------------------------------------
%                       | 
%                       | 
%                       | 
%                       *                 0
%                        ------>---->---* 1
%                       *---<-----<-----o 2
%    3 *------<---<-----o 
%    4 o---->--->-------* 
%                       o--->----->-----* 5 
%                       | 
%                       | 

%% Nucleation sites, have 0 free energy change...
% Nucleation_Sites = +(rand(Nx,Ny,Nz) < (1-0.01)) .* in_film;
Setup
L = 5;
Nucleation_Sites = ones(Nx,Ny,Nz);
xy_edges = 1;
z_edges = 2;
for i_ind = 1 : 1
    Nucleation_Sites(randi([xy_edges,Nx-L+1-xy_edges])+(0:L-1),...
                     randi([xy_edges,Ny-L+1-xy_edges])+(0:L-1),...
                     randi([z_edges+interface_index,film_index-L+1-z_edges])+(0:L-1)) = 0;
end

% Percent of nucleation sites
Nucleation_pct = abs(sum(sum(sum(Nucleation_Sites-1)))/(Nx*Ny*(film_index-interface_index+1)));

%% 5 parts:
%    % 0 = 0 
%    % 1 = 0 to +E_max
%    % 2 = E_max to 0
%    % 3 = 0 to -E_max
%    % 4 = -E_max to 0
%    % 5 = 0 to E_max
E_fields = [0, 1e5, 2e5, 3e5];

P1_Es = [];
P2_Es = [];
P3_Es = [];
Es = [];

%%
E_input = E_fields(1);
[P1_mean, P2_mean, P3_mean] = Main_0(E_input, 0, 0, Nucleation_Sites, './Part 0_0 kVcm/', 0); % 0 kV/cm result if not done yet
PE

%% Part 1
for i = 2 : numel(E_fields)
    E_input = E_fields(i);
    [P1_mean, P2_mean, P3_mean] = Main(E_input, 0, 0, Nucleation_Sites, sprintf('./Part 1/'), 1);   
    PE
end

%% Part 2
for i = numel(E_fields) - 1 : -1 : 1
    E_input = E_fields(i);
    [P1_mean, P2_mean, P3_mean] = Main(E_input, 0, 0, Nucleation_Sites, sprintf('./Part 2/'), 1);   
    PE
end

%% Part 3
for i = 2 : numel(E_fields)
    E_input = -E_fields(i);
    [P1_mean, P2_mean, P3_mean] = Main(E_input, 0, 0, Nucleation_Sites, sprintf('./Part 3/'), 1);   
    PE
end

%% Part 4
for i = numel(E_fields) - 1 : -1 : 1
    E_input = -E_fields(i);
    [P1_mean, P2_mean, P3_mean] = Main(E_input, 0, 0, Nucleation_Sites, sprintf('./Part 4/'), 1); 
    PE
end

%% Part 5
for i = 2 : numel(E_fields)
    E_input = E_fields(i);
    [P1_mean, P2_mean, P3_mean] = Main(E_input, 0, 0, Nucleation_Sites, sprintf('./Part 5/'), 1);  
    PE
end

save('PE','P1_Es','P2_Es','P3_Es','Es');