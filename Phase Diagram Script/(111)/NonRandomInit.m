%%
RandomP;

% Remember changing first variable is y axis!!
% P(y,x,z);

P1_FilmRef(1:12,:,:) = P1_FilmRef(1:12,:,:) - 0.003;
P2_FilmRef(1:12,:,:) = P2_FilmRef(1:12,:,:) - 0.003;
P3_FilmRef(1:12,:,:) = P3_FilmRef(1:12,:,:) - 0.003;

P1_FilmRef(13:24,:,:) = P1_FilmRef(13:24,:,:) + 0.0015;
P2_FilmRef(13:24,:,:) = P2_FilmRef(13:24,:,:) - 0.003;
P3_FilmRef(13:24,:,:) = P3_FilmRef(13:24,:,:) - 0.003;
P1_FilmRef(13:24,:,end-20:end) = P1_FilmRef(13:24,:,end-20:end) + 0.0015;
P1_FilmRef(13:24,:,end-15:end) = P1_FilmRef(13:24,:,end-15:end) + 0.0015;
P1_FilmRef(13:24,:,end-10:end) = P1_FilmRef(13:24,:,end-10:end) + 0.0015;
P1_FilmRef(13:24,:,end-5:end) = P1_FilmRef(13:24,:,end-5:end) + 0.0015;

P1_FilmRef(25:end,:,:) = P1_FilmRef(25:end,:,:) - 0.003;
P2_FilmRef(25:end,:,:) = P2_FilmRef(25:end,:,:) - 0.003;
P3_FilmRef(25:end,:,:) = P3_FilmRef(25:end,:,:) - 0.003;

P1_FilmRef = P1_FilmRef .* in_film;
P2_FilmRef = P2_FilmRef .* in_film;
P3_FilmRef = P3_FilmRef .* in_film;

save('init.mat','P1_FilmRef','P2_FilmRef','P3_FilmRef');