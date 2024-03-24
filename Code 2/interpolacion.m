% r=randi(1366,1,500);
% r=sort(r);
 Area=shaperead('Humedad1.shp');

for i=1:length(Area)
ID=Area(r(i)).ID;
Cor_Xr(i)=floor(ID/50);
Cor_Yr(i)=ID-(floor(ID/50)*50);
H(i)=Area(r(i)).Humedad;
end

% [Cor_Xcp,Cor_Ycp] = meshgrid(1:50, 1:50);
% Hi = griddata(Cor_Xr,Cor_Yr,H,Cor_Xcp,Cor_Ycp);

mesh(Cor_Xcp,Cor_Ycp,Hi)
hold on
plot3(Cor_Xr,Cor_Yr,H,'o')