%% Estimaci�n de la humedad puntual %%
    %% Variables de entrada 16.922	0.8	276.5555	3.6906	1.8
    T= 15.8;
    L=20.4;
    Rs=200;
    Vv=14;
    Et=2.3;
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
        Hpe=defuzz(Z,Hp,'centroid');
