function main()
    
    add_path
    
    % Creo un'altra finestra grafico e applico lo sfondo
    open_figure(3);
    set(gca,'color',[0.5,1.0,0.8]);
    
    % Genero i punti della circonferenza con una curva di bezier ricavati da
    % una circonferenza a parametri equispaziati, con il centro in origine e
    % raggio pari a 10
    
    m=6; a=0; b=2;

    % Crea un vettore p di m parametri equispaziati all'interno dell'intervallo [0, 2].
    p=linspace(a,b,m); 

    % Calcola le coordinate x, y e le derivate x e y di una circonferenza con raggio 10.
    [x,y,xder,yder]=cp2_circle_mod(p, 10);
    Q=[x',y'];
    Qder=[xder',yder'];
        
    % Genero una circonferenza fatta da curva di Bezier a tratti,
    % interpolando valori Q e le loro derivate Qder
    base_circle = curv2_ppbezierCC1_interp_der(Q,Qder,p);
    
    % Disegno la circonferenza mediante curva di bezier a tratti ricavata
    % tramite interpolazione
    % curv2_ppbezier_plot(base_circle,60,'k-',2);

    % Carica file c2_bezier_mod.db con definizione curva di bezier come punto di
    % partenza per generare le curve. Uso queto file che era utilizzato nella 
    % lezione 4 in laboratorio perche noto che le curve basi sono simili.
    % Ho soltanto modificato i cp avvicinarmi di piu alla curva di base nel
    % grafico dell'esercizio.
    base_curv1=curv2_bezier_load('c2_bezier_mod.db');

    % Duplico la curva di base
    base_curv2=base_curv1;

    % Ruoto a -15 gradi la seconda curva
    base_curv2.cp=rotate_object(base_curv2.cp, -pi/12);

    % Interseco la circonferenza con la curva base_curv1
    [mat_circle_curv1_int,circle_curv1_t1,circle_curv1_t2]= curv2_intersect(base_circle,base_curv1);
    
    % Suddivido la circonferenza nel punto di intersezione
    [arc_dx,arc_sx]=ppbezier_subdiv(base_circle,circle_curv1_t1(1));
    % curv2_ppbezier_plot(arc_sx,np,'k-',2);    

    % Interseco l'arco con la curva base_curv2
    [mat_arc_curv2_int,arc_curv2_t1,arc_curv2_t2]= curv2_intersect(arc_dx,base_curv2);

    % Suddivido nel punto di intersezione
    [arco_dx,arco_sx]=ppbezier_subdiv(arc_dx,arc_curv2_t1(1));
    % curv2_ppbezier_plot(arco_sx,np,'k-',2);

    % Unisco l'arco di circonferenza e il segmento trovati
    base_curv3=ppbezier_join(base_curv1,base_curv2);
    % curv2_ppbezier_plot(base_curv3,np,'k-',2);

    % Aumento il grado del segmento fino a farlo eguagliare a quello dell'arco
    [seg] = increment_degree(arco_sx);
    [arco_sx] = increment_degree(seg);

    % Unisco l'arco e le curve
    base_curv_arc=ppbezier_join(base_curv3,arco_sx);

    % Imposto il numero di punti del disegno
    np=150;

    % Genero l'oggetto unito 12 volte, per ogni 30 gradi
    for i = 1:12
        bez_object=curv2_ppbezier_plot(base_curv_arc,np,'b-',2);
        fill(bez_object(:,1),bez_object(:,2),'r');

        % Ruoto a -15 gradi la seconda curva
        base_curv_arc.cp=rotate_object(base_curv_arc.cp, -pi/6);
    end

end