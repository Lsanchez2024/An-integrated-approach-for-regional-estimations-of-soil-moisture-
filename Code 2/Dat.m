
function Wc=Dat()
%i=[5,32;0,25; 100,900; 0,29;0,7];
% i=[20,5; 4, 2; 600, 100; 10, 5; 2,1];
load('Data.mat')
Wc=zeros(502,5);
% Ca16=Wc;
% Ca4=Ca16;
i=sort(randi(18080,[1,510]));
for index=1:510
% Wc(:,c)= i(c,1) + (i(c,2)-i(c,1)).*rand(100,1);
% Wc(:,c)= i(c,1) + i(c,2).*randn(100,1);
Wc(index,:)=Data(i(index),2:6);
% [Ca Adj]=WeCoFASC(0,'Zac.mat',Data(index*36,2:6),'Img', 9);
% Ca4(index,:)=Ca(4,:);
% Ca16(index,:)=Ca(16,:);
end
end


