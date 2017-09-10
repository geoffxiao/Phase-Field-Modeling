% Initial Conditions
if( LOAD )
    load('init.mat','P1_FilmRef','P2_FilmRef','P3_FilmRef');
else
    RandomP;
end

% Thin film simulation
P1_FilmRef(:,:,1:sub_index) = 0; P2_FilmRef(:,:,1:sub_index) = 0; P3_FilmRef(:,:,1:sub_index) = 0;
P1_FilmRef(:,:,film_index+1:end) = 0; P2_FilmRef(:,:,film_index+1:end) = 0; P3_FilmRef(:,:,film_index+1:end) = 0;

P1_FilmRef_2Dk = fft_2d_slices( P1_FilmRef ); 
P2_FilmRef_2Dk = fft_2d_slices( P2_FilmRef ); 
P3_FilmRef_2Dk = fft_2d_slices( P3_FilmRef );