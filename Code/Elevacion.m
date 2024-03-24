function [bin]=Elevacion(Z,Niveles, graf)
    clc;
    %% Conversión a L A B %%
    forma = makecform('srgb2lab');
    lab_z = applycform(Z,forma);
    ab = double(lab_z(:,:,2:3));
    nfilas = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nfilas*ncols,2);

    %% Determinación de colores %%
    nColores =Niveles; % Para imagenes de temporada seca usar 3 colores
    [cluster_idx cluster_centro] = kmeans(ab,nColores,'distance','sqEuclidean', ...
                                      'Replicates',2);
    pixel_etiqueta = reshape(cluster_idx,nfilas,ncols);
    im_segmentadas = cell(1,nColores);
    bin = cell(1,nColores);
    etiqueta_rgb = repmat(pixel_etiqueta,[1 1 3]);
    for k = 1:nColores
        color = Z;
        color(etiqueta_rgb ~= k) = 0;
        im_segmentadas{k} = color;
        bin{k}=im2bw(im_segmentadas{k});
        if(strcmp(graf,'graf'))
            figure
            imshow(im_segmentadas{k}), title(['Objetos en Nivel', num2str(k)]);
            figure
            imshow(bin{k})
        end
    end 
end