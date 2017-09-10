% Transform back from film ref to crystal ref
P1_CrystalRef = (2.^(1/2).*P3_FilmRef)/2 - (2.^(1/2).*P2_FilmRef)/2;
P2_CrystalRef = P1_FilmRef;
P3_CrystalRef = (2.^(1/2).*P2_FilmRef)/2 + (2.^(1/2).*P3_FilmRef)/2;