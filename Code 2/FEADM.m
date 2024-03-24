function [Hpe,A]=FEADM(Ca)
%% Estimaci�n de la humedad puntual %%
    %% Variables de entrada %%
%     T= 16.6;
%     L=3.4;
%     Rs=252;
%     Vv=6.3;
%     Et=2.95;
      T=Ca(1);
      L=Ca(2);
      Rs=Ca(3);
      Vv=Ca(4);
      Et=Ca(5);
    %% Toma de decisiones %%
        %% FAHP %%
           W=FAHP();
        %% Evaluaci�n Experta  %%
            % Fuzificaci�n %
            C=Fuzificacion(T,L,Rs,Vv,Et);
            % Ponderaci�n %
            Cw=Ponderacion(W,C);
            % Evaluaci�n selectiva %
            A=Ev_experta(Cw);
        %% Mejor alternativa %%

    %% Estimaci�n difusa %%
        %% Inferencia difusa %%
        Z=0:0.01:10;   
        Hp=Inferencia(A);
        if(nnz(Hp))
        Hpe=defuzz(Z,Hp,'centroid');
        else
            Hpe=0;
            warning('NO se aplico alguna regla');
        end
end