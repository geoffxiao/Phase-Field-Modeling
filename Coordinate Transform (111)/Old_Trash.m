% %% Test symmetry of C_Transformed
% for i = 1 : 3
% for j = 1 : 3
% for k = 1 : 3
% for l = 1 : 3
%    
%     if( C_Transformed(i,j,k,l) ~= C_Transformed(j,i,k,l) )
%        disp('X'); 
%     end
%     if( C_Transformed(i,j,k,l) ~= C_Transformed(i,j,l,k) )
%        disp('X'); 
%     end
%     if( C_Transformed(i,j,k,l) ~= C_Transformed(k,l,i,j) )
%        disp('X'); 
%     end    
%     
% end
% end
% end
% end

% %% elastic energy as function of transformed elastic strain
% elastic_e_Transformed = sym(zeros(3,3)); % elastic strain e
% elastic_e_Transformed(1,1) = sym('elasticT11');
% elastic_e_Transformed(2,2) = sym('elasticT22');
% elastic_e_Transformed(3,3) = sym('elasticT33');
% elastic_e_Transformed(1,2) = sym('elasticT12');
% elastic_e_Transformed(1,3) = sym('elasticT13');
% elastic_e_Transformed(2,3) = sym('elasticT23');
% elastic_e_Transformed(2,1) = elastic_e_Transformed(1,2);
% elastic_e_Transformed(3,1) = elastic_e_Transformed(1,3);
% elastic_e_Transformed(3,2) = elastic_e_Transformed(2,3);
% 
% f_elastic = sym(0);
% 
% for i = 1 : 3
% for j = 1 : 3
% for k = 1 : 3
% for l = 1 : 3
%     
%     f_elastic = C_Transformed(i,j,k,l) * elastic_e_Transformed(i,j) * elastic_e_Transformed(k,l) + f_elastic;
%     
% end
% end
% end
% end