% Transform back from film ref to crystal ref
P1_CrystalRef = (3.^(1/2).*P3_FilmRef)/3 - (2.^(1/2).*3.^(1/2).*P2_FilmRef)/3;
P2_CrystalRef = (2.^(1/2).*P1_FilmRef)/2 + (3.^(1/2).*P3_FilmRef)/3 + (6.^(1/2).*P2_FilmRef)/6;
P3_CrystalRef = (3.^(1/2).*P3_FilmRef)/3 - (2.^(1/2).*P1_FilmRef)/2 + (6.^(1/2).*P2_FilmRef)/6;