r1_plus = ( P1_CrystalRef > 0.3 ) & ( P2_CrystalRef > 0.3 ) & ( P3_CrystalRef > 0.3 );
r2_plus = ( P1_CrystalRef < -0.3 ) & ( P2_CrystalRef > 0.3 ) & ( P3_CrystalRef > 0.3 );
r3_plus = ( P1_CrystalRef < -0.3 ) & ( P2_CrystalRef < -0.3 ) & ( P3_CrystalRef > 0.3 );
r4_plus = ( P1_CrystalRef > 0.3 ) & ( P2_CrystalRef < -0.3 ) & ( P3_CrystalRef > 0.3 );

r1_minus = ( P1_CrystalRef < -0.3 ) & ( P2_CrystalRef < -0.3 ) & ( P3_CrystalRef < -0.3 );
r2_minus = ( P1_CrystalRef > 0.3 ) & ( P2_CrystalRef < -0.3 ) & ( P3_CrystalRef < -0.3 );
r3_minus = ( P1_CrystalRef > 0.3 ) & ( P2_CrystalRef > 0.3 ) & ( P3_CrystalRef < -0.3 );
r4_minus = ( P1_CrystalRef < -0.3 ) & ( P2_CrystalRef > 0.3 ) & ( P3_CrystalRef < -0.3 );

sum(sum(sum(r1_plus))) / sum(sum(sum(in_film)))
sum(sum(sum(r2_plus))) / sum(sum(sum(in_film)))
sum(sum(sum(r3_plus))) / sum(sum(sum(in_film)))
sum(sum(sum(r4_plus))) / sum(sum(sum(in_film)))

sum(sum(sum(r1_minus))) / sum(sum(sum(in_film)))
sum(sum(sum(r2_minus))) / sum(sum(sum(in_film)))
sum(sum(sum(r3_minus))) / sum(sum(sum(in_film)))
sum(sum(sum(r4_minus))) / sum(sum(sum(in_film)))