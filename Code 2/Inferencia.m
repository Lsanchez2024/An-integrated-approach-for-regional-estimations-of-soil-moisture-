function Hpe=Inferencia(A)
%% Funciones de salida
Z=0:0.01:10;
MB=trimf(Z,[0 0 2]);
B=trimf(Z,[1 2.7 4.5]);
M=trimf(Z,[3 5 7]);
Al=trimf(Z,[5.5 7.2 9]);
MA=trimf(Z,[8 10 10]);

%% Funciones de salida truncadas
MBp=zeros(1,length(Z));
Bp=zeros(1,length(Z));
Mp=zeros(1,length(Z));
Alp=zeros(1,length(Z));
MAp=zeros(1,length(Z));

for i=1:length(Z)
if(MB(i)>A(1))
   MBp(i)=A(1);
else
   MBp(i)=MB(i); 
end
if(B(i)>A(2))
   Bp(i)=A(2);
else
   Bp(i)=B(i); 
end
if(M(i)>A(3))
   Mp(i)=A(3);
else
   Mp(i)=M(i); 
end
if(Al(i)>A(4))
   Al(i)=A(4);
else
   Alp(i)=Al(i); 
end
if(MA(i)>A(5))
   MAp(i)=A(5);
else
   MAp(i)=MA(i); 
end
end


%% Agregación
Hpe=zeros(1,length(Z));
for z=1:length(Z)
    Hpe(z)=max(MBp(z),max(Bp(z),max(Mp(z),max(Alp(z),MAp(z)))));
end
end