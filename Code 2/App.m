

%% Conjunto de Datos %%
load ('Data.mat')
%% Variables estáticas %%
load('WrkSpc.mat')
%% Imagenes para análisis %
Img{1}='Zac3a.jpg';
Img{2}='elevacionb.png';
Img{3}='Config.png'; 
Img{4}='suelo.jpg';
Img{5}='prueba3.shp';
%% Variables %%
Graf='nograf';
WCA=cell(1,500);
SME=cell(1,500);
A_EST=cell(1,500);
smpv=zeros(length(Alpha),1);
Area_est=shaperead(Img{5});
New=0;
C=[19.5,5.8,265,13,3.8];
Mes=5;
%% Aplicación WECOFASC-FEADM %%
% for index=1:500
%     C=Data(index,:);
    [Ca, Adj]=WeCoFASC2_0(New,'WrkSpc.mat',C,Img,Graf,Mes);
    WCA{index}=Ca;
   %% Estimación de la humedad %%
    for pv=1:length(Ca)
        [smpv(pv),Alt]=FEADM(Ca(pv,:));
        Area_est(pv).Humedad=smpv(pv);
    end
    SME{index}=smpv;
    A_EST{index}=Area_est;
% end
%% Muestra de Resultados %%
Humspec = makesymbolspec('Polygon',...
        {'Humedad',0,'FaceColor','r','FaceAlpha',Transparencia}, ...
        {'Humedad',1,'FaceColor',[1 0.6 0],'FaceAlpha',Transparencia}, ...
        {'Humedad',2,'FaceColor','y','FaceAlpha',Transparencia}, ...
        {'Humedad',3,'FaceColor','g','FaceAlpha',Transparencia}, ...
        {'Humedad',4,'FaceColor','c','FaceAlpha',Transparencia}, ...
        {'Humedad',5,'FaceColor','b','FaceAlpha',Transparencia});

%% Simulación %%


