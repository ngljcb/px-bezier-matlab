function new_pbez = increment_degree(pbez)
    % Incrementa il grado di una curva 2D di Bezier restituendo i nuovi 
    % punti di controllo; il grado del nuovo polinomio sara' g+1.

    [new_pbez.cp(:,1), new_pbez.cp(:,2)] = gc_pol_de2d(pbez.deg,pbez.cp(:,1),pbez.cp(:,2));
    new_pbez.deg=pbez.deg+1;
    new_pbez.ab=pbez.ab;
end

