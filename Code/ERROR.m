R=xlsread('resultados.xlsx','D2:E63');
ERMS(1)=sqrt(mean((R(:,2)-R(:,1)).^2));
EMA(1)=(mean((R(:,2)-R(:,1)).^2));

R=xlsread('resultados.xlsx','D62:E79');
ERMS(2)=sqrt(mean((R(:,2)-R(:,1)).^2));
EMA(2)=(mean((R(:,2)-R(:,1)).^2));

R=xlsread('resultados.xlsx','D80:E95');
ERMS(3)=sqrt(mean((R(:,2)-R(:,1)).^2));
EMA(3)=(mean((R(:,2)-R(:,1)).^2));
S=std(R);
Sd=sqrt(((S(1,1)^2)/16)+((S(1,2)^2)/16))