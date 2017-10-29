function out = finite_diff_x3_first_der( mat, dz )

    [~,~,Nz] = size(mat);
    out = mat;
    
    for i = 2 : Nz - 1
        out(:,:,i) = (1/dz) * ( (-1/2) * mat(:,:,i-1) + (1/2) * mat(:,:,i+1) );
    end
    
    % approximate endpoints using forward difference
    out(:,:,1) = ( mat(:,:,2) - mat(:,:,1) ) / dz;
    out(:,:,end) = ( mat(:,:,end) - mat(:,:,end-1) ) / dz;
        
end