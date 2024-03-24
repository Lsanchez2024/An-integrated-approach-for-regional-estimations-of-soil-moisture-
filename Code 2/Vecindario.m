function V_pv=Vecindario(B,Puntos,Imagen)
 
    V=size(B{Puntos}); % Puntos de Validación
    Lim_i=size(Imagen); % Características
    supv=zeros(V(1,1),2); % Límite Superior de Vecindario.
    infv=zeros(V(1,1),2); % Límite Inferior de Vecindario
    V_pv=cell(V);
    for p=1:V(1,1)
        bits= max(B{Puntos}{p})-min(B{Puntos}{p});
        supv(p,:)=max(B{Puntos}{p})+bits(1);
        infv(p,:)=min(B{Puntos}{p})-bits(1);
        
        if(supv(p,1)>Lim_i(1))
           supv(p,1)= Lim_i(1);
        end
        if(supv(p,2)>Lim_i(2))
           supv(p,2)= Lim_i(2);
        end
        if(infv(p,1)<0)
           infv(p,1)=0;
        end
        if(infv(p,2)<0)
           infv(p,2)= 0;
        end       
    y=[infv(p,1)*ones(1,(bits(1)*3)),infv(p,1):supv(p,1), supv(p,1)*ones(1,(bits(2)*3)),sort(infv(p,1):supv(p,1),'descend')]';
    ty=size(y);
    x=[infv(p,2):supv(p,2),supv(p,2)*ones(1,((bits(1))*3)),sort(infv(p,2):supv(p,2),'descend'),infv(p,2)*ones(1,(bits(1)*3))]';
    tx=size(x);
    if(tx(1)>ty(1))
    V_pv{p}=[y,x(1:ty(1))];
    else
    V_pv{p}=[y(1:tx(1)),x];    
    end
   end 
end 
