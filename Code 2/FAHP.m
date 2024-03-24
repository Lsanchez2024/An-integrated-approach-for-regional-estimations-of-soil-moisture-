%% Funcion FAHP %%
function [w]=FAHP()

%% Valores de Relevancia %%
EIn=[1/9 1/8 1/7];
MIn=[1/8 1/6 1/4];
In=[1/6 1/4 1/2];
PIn=[1/3 1/2 1];
IIm=[1 1 1];
PIm=[1 2 3];
Im=[2 4 6];
MIm=[4 6 8];
EIm=[7 8 9];

%% Definicón de J %%

% J={IIm, IIm, Im,  PIm, MIm; 
%    IIm, IIm, EIn, MIn, MIn;
%    In,  EIn, IIm, PIn, PIn;
%    PIm, MIn, PIm, IIm, PIm;
%    MIm, MIn, PIm, PIn, IIm};

Criterios=['Ambiente','Precipitación','Viento','Radiación','ET']';
J={IIm, IIm, PIm, PIm, PIm; 
   IIm, IIm, Im,  MIm, MIm;
   PIn, PIn, IIm, MIm, PIm;
   PIn, MIn, MIn, IIm, IIm;
   PIn, MIn, PIm, IIm, IIm};

%%
T1=zeros(1,5);
T2=zeros(1,5);
T3=zeros(1,5);
Suma1=zeros(5,3);
S=zeros(5,3);

for m=1:5
    T1(m)=J{m,1}(1)+ J{m,2}(1)+J{m,3}(1)+J{m,4}(1)+J{m,5}(1);  % l
    T2(m)=J{m,1}(2)+ J{m,2}(2)+J{m,3}(1)+J{m,4}(2)+J{m,5}(2);  % m
    T3(m)=J{m,1}(3)+ J{m,2}(3)+J{m,3}(1)+J{m,4}(3)+J{m,5}(3);  % u
    Suma1(m,:)=[T1(m) T2(m) T3(m)]; %(4)
end

    Suma2=[sum(T1), sum(T2), sum(T3)]; %(5)
for m=1:5
    Inverso=[1/(T1(m)+Suma2(3)),1/Suma2(2),1/(T3(m)+Suma2(1))]; %(6)
    S(m,:)=Suma1(m,:).*Inverso; %(3)
end

%% 
alpha=.5;
for m=1:5
    I(m)=(1/2)*(alpha*S(m,3)+S(m,2)+(1-alpha)*S(m,1));
    It=sum(I(m));
end

for m=1:5
    w(m)=I(m)/It;
end
w=w./sum(w);
w_d=[.2 .35 .25 .1 .1];
end

