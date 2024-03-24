function Vea=Veg_arb(Z,graf,v_decorr)
%% Decorrelación %%

Za = decorrstretch(Z, 'Tol', v_decorr);

%% Descomposción en canales %%

Zrojo  =Z(:,:,1);           % Canal rojo   (1° canal)
Zverde = Z(:,:,2);          % Canal verde (2° canal)
Zazul = Z(:,:,3);           % Canal azul  (3° canal)
ndvi = (-Zverde + Zrojo) ./ (Zrojo + Zverde); 
Umbral = 0.5;
Vea = (ndvi > Umbral);% Conversión a binario
Vea=not(Vea);

%% Resultados e imagenes %%
if(strcmp(graf,'graf'))
    % Decorrelación %
    figure
    imshow(Za)
    title('Imagen satelital de Zacatenco bajo la correlación estrecha')

    % Descomposción en canales %
    figure
    imshow(Zrojo)
    title('Imagen satelital de Zacatenco banda roja')
    figure
    imshow(Zverde)
    title('Imagen satelital de Zacatenco banda verde')
    figure
    imshow(Zazul)
    title('Imagen satelital de Zacatenco banda azul')

    % Índice de Vegetación %
    figure
    imshow(Vea)
    title('Vegetación (arbórea)')
end
end
