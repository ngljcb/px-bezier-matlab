function ppbez=ppbezier_join(pp1,pp2)

    % Questa funzione ppbezier_join unisce due curve di Bezier (pp1 e pp2) 
    % se hanno lo stesso grado e possono essere collegate in modo continuo, 
    % altrimenti restituisce un array vuoto. La condizione di continuità 
    % viene verificata controllando la vicinanza tra i punti finali 
    % e iniziali delle due curve con una tolleranza specificata.

    ppbez=[];
    if (pp1.deg == pp2.deg)
        tol=1.0e-2;
        ppbez=pp1;
        n1=length(pp1.ab);
        n2=length(pp2.ab);
        ncp1=length(pp1.cp(:,1));
        ncp2=length(pp2.cp(:,1));

        if (norm(pp1.cp(ncp1,:) - pp2.cp(1,:),2) <= tol)
            %caso in cui le due curve da connettere sono orientate 
            %nello stesso senso
            ppbez.ab=[pp1.ab,pp1.ab(n1)+pp2.ab(2:n2)];
            ppbez.cp=[pp1.cp;pp2.cp(2:ncp2,:)];
             
        elseif (norm(pp1.cp(ncp1,:)-pp2.cp(ncp2,:),2) <= tol)
            %caso in cui le due curve da connettere sono orientate 
            %in senso opposto
            ppbez.ab=[pp1.ab,pp1.ab(n1)+flip(pp1.ab(end:n2)-pp1.ab(1:n2-1))];
            ppbez.cp=[pp1.cp;flip(pp2.cp(1:ncp2-1,:))];
             
        else
            fprintf('Le curve sono disgiunte\n');
            ppbez=[];
        end
    else
        fprintf('Le curve non hanno stesso grado\n');
        ppbez=[];
    end
end
