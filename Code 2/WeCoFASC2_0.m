function [Ca Adj]=WeCoFASC2_0(New,WrkSpc,C,Img,Graf,Mes)
%***** WECOFASC *****% 
% Realiza el ajuste de las condiciones climatol�gicas en los puntos de
% control.
%**** Entradas ****% 
% New: Bandera que determina si el an�lisis estatico (an�lisis de
%      imagenes) se debe realizar. Su valor es 1 si el an�lisis debe ser
%      realizado. En cualquier otro modo no se realiza el an�lisis de 
%      imagenes.
% WrkSpc: Si la Bandera New est� desactivada, se debe enviar el archivo 
%         que contenga todas las variables para el an�lisis din�mico de 
%         las condiciones climatol�gicas.
% C: Son los datos de las condiciones climatol�gicas que ser�n ajustadas.
% Img: Son las imagenes analizadas el ordfen es el siguiente (�rea de
%      estimaci�n, elevaci�n, configuraci�n espacial, tipo de suelo, puntos
%      de validaci�n).
% Graf: Bandera que indica si se necesitan los gr�ficos de todo el
%       an�lisis.
% Tamano: Tama�o de las imagenes.
% Mes: Mes en el cual se hace el an�lisis de la estimaci�n regional.
%**** Salidas ****%
% Ca: Condiciones meteorol�gicas ajustadas en cada punto de validaci�n.
% Adj: Contiene los coeficientes de ajuste en cada punto de validaci�n.

 if (New==1)
    %% Lectura de archivo %%
    [Zra, Zre, Zrc, Zrs]=Carga_2(Img{1},Img{2},Img{3},Img{4},Img{5},Tamano);
    
    %% An�lisis de imagenes %%

    [Edif Veg im_color]=Veg_cons(Zr,3,Graf);
    Vea=Veg_arb(Zra,Graf,.01);
    Veal=Veg_arb(Zra,Graf,.01);
    N=Elevacion(Zre,2,Graf);

    %% Segmentaci�n por subzonas %%
    % Se obtiene los indices de cada una de las fronteras de las zonas 
    % identificadas. 
    % B: contiene los valores de los bordes de las subzonas.
    % L: contiene las etiquetas de las subzonas.
    % Bin: contiene las subzonas en valores l�gicos.

    [V Va E S C]=Subzonas(Veg,Vea,Veal,Edif, 0, 0,Graf);
    load ('segmentacion.mat')
    V=pasto;
    Va=arb;
    E=Edif;

    [B{1},L{1},Bin{1}]=zonas(V,Zra,Graf,0,5,1,'noholes',Zra);  % Vegetaci�n 1
    [B{2},L{2},Bin{2}]=zonas(Va,Zra,Graf,0,5,1,'noholes',im_color{2}); % Vegetaci�n arb�rea 2
    [B{3},L{3},Bin{3}]=zonas(E,Zra,Graf,0,5,1,'noholes',im_color{1});% Edificios 3
    [B{4},L{4},Bin{4}]=zonas(not(or(N{1},N{2})),Zra,Graf,0,5,0,'holes',Zra); % Nivel 1 4
    [B{5},L{5},Bin{5}]=zonas(N{1},Zra,Graf,0,5,1,'noholes',Zra); % Nivel 2
    [B{6},L{6},Bin{6}]=zonas(N{2},Zra,Graf,0,5,1,'noholes',Zra); % Nivel 3
    [B{7},L{7},Bin{7}]=zonas(Zrc,Zra,Graf,1,5,1,'noholes',Zra); % Configuraci�n espacial 7/5
    [B{8},L{8},Bin{8}]=zonas(Zrs,Zra,Graf,1,100,1,'noholes',Zra); % Suelo 8/6
    
    %% Selecci�n de Caracter�sticas %%
    % n n�mero de bits de una subzona que se encuentran dentro del punto de validaci�n
    % nz n�mero de bits que no fueron cero.
    % ntb es el n�mero total de bits del punto de validaci�n.

    [n, nz, ntb]=Pertenencia_coord(Bin,Img{5},1);% Conteo de bits en los puntos de validaci�n.

    %% Caracter�sticas particulares %%
    % nv    N�mero de bits de una subzona que se encuentran dentro del punto de validaci�n
    % nzv   N�mero de bits que no fueron cero.
    % ntbv  N�mero total de bits del punto de validaci�n.
    % p     Caracter�sticas del punto de validaci�n. 
    % phi   Caracter�sticas particulares en porcentaje.
    % comp  Comparaci�n entre el punto de control primario y el rtesto de los
    %       puntos de control
    [nv, nzv, ntbv]=Pertenencia_coord(Bin,{5},2);% Conteo de bits en los puntos de validaci�n.
    [p, phi, comp]=particfeat(n,nv,2,3,7,ntb,ntbv); % DEtermina el vector PHI y la comparaci�n entre caracter�sticas part�culares.

    %% Ajuste est�tico %%
    % Fuzzificaci�n %
    %  Constantes
    %  * Vegetaci�n n(1)
    %  * Vegetaci�n arb�rea n(2)
    %  * Edificios n(3)
    %  * Tipo de Suelo n(4)
    %  * Nivel n(5,6,7)
    %  * Configuraci�n Espacial n(8)    
    % Ajuste de Paisaje %%
    [alpha Alpha]=Ldscp_Adj(comp);
 else 
        load(WrkSpc);
 end
%% Ajuste Variable %%
% Certeza de variables climatol�gicas %%
etha=Certeza(Mes);
% Fuzzificaci�n %
%  Variables
%  * Temperatura ()
%  * Lluvia
%  * Radiaci�n Solar
%  * Velocidad del Viento
%  * Evapotranpiraci�n 
[b, Beta]=Var_Adj(C,etha,18);
beta=b.*ones(size(alpha));
%% Ajuste final %%
[Ca, Adj]=Fnl_Adj(alpha, beta, C); 
end

