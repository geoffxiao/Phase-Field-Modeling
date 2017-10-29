function color = convert( P1, P2, P3, P1_min,P1_max,P2_min,P2_max,P3_min,P3_max )
% convert P into a color

%     num = 1024;
%     Area = hsv(num); 
%     Area_axis = linspace(-pi,pi,num);
%     Phi = parula(num); 
%     Phi_axis = linspace(-pi/2,pi/2,num);
% 
%     
%     % find where in the Area P is
%     polar_angle = atan2(P2, P1); 
%     polar_angle = repmat(polar_angle,1,num);
%     Area_axis = repmat(Area_axis,numel(P1),1);
%     [~, ind] = min(abs(polar_angle - Area_axis),[],2);
%     Area_val = Area(ind,:);    
%     
%     % find where in the height P is
%     Phi_axis = repmat(Phi_axis,numel(P1),1);
%     phi_angle = acos( P3 ./ sqrt( P1.^2 + P2.^2 ) ); phi_angle = repmat(phi_angle,1,num);
%     [~, ind] = min(abs(phi_angle - Phi_axis),[],2);
%     Height_val = Phi(ind,:);
%     
%     color = cat(3,Area_val,Height_val);

    % normalize P
    R = sqrt(P1.^2 + P2.^2 + P3.^2);

    P1 = P1 ./ R;
    P2 = P2 ./ R;
    P3 = P3 ./ R;
    
    R = (P3+1)/2;
    G = (P1+1)/2;
    B = (P2+1)/2;

    Area_val = [R,G,B];
    Height_val = [R,G,B];

    color = cat(3,Area_val,Height_val);
    
end