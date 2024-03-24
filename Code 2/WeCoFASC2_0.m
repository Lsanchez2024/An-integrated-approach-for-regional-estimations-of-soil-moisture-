function [Ca Adj]=WeCoFASC2_0(New,WrkSpc,C,Img,Graf,Mes)
%***** WECOFASC *****% 
% Realiza el ajuste de las condiciones climatológicas en los puntos de
% control.
%**** Entradas ****% 
% New: Bandera que determina si el análisis estatico (análisis de
%      imagenes) se debe realizar. Su valor es 1 si el análisis debe ser
%      realizado. En cualquier otro modo no se realiza el análisis de 
%      imagenes.
% WrkSpc: Si la Bandera New está desactivada, se debe enviar el archivo 
%         que contenga todas las variables para el análisis dinámico de 
%         las condiciones climatológicas.
% C: Son los datos de las condiciones climatológicas que serán ajustadas.
% Img: Son las imagenes analizadas el ordfen es el siguiente (área de
%      estimación, elevación, configuración espacial, tipo de suelo, puntos
%      de validación).
% Graf: Bandera que indica si se necesitan los gráficos de todo el
%       análisis.
% Tamano: Tamaño de las imagenes.
% Mes: Mes en el cual se hace el análisis de la estimación regional.
%**** Salidas ****%
% Ca: Condiciones meteorológicas ajustadas en cada punto de validación.
% Adj: Contiene los coeficientes de ajuste en cada punto de validación.

 if (New==1)
    %% Lectura de archivo %%
    [Zra, Zre, Zrc, Zrs]=Carga_2(Img{1},Img{2},Img{3},Img{4},Img{5},Tamano);
    
    %% Análisis de imagenes %%

    [Edif Veg im_color]=Veg_cons(Zr,3,Graf);
    Vea=Veg_arb(Zra,Graf,.01);
    Veal=Veg_arb(Zra,Graf,.01);
    N=Elevacion(Zre,2,Graf);

    %% Segmentación por subzonas %%
    % Se obtiene los indices de cada una de las fronteras de las zonas 
    % identificadas. 
    % B: contiene los valores de los bordes de las subzonas.
    % L: contiene las etiquetas de las subzonas.
    % Bin: contiene las subzonas en valores lógicos.

    [V Va E S C]=Subzonas(Veg,Vea,Veal,Edif, 0, 0,Graf);
    load ('segmentacion.mat')
    V=pasto;
    Va=arb;
    E=Edif;

    [B{1},L{1},Bin{1}]=zonas(V,Zra,Graf,0,5,1,'noholes',Zra);  % Vegetación 1
    [B{2},L{2},Bin{2}]=zonas(Va,Zra,Graf,0,5,1,'noholes',im_color{2}); % Vegetación arbórea 2
    [B{3},L{3},Bin{3}]=zonas(E,Zra,Graf,0,5,1,'noholes',im_color{1});% Edificios 3
    [B{4},L{4},Bin{4}]=zonas(not(or(N{1},N{2})),Zra,Graf,0,5,0,'holes',Zra); % Nivel 1 4
    [B{5},L{5},Bin{5}]=zonas(N{1},Zra,Graf,0,5,1,'noholes',Zra); % Nivel 2
    [B{6},L{6},Bin{6}]=zonas(N{2},Zra,Graf,0,5,1,'noholes',Zra); % Nivel 3
    [B{7},L{7},Bin{7}]=zonas(Zrc,Zra,Graf,1,5,1,'noholes',Zra); % Configuración espacial 7/5
    [B{8},L{8},Bin{8}]=zonas(Zrs,Zra,Graf,1,100,1,'noholes',Zra); % Suelo 8/6
    
    %% Selección de Características %%
    % n número de bits de una subzona que se encuentran dentro del punto de validación
    % nz número de bits que no fueron cero.
    % ntb es el número total de bits del punto de validación.

    [n, nz, ntb]=Pertenencia_coord(Bin,Img{5},1);% Conteo de bits en los puntos de validación.

    %% Características particulares %%
    % nv    Número de bits de una subzona que se encuentran dentro del punto de validación
    % nzv   Número de bits que no fueron cero.
    % ntbv  Número total de bits del punto de validación.
    % p     Características del punto de validación. 
    % phi   Características particulares en porcentaje.
    % comp  Comparación entre el punto de control primario y el rtesto de los
    %       puntos de control
    [nv, nzv, ntbv]=Pertenencia_coord(Bin,{5},2);% Conteo de bits en los puntos de validación.
    [p, phi, comp]=particfeat(n,nv,2,3,7,ntb,ntbv); % DEtermina el vector PHI y la comparación entre características partículares.

    %% Ajuste estático %%
    % Fuzzificación %
    %  Constantes
    %  * Vegetación n(1)
    %  * Vegetación arbórea n(2)
    %  * Edificios n(3)
    %  * Tipo de Suelo n(4)
    %  * Nivel n(5,6,7)
    %  * Configuración Espacial n(8)    
    % Ajuste de Paisaje %%
    [alpha Alpha]=Ldscp_Adj(comp);
 else 
        load(WrkSpc);
 end
%% Ajuste Variable %%
% Certeza de variables climatológicas %%
etha=Certeza(Mes);
% Fuzzificación %
%  Variables
%  * Temperatura ()
%  * Lluvia
%  * Radiación Solar
%  * Velocidad del Viento
%  * Evapotranpiración 
[b, Beta]=Var_Adj(C,etha,18);
beta=b.*ones(size(alpha));
%% Ajuste final %%
[Ca, Adj]=Fnl_Adj(alpha, beta, C); 
end

