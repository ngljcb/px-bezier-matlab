function [x,y,xp,yp]=cp2_circle_mod(t, radius)
    %espressione parametrica della curva circonferenza
    x = radius * cos(t);
    y = radius * sin(t);
    xp = -sin(t) * radius;
    yp = cos(t) * radius;
return