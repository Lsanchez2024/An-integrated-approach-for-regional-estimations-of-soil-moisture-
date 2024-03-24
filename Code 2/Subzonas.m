function [V Va E S C]=Subzonas(Veg,Vea,Veal,Edif, Suelo, Cultivo, graf)

Va=and(Vea,not(Veg));
E=and(Edif,not(Va));
V=and(Veg,not(E));

if(strcmp(graf,'graf'))
    figure
        imshow(E)
    figure
        imshow(V)
    figure
        imshow(Va)
end
S=Suelo;
C=Cultivo;
end