function [Z,Ze,Zc,Zs]= Carga_2 (Za,Zae,Zac,Zas,Tamano)

Za=imread(Za); % Temporada lluvias
Z=imresize(Za,Tamano);
[row col uni]=size(Z);
Ze=imread(Zae); % Elevación OCM
Ze=imresize(Ze,[row,col]);
Zs=imread(Zas); % Tipos de suelo
Zs=imresize(Zs,[row,col]);
Zc=imread(Zac); % Edificios OCM
Zc=imresize(Zc,[row,col]);



end