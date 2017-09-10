function out = fft_2d_slices( mat )

    out = mat;
    [~, ~, z] = size(mat);

    for i = 1 : z

        out(:,:,i) = fft2(squeeze(mat(:,:,i)));

    end

end