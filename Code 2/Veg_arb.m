function Vea=Veg_arb(Z,graf,v_decorr)
%% Decorrelaci�n %%

Za = decorrstretch(Z, 'Tol', v_decorr);

%% Descomposci�n en canales %%

Zrojo  =Z(:,:,1);           % Canal rojo   (1� canal)
Zverde = Z(:,:,2);          % Canal verde (2� canal)
Zazul = Z(:,:,3);           % Canal azul  (3� canal)
ndvi = (-Zverde + Zrojo) ./ (Zrojo + Zverde); 
Umbral = 0.5;
Vea = (ndvi > Umbral);% Conversi�n a binario
Vea=not(Vea);

%% Resultados e imagenes %%
if(strcmp(graf,'graf'))
    % Decorrelaci�n %
    figure
    imshow(Za)
    title('Imagen satelital de Zacatenco bajo la correlaci�n estrecha')

    % Descomposci�n en canales %
    figure
    imshow(Zrojo)
    title('Imagen satelital de Zacatenco banda roja')
    figure
    imshow(Zverde)
    title('Imagen satelital de Zacatenco banda verde')
    figure
    imshow(Zazul)
    title('Imagen satelital de Zacatenco banda azul')

    % �ndice de Vegetaci�n %
    figure
    imshow(Vea)
    title('Vegetaci�n (arb�rea)')
end
end
