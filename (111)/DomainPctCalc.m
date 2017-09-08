%% For P1_CrystalRef ~ P2 ~ P3 within the domain
% Polar Angle
R = sqrt( P1_CrystalRef.^2 + P2_CrystalRef.^2 + P3_CrystalRef.^2 );
Theta = acos( P3_CrystalRef ./ R ); % -> [0,pi]
Phi = atan2( P2_CrystalRef, P1_CrystalRef ); % -> [-pi,pi]

threshold_P1_CrystalRef = 5e-2; % P1_CrystalRef ~ 0
threshold_P2_CrystalRef = 5e-2; % P2_CrystalRef ~ 0
threshold_P3_CrystalRef = 5e-2; % P3_CrystalRef ~ 0

total_el = sum(sum(sum( P1_CrystalRef ~= 0)));

%% Tetragonal
a1 = ( abs(P1_CrystalRef) > threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) < threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) < threshold_P3_CrystalRef );
a2 = ( abs(P1_CrystalRef) < threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) > threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) < threshold_P3_CrystalRef );
c = ( abs(P1_CrystalRef) < threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) < threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) > threshold_P3_CrystalRef );


%% Orthorhombic
O12 = ( abs(P1_CrystalRef) > threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) > threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) < threshold_P3_CrystalRef );
O13 = ( abs(P1_CrystalRef) > threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) < threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) > threshold_P3_CrystalRef );
O23 = ( abs(P1_CrystalRef) < threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) > threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) > threshold_P3_CrystalRef );


%% Rhombohedral
r = ( abs(P1_CrystalRef) > threshold_P1_CrystalRef ) & ( abs(P2_CrystalRef) > threshold_P2_CrystalRef ) & ( abs(P3_CrystalRef) > threshold_P3_CrystalRef );

%% Calc
a1_calc = sum(sum(sum(a1))) /total_el;
a2_calc = sum(sum(sum(a2))) /total_el;
c_calc = sum(sum(sum(c))) / total_el;

O12_calc = sum(sum(sum(O12))) / total_el;
O13_calc = sum(sum(sum(O13))) / total_el;
O23_calc = sum(sum(sum(O23))) / total_el;

r_calc = sum(sum(sum(r))) / total_el;

Names = {'a1','a2','c','O12','O13','O23','r'}
Pcts = [a1_calc,a2_calc,c_calc,O12_calc,O13_calc,O23_calc,r_calc]
Avg_val = [ mean(mean(mean(abs(P1_CrystalRef)))); mean(mean(mean(abs(P2_CrystalRef)))); mean(mean(mean(abs(P3_CrystalRef))))]'



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Trash
% %% Tetragonal
% % a1/a2 domain, Theta ~pi/2 ; Phi ~ 0, pi/2, pi, -pi, -pi/2
% a1_a2 = ( abs(Theta - (pi/2)) < threshold_angle ) & ... 
%     ( abs(abs(Phi) - pi) < threshold_angle | abs(abs(Phi) - (pi/2)) < threshold_angle ) ;
% 
% % c domain, Theta ~0,pi ; Phi ~0
% c = ( Theta < threshold_angle | abs(Theta - pi) < threshold_angle ) & ...
%     ( abs(P1_CrystalRef) < threshold_mag & abs(P2_CrystalRef) < threshold_mag );
% 
% %% Orthorhombic
% % aa1/aa2 domain, Theta ~pi/2, Phi ~ pi/4, 3*pi/4, -pi/4, -3*pi/4
% aa1_aa2 = ( abs(Theta - (pi/2)) < threshold_angle ) & ... 
%     ( abs(abs(Phi) - (pi/4)) < threshold_angle | abs(abs(Phi) - (3*pi/4)) < threshold_angle ) ;
% 
% % P1_CrystalRef ~ P3_CrystalRef, P2_CrystalRef ~ 0
% % Theta ~ pi/4, 3pi/4 ; Phi ~ 0, pi
% a1_c = ( abs(Theta - (pi/4)) < threshold_angle | abs(Theta - (3*pi/4)) < threshold_angle ) & ...
%     ( abs(Phi) < threshold_angle | abs(abs(Phi) - pi) < threshold_angle );
% 
% % P1_CrystalRef ~ 0, P2_CrystalRef ~ P3_CrystalRef
% % Theta ~ pi/4, 3pi/4 ; Phi ~ pi/2, 3pi/2
% a2_c = ( abs(Theta - (pi/4)) < threshold_angle | abs(Theta - (3*pi/4)) < threshold_angle ) & ...
%     ( abs(abs(Phi) - (pi/2)) < threshold_angle | abs(abs(Phi) - (3*pi/2)) < threshold_angle );
% 
% 
% %% Rhombohedral
% r = ( abs(Theta - (pi/6)) < threshold_angle | abs(Theta - (5*pi/6)) < threshold_angle ) & ...
%     ( abs(abs(Phi) - (pi/4)) < threshold_angle | abs(abs(Phi) - (3*pi/4)) + threshold_angle );