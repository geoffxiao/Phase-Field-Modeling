%% Calculate elastic tensor transformed
C = sym(zeros(3,3,3,3));

C11 = sym('C11');
C12 = sym('C12');
C44 = sym('C44');

C(1,1,1,1) = C11; C(2,2,2,2) = C11; C(3,3,3,3) = C11;
C(1,1,2,2) = C12; C(1,1,3,3) = C12; C(2,2,1,1) = C12;
C(2,2,3,3) = C12; C(3,3,1,1) = C12; C(3,3,2,2) = C12;
C(1,2,1,2) = C44; C(2,1,2,1) = C44; C(1,3,1,3) = C44;
C(3,1,3,1) = C44; C(2,3,2,3) = C44; C(3,2,3,2) = C44;
C(1,2,2,1) = C44; C(2,1,1,2) = C44; C(1,3,3,1) = C44;
C(3,1,1,3) = C44; C(2,3,3,2) = C44; C(3,2,2,3) = C44;

T = [1            0             0; ...
     0    1/sqrt(2)    -1/sqrt(2); ...
     0    1/sqrt(2)    1/sqrt(2)];
 
C_Transformed = sym(zeros(3,3,3,3));

for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
    
    for m = 1 : 3
    for n = 1 : 3
    for o = 1 : 3
    for p = 1 : 3

        C_Transformed(i,j,k,l) = T(i,m) * T(j,n) * T(k,o) * T(l,p) * C(m,n,o,p) + C_Transformed(i,j,k,l);

    end
    end
    end
    end
    
end
end
end
end

%% Test symmetry of C_Transformed
for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
   
    if( C_Transformed(i,j,k,l) ~= C_Transformed(j,i,k,l) )
       disp('X'); 
    end
    if( C_Transformed(i,j,k,l) ~= C_Transformed(i,j,l,k) )
       disp('X'); 
    end
    if( C_Transformed(i,j,k,l) ~= C_Transformed(k,l,i,j) )
       disp('X'); 
    end    
    
end
end
end
end

%% Test C_Transformed == 0
for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
   
    if( C_Transformed(i,j,k,l) == 0 && C_Transformed(j,i,k,l) ~= 0 )
       disp('X'); 
    end    
    
end
end
end
end

%%
out = '';

for i = 1 : 3
for j = 1 : 3
for k = 1 : 3
for l = 1 : 3
    
    if( C_Transformed(i,j,k,l) ~= 0 )
        fprintf('C_Transformed(%g,%g,%g,%g) = %s;\n',i,j,k,l,char(C_Transformed(i,j,k,l)));
    end
end
end
end
end