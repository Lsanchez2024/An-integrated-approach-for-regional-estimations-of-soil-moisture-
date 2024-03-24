%function [Ca Adj]=WeCoFASC(New,WrkSpc,C,Img, D)
% if New==1
clc;
clear all;
%% Lectura de archivo %%
load('elev.mat');
Tamano=[846,955];
%Z=imread('zaca.png'); % Temporada seca
Z=imread('Zac3.jpg'); % Temporada lluvias
Zr=imresize(Z,Tamano);
[Zra, Zre, Zrc, Zrs, Pv]=Carga ('Zac3a.jpg','elevacionb.png','Config.png', 'suelo.jpg','Validacionn.jpg',Tamano);
Data=Dat();

%% An�lisis de imagenes %%

[Edif Veg im_color]=Veg_cons(Zr,3,'nograf');
Vea=Veg_arb(Zra,'nograf',.01);
Veal=Veg_arb(Zra,'nograf',.01);
N=Elevacion(Zre,2,'nograf');

%% Segmentaci�n por subzonas %%

[V Va E S C]=Subzonas(Veg,Vea,Veal,Edif, 0, 0,'nograf');
load ('segmentacion.mat')
V=pasto;
Va=arb;
E=Edif;

% Se obtiene los indices de cada una de las fronteras de las zonas identificadas. 
% B contiene los valores de los bordes de las subzonas.
% L contiene las etiquetas de las subzonas.
% Bin contiene las subzonas en valores l�gicos para representaci�n gr�fica.

[B{1},L{1},Bin{1}]=zonas(V,Zra,'nograf',0,5,1,'noholes',Zra);  % Vegetaci�n 1
[B{2},L{2},Bin{2}]=zonas(Va,Zra,'nograf',0,5,1,'noholes',im_color{2}); % Vegetaci�n arb�rea 2
[B{3},L{3},Bin{3}]=zonas(E,Zra,'nograf',0,5,1,'noholes',im_color{1});% Edificios 3
[B{4},L{4},Bin{4}]=zonas(not(or(N{1},N{2})),Zra,'nograf',0,5,0,'holes',Zra); % Nivel 1 4
[B{5},L{5},Bin{5}]=zonas(N{1},Zra,'nograf',0,5,1,'noholes',Zra); % Nivel 2
[B{6},L{6},Bin{6}]=zonas(N{2},Zra,'nograf',0,5,1,'noholes',Zra); % Nivel 3
[B{7},L{7},Bin{7}]=zonas(Zrc,Zra,'nograf',1,5,1,'noholes',Zra); % Configuraci�n espacial 7/5
[B{8},L{8},Bin{8}]=zonas(Zrs,Zra,'nograf',1,100,1,'noholes',Zra); % Suelo 8/6
%[B{9},L{9},Bin{9}]=zonas(Pv,Zra,'nograf',1,0,1,'noholes',Zra); %Puntos de
%Validaci�n inecesario al usar cuadricula de archivo shp

%% Selecci�n de Caracter�sticas %%

% Vecindario %
% C_V contiene las subzonas en las que cae cada punto de validaci�n.
% nv n�mero de bits de una subzona que se encuentran dentro del punto de validaci�n
% nzv n�mero de bits que no fueron cero.
% ntbv es el n�mero total de bits del punto de validaci�n.

V_pv=Vecindario(B,9,V);
B{10}=V_pv;
C_V=Seleccion(B,Bin,10); % Selecci�n de subzona 
[nv, nzv, ntbv]=Pertenencia(B,10,C_V,Bin);% Conteo de bits en los puntos de validaci�n.
[p, phi, comp]=particfeat(n,nv,2,3,7);

%% Fuzzificaci�n
%  Constantes
%  * Vegetaci�n n(1)
%  * Vegetaci�n arb�rea n(2)
%  * Edificios n(3)
%  * Tipo de Suelo n(4)
%  * Nivel n(5,6,7)
%  * Configuraci�n Espacial n(8)
%  
%  Variables
%  * Temperatura ()
%  * Lluvia
%  * Radiaci�n Solar
%  * Velocidad del Viento
%  * Evapotranpiraci�n

%C=[18.1,0,890,16,0.5]; % Criterios de decisi�n medidos. 
%[Pd,Cd]=Fuzificacion(n,C,'nograf',phi,comp); 
%% Ajuste de Paisaje %%
[alpha Alpha]=Ldscp_Adj(comp);

% else 
%     load(WrkSpc);
% end
%% Certeza de variables climatol�gicas %%
etha=Certeza(8);

%%
Ca4=Data;
Ca16=Data;
%%

for index=1:500
%% Ajuste variable %%
    
    C=Data(index,:);
    [b Beta]=Var_Adj(C,etha,18);
    for p=1:19
        beta(p,:)=b;
    end
%% Ajuste final %%
    [Ca Adj]=Fnl_Adj(alpha, beta, C);
    Ca4(index,:)=Ca(5,:);
    Ca16(index,:)=Ca(16,:);
end
