% Transform
C_FilmRef = zeros(3,3,3,3);

for i_ind = 1 : 3
for j_ind = 1 : 3
for k_ind = 1 : 3
for l_ind = 1 : 3
    
    for m_ind = 1 : 3
    for n_ind = 1 : 3
    for o_ind = 1 : 3
    for p_ind = 1 : 3

        C_FilmRef(i_ind,j_ind,k_ind,l_ind) = Transform_Matrix(i_ind,m_ind) * Transform_Matrix(j_ind,n_ind) * Transform_Matrix(k_ind,o_ind) * Transform_Matrix(l_ind,p_ind) * C_CrystalRef(m_ind,n_ind,o_ind,p_ind) + C_FilmRef(i_ind,j_ind,k_ind,l_ind);

    end
    end
    end
    end
    
end
end
end
end