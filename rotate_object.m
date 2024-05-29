function bez_object_newcp = rotate_object(bez_object_cp,radian)

    % Definisce la matrice 3x3 di rotazione 2D in base all'angolo theta in input
    rotation_matrix = get_mat2_rot(radian);

    % Utilizza la matrice di rotazione ottenuta per trasformare i punti della curva di Bezier 
    bez_object_newcp = point_trans(bez_object_cp,rotation_matrix);
    
end

