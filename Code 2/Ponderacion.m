function [Cw]=Ponderacion(W,C)
%% Ponderación &&
Cw=zeros(5,5);
Cw(1,:)=W(1).*C(1,:);
Cw(2,:)=W(2).*C(2,:);
Cw(3,:)=W(3).*C(3,:);
Cw(4,:)=W(4).*C(4,:);
Cw(5,:)=W(5).*C(5,:);
end