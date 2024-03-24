function [p phi comp]=particfeat(n,nv,arbol,edif,spa_config,ntb,ntbv)
%% Selecciona las carcaterísticas particulares en los puntos devalidación %%
% Entradas %
% n.          Número de bits punto de validación
% nv.         Número de bits en el vecindario.
% arbol.      Indica en que posición del vector de cracterísticas se 
%             encuentra arboles
% edif.       Indica en que posición del vector de cracterísticas se 
%             encuentra edificios
% spa_config. Indica en que posición del vector de cracterísticas se
%             encuentra configuiración espacial
[ptos,carac]=size(n);
p=zeros(ptos,carac);
cp=zeros(ptos,carac);
for pv=1:ptos
    n(pv,spa_config)=nv(pv,arbol)+ nv(pv,edif); % Configuración espacial.
    p(pv,:)=n(pv,:)*(1/ntb(pv)); % Porcentaje características particulares
    p(pv,spa_config)=n(pv,spa_config)*(1/ntbv(pv)); %porcentaje config_espacial.
    cp(pv,:)=p(1,:)-p(pv,:); % compararción de características
end
phi=[p(:,1:4) p(:,7)];  % VEctor phi
comp=[cp(:,1:4) cp(:,7)]; %Vector de comparación
end