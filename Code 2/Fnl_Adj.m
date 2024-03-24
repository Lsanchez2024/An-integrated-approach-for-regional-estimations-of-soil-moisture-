function [Ca adj]=Fnl_Adj(alpha, Beta,C)

[ptos carac]=size(alpha);
adj=alpha+Beta+ones(ptos,carac);
Ca=C.*adj;
end