function [nb_Pv, nbz, ntbits]=Pertenencia_coord(Bin,C,modo)
format long G
%% Pertenencia a subzona %%
% B estructura con los valores frontera obtenidos en la detección de subzonas.
% Bin estructura binario que identifican las carácterísticas de la zona de
%     estimación
% C Archivo *.shp que contiene los valores de los puntos de validación.
% modo. Análisis local o de vecindario.
%% Inicialización %%
    Pv=shaperead(C);
    nPv=length(Pv);       % Total de Puntos de Cuadricula.
    Car=length(Bin);    % Número de Características.
    nbz=zeros(nPv,Car);   % número de ceros por punto de validación.
    nb_Pv=zeros(nPv,Car);    % número de no ceros por punto de validación.
    ntbits=zeros(nPv,1); % número total de bits en cada subzona.
%% Cambio de coordenadas %%    
    [px_x,px_y]=Coord_chg(nPv,Pv); % Devuelve los valores forntera de los 
                                   % puntos de validación en pixeles. 

%% Análisis de la sub zona  y determinación de pertenencia%%
if(modo==1) % análisis local del punto de validación.   
    for p=1:nPv(1,1)
            Col=px_x(p,1):px_x(p,2); % Determina todos los pixeles en x que pertenencen al punto de validación
            Fil=px_y(p,2):px_y(p,1);  % Determina todos los pixeles en y que pertenencen al punto de validación
            Fi=length(Fil); %Determina subzonas cuadradas.
            Co=length(Col);
            if(Fi<Co)
                Fila=Fil;
                Columna=Col(1:Fi);
            else
                Fila=Fil(1:Co);
                Columna=Col;
            end
            cuadro=length(Fila);
            ntbits(p)=prod([abs(Fila(cuadro)-Fila(1)),abs(Columna(cuadro)-Columna(1))]); % Conteo de bits totales en el púnto de validación
        for c=1:Car
            Carac_Pv = bwselect(Bin{c},Fila,Columna,4); % Selecciona la subzona dentro de la cual se encuantra el punto de validación. 
            nbz(p,c)=nnz(Carac_Pv); % Bits de la subzona
            nb_Pv(p,c)=nnz(Carac_Pv(Fila,Columna)); %Número de Bits en el Pv
        end
    end
else
    for p=1:nPv(1,1)          
            if((px_x(p,1)-16)<1) 
                Col=1:px_x(p,2)+16; % Determina todos los pixeles en x que pertenencen al punto de validación
            elseif((px_x(p,2)+16)>954)
                Col=px_x(p,1):954; % Determina todos los pixeles en x que pertenencen al punto de validación                     
            else
                Col=px_x(p,1)-16:px_x(p,2)+16; % Determina todos los pixeles en x que pertenencen al punto de validación                                
            end
            if((px_y(p,2)-16)<1)
                Fil=1:px_y(p,1)+16;
            elseif((px_y(p,2)+16)>845)
                Fil=px_y(p,2):845;
            else
                Fil=px_y(p,2)-16:px_y(p,1)+16;            
            end
            Fi=length(Fil); %Determina subzonas cuadradas.
            Co=length(Col);
            if(Fi<Co)
                Fila=Fil;
                Columna=Col(1:Fi);
            else
                Fila=Fil(1:Co);
                Columna=Col;
            end
            cuadro=length(Fila);
            ntbits(p)=prod([abs(Fila(cuadro)-Fila(1)),abs(Columna(cuadro)-Columna(1))]); % Conteo de bits totales en el púnto de validación
            
        for c=1:Car            
            Carac_Pv = bwselect(Bin{c},Fila,Columna,4); % Selecciona la subzona dentro de la cual se encuantra el punto de validación. 
            nbz(p,c)=nnz(Carac_Pv); % Bits de la subzona
            nb_Pv(p,c)=nnz(Carac_Pv(Fila,Columna)); %Número de Bits en el Pv
        end
    end
end
end