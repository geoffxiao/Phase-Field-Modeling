function out = convert_latex(in)
    in = strrep(in,'C11','C_{11}');
    in = strrep(in,'C12','C_{12}');
    in = strrep(in,'C44','C_{44}');
    in = strrep(in,'Q11','Q_{11}');
    in = strrep(in,'Q12','Q_{12}');
    in = strrep(in,'Q44','Q_{44}');
    in = strrep(in,'Total_Strain_FilmRef_11','\varepsilon^{F}_{11}');
    in = strrep(in,'Total_Strain_FilmRef_22','\varepsilon^{F}_{22}');
    in = strrep(in,'Total_Strain_FilmRef_33','\varepsilon^{F}_{33}');
    in = strrep(in,'Total_Strain_FilmRef_12','\varepsilon^{F}_{12}');
    in = strrep(in,'Total_Strain_FilmRef_13','\varepsilon^{F}_{13}');
    in = strrep(in,'Total_Strain_FilmRef_23','\varepsilon^{F}_{23}');
    in = strrep(in,'P1_FilmRef','{P}^{F}_{1}');
    in = strrep(in,'P2_FilmRef','{P}^{F}_{2}');
    in = strrep(in,'P3_FilmRef','{P}^{F}_{3}');
    
    out = in;
end