% Initial Conditions
if( LOAD )
    load('init.mat','P1','P2','P3');
else
    RandomP;
end

% Thin film simulation
P1(:,:,1:sub_index) = 0; P2(:,:,1:sub_index) = 0; P3(:,:,1:sub_index) = 0;
P1(:,:,film_index+1:end) = 0; P2(:,:,film_index+1:end) = 0; P3(:,:,film_index+1:end) = 0;

P1_2Dk = fft_2d_slices( P1 ); P2_2Dk = fft_2d_slices( P2 ); P3_2Dk = fft_2d_slices( P3 );