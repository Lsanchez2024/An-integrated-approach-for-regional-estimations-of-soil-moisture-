function [B L bin] = zonas(Zz, Z,graf,img,res,Hueco,H_f,I_Seg)
%% Identificación de objetos %%
    if (img==0)
        bin=Zz;
    else
        bin=im2bw(Zz);
    end
    a = bwareaopen(bin,res); % Quita objetos menores a resolucion pixeles
    se = strel('square',2); % Rellena todos los huecos de los objetos
    a = imclose(a,se);
    if(Hueco)
    a = imfill(a,'holes'); % Llena el área para estimar la frontera del objeto
    end
        
    [B,L] = bwboundaries(a,H_f);
    if(strcmp(graf,'graf'))
        figure
        hold on
        imshow(Z)
        hold on
        imshow(label2rgb(L, @jet, [0 0 0])) % Muestra la matriz etiquetas 
                                                % y los limites
        figure
        hold on
        imshow(I_Seg);
    end
    for k = 1:length(B)
        boundary = B{k};
        
        if(strcmp(graf,'graf'))
            hold on
            plot(boundary(:,2), boundary(:,1), 'Color','b','LineWidth',2)
        end
    end
end