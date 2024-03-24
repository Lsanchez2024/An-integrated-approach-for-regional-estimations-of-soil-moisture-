function [Edif Veg im_segmentadas]=Veg_cons(Z,nColores,graf)
%% Conversión a L A B %%

forma = makecform('srgb2lab');
lab_z = applycform(Z,forma);
ab = double(lab_z(:,:,2:3));
nfilas = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nfilas*ncols,2);

%% Determinación de colores %%
% nColores  Para imagenes de temporada seca usar 3 colores de otra forma 2 %
[cluster_idx cluster_centro] = kmeans(ab,nColores,'distance','sqEuclidean', ...
                                      'Replicates',3);
pixel_etiqueta = reshape(cluster_idx,nfilas,ncols);
% if(strcmp(graf,'graf'))
%     figure
%     imshow(pixel_etiqueta,[]), title('image labeled by cluster index');
% end
im_segmentadas = cell(1,3);
etiqueta_rgb = repmat(pixel_etiqueta,[1 1 3]);

for k = 1:nColores
    color = Z;
    color(etiqueta_rgb ~= k) = 0;
    im_segmentadas{k} = color;% Resultado
    if(strcmp(graf,'graf'))
       figure
       imshow(im_segmentadas{k}); 
    end
end
%% Transformación a imagenes bianrias %%
[h indice]=sort(cluster_centro);
Veg=rgb2gray(im_segmentadas{indice(1,1)}); % Vegetación 
% if(strcmp(graf,'graf'))
%     figure
%     imshow(Veg)
% end

Umbral = 0.5; % Vegetración con umbral
Veg = (Veg > Umbral);
if(strcmp(graf,'graf'))
    figure
    imshow(Veg);
    title('Vegetación')

end

Edif=rgb2gray(im_segmentadas{indice(1,2)}); % Edificaciones
% if(strcmp(graf,'graf'))
%     figure
%     imshow(Edif)
% end
Umbral = 0.5;
Edif = (Edif > Umbral);% Edificaciones con umbral
if(strcmp(graf,'graf'))
    figure
    imshow(Edif);
    title('Edificios')
end
end