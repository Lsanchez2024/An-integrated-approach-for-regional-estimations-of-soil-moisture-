function [px_x,px_y]=Coord_chg(nPv,Pv) 
%% Cambio de coordenaadas %%
    % nPv cantidad de Puntos de validación
    % Pv Archivo *.shp que contiene los puntos de validación
    % px_x valores de x en pixeles (valor mínimo y máximo de x para cada caso)
    % px_y valores de y en pixeles (valor mínimo y máximo de y para cada caso)
    % 1. Encuentra el mínimo del archivo para detrminar espacio de trabajo.
    % 2. Forma un arreglo  con los valores frontera de los puntos de
    %    validación. 
    % 3. Redondea los valores frontera, en este caso a 5 digitos.
    % 4. Realiza el cambio de coordenadas geográficas a número de pixel en
    %    el espacio de trabajo.
    % 5. Regresa los valores forntera en pixeles.
  %% Inicialización %%
    x=zeros(nPv,2);
    y=zeros(nPv,2);
    px_x=zeros(nPv,2);
    px_y=zeros(nPv,2);
    h=845; % Altura de la imagen
    w=954; % Ancho de la imagen
    %% 1. %%
    for p=1:nPv 
        x(p,:)=Pv(p).BoundingBox(:,1)';
        y(p,:)=Pv(p).BoundingBox(:,2)';
    end
    
    %% 2. %%
    [xmin,cxmn]=min(x(:,1)); % Valor mínimo de x
    [xmax,cxmx]=max(x(:,2)); % Valor máximo de x
    [ymin,cymn]=min(y(:,1)); % Valor mínimo de y
    [ymax,cymx]=max(y(:,2));% Valor máximo de y
    coordx=xmin:(xmax-xmin)/w:xmax; % coordenadas en x
    coordy=ymin:(ymax-ymin)/h:ymax; % 5 es el número de decimales a redondear 
    
    %% 3 %%
%     coordx=round(coordx,5);% Redondeo de las coordenadas a 5 digitos
%     coordy=round(coordy,5);
%     x=round(x,5); % Redondeo de los valores de la cuadrícula a 5 digitos
%     y=round(y,5);
    %% 4 %%
    % Realiza el cambio de coordenadas a número de pixel. Obtiene el pixel
    % más cercano a la coordenadaa del punto de la cuadricula.
    e=0.0001;
    for p=1:nPv
%         pixelxm=find(coordx-x(p,1)==0);
%         pixelxmx=find(coordx-x(p,2)==0);
%         pixelym=find(coordy-y(p,1)==0);
%         pixelymx=find(coordy-y(p,1)==0);
%         if(pixelxm)
%             px_x(p,1)=pixelxm;
%             px_x(p,2)=find(abs(coordx-x(p,2))<error,1,'first'); % Cambia valor máximo x
%             px_y(p,1)=h+1-find(abs(coordy-y(p,1))<error,1,'first'); % Cambia valor mínimo de y
%             px_y(p,2)=h+1-find(abs(coordy-y(p,2))<error,1,'first'); % CAmbia valor máximo de y
%             
%         elseif(pixelxmx)
%             px_x(p,1)=find(abs(coordx-x(p,1))<error,1,'first'); % Cambia valor mínimo x
%             px_x(p,2)=pixelxmx;
%             px_y(p,1)=h+1-find(abs(coordy-y(p,1))<error,1,'first'); % Cambia valor mínimo de y
%             px_y(p,2)=h+1-find(abs(coordy-y(p,2))<error,1,'first'); % CAmbia valor máximo de y
%             
%         elseif(pixelym)
%             px_x(p,1)=find(abs(coordx-x(p,1))<error,1,'first'); % Cambia valor mínimo x
%             px_x(p,2)=find(abs(coordx-x(p,2))<error,1,'first'); % Cambia valor máximo x
%             px_y(p,1)=pixelym;
%             px_y(p,2)=h+1-find(abs(coordy-y(p,2))<error,1,'first'); % CAmbia valor máximo de y
%             
%         elseif(pixelymx)
%             px_x(p,1)=find(abs(coordx-x(p,1))<error,1,'first'); % Cambia valor mínimo x
%             px_x(p,2)=find(abs(coordx-x(p,2))<error,1,'first'); % Cambia valor máximo x
%             px_y(p,1)=h+1-find(abs(coordy-y(p,1))<error,1,'first'); % Cambia valor mínimo de y
%             px_y(p,2)=pixelymx;
%             
%         else
%         px_x(p,1)=find(abs(coordx-x(p,1))<error,1,'first'); % Cambia valor mínimo x
%         px_x(p,2)=find(abs(coordx-x(p,2))<error,1,'first'); % Cambia valor máximo x
%         px_y(p,1)=h+1-find(abs(coordy-y(p,1))<error,1,'first'); % Cambia valor mínimo de y
%         px_y(p,2)=h+1-find(abs(coordy-y(p,2))<error,1,'first'); % CAmbia valor máximo de y
%         end
        pixelxm=find(abs(coordx-x(p,1))<e);
        lpixm=length(pixelxm);
        pixelxmx=find(abs(coordx-x(p,2))<e);
        lpixmx=length(pixelxmx);
        pixelym=find(abs(coordy-y(p,1))<e);
        lpiym=length(pixelym);
        pixelymx=find(abs(coordy-y(p,2))<e);
        lpiymx=length(pixelymx);
        
        if(lpixm>1)
            [xm,ixm]=min(abs(coordx(pixelxm(1):pixelxm(lpixm))-(x(p,1)*ones(1,lpixm))));
            px_x(p,1)=pixelxm(ixm);
        else
            px_x(p,1)=pixelxm;
        end
        if(lpixmx>1)
            [xmx,ixmx]=min(abs(coordx(pixelxmx(1):pixelxmx(lpixmx))-(x(p,1)*ones(1,lpixmx))));
            px_x(p,2)=pixelxmx(ixmx);     
        else
            px_x(p,2)=pixelxmx;
        end
        if(lpiym>1)
            [ym,iym]=min(abs(coordy(pixelym(1):pixelym(lpiym))-(y(p,1)*ones(1,lpiym))));
            px_y(p,1)=h+1-pixelym(iym);     
        else
            px_y(p,1)=h+1-pixelym;    
        end
        if(lpiymx>1)
            [ymx,iymx]=min(abs(coordy(pixelymx(1):pixelymx(lpiymx))-(y(p,1)*ones(1,lpiymx))));
            px_y(p,2)=h+1-pixelymx(iymx);
        else
            px_y(p,2)=h+1-pixelymx;    
        end
    end
end