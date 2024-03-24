function C=Fuzificacion(T,L,Rs,Vv,Et)
%% Temperatura
%x=0:0.01:40;
x=T;
N=trapmf(x,[-5 -1 0 6]);
B=trimf(x,[4 10 16]);
M=trimf(x,[14 19 24]);
MB=trimf(x,[22 27 32]);
E=trapmf(x,[30 36 50 55]);
T=[N,B,M,MB,E];
%% LLUVIA
%x=0:0.01:15;
x=L;
N=trimf(x,[0 0 1]);
B=trimf(x,[.8 1.5 2.2]);
M=trimf(x,[1.9 3.8 6]);
MB=trimf(x,[5 8 12]);
E=trapmf(x,[10 18 25 35]);
L=[N,B,M,MB,E];
 %% SOL
% x=0:0.01:10;
x=Rs;
N=trimf(x,[0,0,150]);
B=trimf(x,[120,180,240]);
M=trimf(x,[220,400,580]);
MB=trimf(x,[560,700,840]);
E=trapmf(x,[820,1000,1399,1400]);
Rs=[N,B,M,MB,E];
%% VIENTO
% x=0:0.01:10;
x=Vv;
N=trimf(x,[0,0,5]);
B=trimf(x,[4,8,12]);
M=trimf(x,[10,15,20]);
MB=trimf(x,[18,25,32]);
E=trapmf(x,[30,40,99,100]);
Vv=[N,B,M,MB,E];
%% ET
%x=0:0.01:10;
x=Et;
N=trimf(x,[0,0,1]); %(x,[0,0,0.8]);
B=trimf(x,[0.6,1.6,2.6]); %(x,[0.6,1.2,1.8]);
M=trimf(x,[2.3,3.3,4.3]); %(x,[1.5,2,2.5]);
MB=trimf(x,[4,5,6]); %(x,[2.2,3,3.8]);
E=trapmf(x,[5.7,6.7,9.9,10]);%(x,[3.6,4,10]);
Et=[N,B,M,MB,E];
%% Matriz de Criterios C %%
C=[T;L;Rs;Vv;Et];

%% Gráficas %%
% figure
% plot(x,N,'LineWidth',2)
% hold all;
% plot(x,B,'LineWidth',2)
% hold all;
% plot(x,M,'LineWidth',2)
% hold all;
% plot(x,MB,'LineWidth',2)
% hold all;
% plot(x,E,'LineWidth',2)
% hold all
% plot (x,Np,'LineWidth',2)
% hold all
% plot (x,Bp,'LineWidth',2)
% hold all
% plot (x,Mp,'LineWidth',2)
% hold all
% plot (x,MBp,'LineWidth',2)
% hold all
% plot (x,Ep,'LineWidth',2)
% grid on;
% ylabel('u(x)')
% %xlabel('            Very Low     Low         Medium                         High                           Very High                          ')
% % legend('Nula','Baja','Media','Buena','Excesiva')
% title('Funciones de membresía de la humedad del suelo')
end