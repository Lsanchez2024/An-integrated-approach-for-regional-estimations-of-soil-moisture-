function etha=Certeza(Fecha)

T=[];
L=[3,7];
R=[3,7];
V=[1,10];
E=[3,7];

etha(1)=1;
etha(2)=gaussmf(Fecha,L);
etha(3)=gaussmf(Fecha,R);
etha(4)=gaussmf(Fecha,V);
etha(5)=gaussmf(Fecha,E);
end