function out = finite_diff_x3_second_der( mat, dz )

    [~,~,Nz] = size(mat);
    out = mat;
    
    for i = 2 : Nz - 1
        out(:,:,i) = (1/dz^2) * (mat(:,:,i+1) - 2*mat(:,:,i) + mat(:,:,i-1));
    end
    
    out(:,:,1) = (mat(:,:,2) - mat(:,:,1)) / dz; % approx d/dx3 ~ forward difference
    out(:,:,1) = (out(:,:,2) - out(:,:,1)) / dz; % approx d^2/dx3^2 ~ using another forward difference
    
    out(:,:,end) = (mat(:,:,end) - mat(:,:,end-1)) / dz;
    out(:,:,end) = (out(:,:,end) - out(:,:,end-1)) / dz;
    
end