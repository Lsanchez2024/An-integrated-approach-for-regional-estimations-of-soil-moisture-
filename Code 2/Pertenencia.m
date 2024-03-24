function [n, nz, ntbits]=Pertenencia(B,Puntos,C_Sz,Bin)
% Pertenencia a subzona
    Pv=size(B{Puntos}); % Puntos de Validaci�n
    Car=size(Bin); % Caracter�sticas
    sup=zeros(Pv(1,1),2); % L�mite Superior de Punto de Validaci�n.
    inf=zeros(Pv(1,1),2); % L�mite Inferior de Punto de Validaci�n
    nz=zeros(Pv(1,1),Car(1,2));
    n=zeros(Pv(1,1),Car(1,2));
    ntbits=zeros(Pv(1,1),1);
    for p=1:Pv(1,1)
        sup(p,:)=max(B{Puntos}{p});
        inf(p,:)=min(B{Puntos}{p});
        ntbits(p)=prod(sup(p,:)-inf(p,:));
        for c=1:Car(1,2)
            nz(p,c)=nnz(C_Sz{p}{c}); % Bits de la subzona
            n(p,c)=nnz(C_Sz{p}{c}(inf(p,1):sup(p,1),inf(p,2):sup(p,2))); %Bits en el Pv
        end
    end 
end
