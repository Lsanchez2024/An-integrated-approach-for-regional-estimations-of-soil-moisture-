function A=Ev_experta(Cw)
K=5;
I=5;
m=ones(1,I);
A=zeros(1,K);
for k=1:K
    E=zeros(1,70);
    M=Ev_selectiva(k);
    [N l]=size(M);
    for n=1:N
        for i=1:I
            if M(n,i)==0
                m(i)=1;
            else
                m(i)=Cw(i,M(n,i));
            end
        end
        E(n)=min(m);
    end
    A(k)=max(E);
end

end