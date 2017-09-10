% Calculate P within the film
P1_film = P1_FilmRef(:,:,interface_index:film_index);
P2_film = P2_FilmRef(:,:,interface_index:film_index);
P3_film = P3_FilmRef(:,:,interface_index:film_index);

P1_val = vol_avg(abs(P1_film))
P2_val = vol_avg(abs(P2_film))
P3_val = vol_avg(abs(P3_film))

P_val = sqrt(P1_val^2+P2_val^2+P3_val^2)