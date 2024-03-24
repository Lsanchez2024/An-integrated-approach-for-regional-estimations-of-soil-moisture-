function [p phi comp]=particfeat(n,nv,arbol,edif,spa_config,ntb,ntbv)
%% Selecciona las carcater�sticas particulares en los puntos devalidaci�n %%
% Entradas %
% n.          N�mero de bits punto de validaci�n
% nv.         N�mero de bits en el vecindario.
% arbol.      Indica en que posici�n del vector de cracter�sticas se 
%             encuentra arboles
% edif.       Indica en que posici�n del vector de cracter�sticas se 
%             encuentra edificios
% spa_config. Indica en que posici�n del vector de cracter�sticas se
%             encuentra configuiraci�n espacial
[ptos,carac]=size(n);
p=zeros(ptos,carac);
cp=zeros(ptos,carac);
for pv=1:ptos
    n(pv,spa_config)=nv(pv,arbol)+ nv(pv,edif); % Configuraci�n espacial.
    p(pv,:)=n(pv,:)*(1/ntb(pv)); % Porcentaje caracter�sticas particulares
    p(pv,spa_config)=n(pv,spa_config)*(1/ntbv(pv)); %porcentaje config_espacial.
    cp(pv,:)=p(1,:)-p(pv,:); % compararci�n de caracter�sticas
end
phi=[p(:,1:4) p(:,7)];  % VEctor phi
comp=[cp(:,1:4) cp(:,7)]; %Vector de comparaci�n
end