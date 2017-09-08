r1_plus = ( P1 > 0.2 ) & ( P2 > 0.2 ) & ( P3 > 0.2 );
r2_plus = ( P1 < -0.2 ) & ( P2 > 0.2 ) & ( P3 > 0.2 );
r3_plus = ( P1 < -0.2 ) & ( P2 < -0.2 ) & ( P3 > 0.2 );
r4_plus = ( P1 > 0.2 ) & ( P2 < -0.2 ) & ( P3 > 0.2 );

r1_minus = ( P1 < -0.2 ) & ( P2 < -0.2 ) & ( P3 < -0.2 );
r2_minus = ( P1 > 0.2 ) & ( P2 < -0.2 ) & ( P3 < -0.2 );
r3_minus = ( P1 > 0.2 ) & ( P2 > 0.2 ) & ( P3 < -0.2 );
r4_minus = ( P1 < -0.2 ) & ( P2 > 0.2 ) & ( P3 < -0.2 );

sum(sum(sum(r1_plus))) / sum(sum(sum(in_film)))
sum(sum(sum(r2_plus))) / sum(sum(sum(in_film)))
sum(sum(sum(r3_plus))) / sum(sum(sum(in_film)))
sum(sum(sum(r4_plus))) / sum(sum(sum(in_film)))

sum(sum(sum(r1_minus))) / sum(sum(sum(in_film)))
sum(sum(sum(r2_minus))) / sum(sum(sum(in_film)))
sum(sum(sum(r3_minus))) / sum(sum(sum(in_film)))
sum(sum(sum(r4_minus))) / sum(sum(sum(in_film)))