%%
RandomP;

% Remember changing first variable is y axis!!
% P(y,x,z);

P1(1:20,:,:) = P1(1:20,:,:) - 0.003;
P2(1:20,:,:) = P2(1:20,:,:) - 0.003;
P3(1:20,:,:) = P3(1:20,:,:) - 0.003;

P1(21:44,:,:) = P1(21:44,:,:) + 0.0015;
P2(21:44,:,:) = P2(21:44,:,:) - 0.003;
P3(21:44,:,:) = P3(21:44,:,:) - 0.003;
P1(21:44,:,end-20:end) = P1(21:44,:,end-20:end) + 0.0015;
P1(21:44,:,end-15:end) = P1(21:44,:,end-15:end) + 0.0015;
P1(21:44,:,end-10:end) = P1(21:44,:,end-10:end) + 0.0015;
P1(21:44,:,end-5:end) = P1(21:44,:,end-5:end) + 0.0015;

P1(45:end,:,:) = P1(45:end,:,:) - 0.003;
P2(45:end,:,:) = P2(45:end,:,:) - 0.003;
P3(45:end,:,:) = P3(45:end,:,:) - 0.003;

P1 = P1 .* in_film;
P2 = P2 .* in_film;
P3 = P3 .* in_film;

save('init.mat','P1','P2','P3');