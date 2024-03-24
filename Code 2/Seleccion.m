function Carac_Sz=Seleccion(B,Bin,Puntos)
   % Selección de Carcaterísticas de puntos de validación
    Ptos_val=size(B{Puntos});
    Carac=size(Bin);
    Carac_Sz=cell(Ptos_val(1,1),1);
    for pv=1:Ptos_val(1,1)
        if(find([1,2,10,14,17,18,19],pv))
            Fila=B{Puntos}{pv}(:,2);
            Col=B{Puntos}{pv}(:,1);
        else
            Fila=B{Puntos}{pv}(:,1);
            Col=B{Puntos}{pv}(:,2);
        end
        for c=1:Carac(1,2)
            Carac_Sz{pv}{c} = bwselect(Bin{c},Fila,Col,4);
        end
    end
end
