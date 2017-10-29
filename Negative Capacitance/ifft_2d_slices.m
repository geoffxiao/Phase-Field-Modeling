function out = ifft_2d_slices( mat )

    out = mat;
    [~, ~, z] = size(mat);

    for i = 1 : z

        out(:,:,i) = real(ifft2(squeeze(mat(:,:,i))));

    end

end