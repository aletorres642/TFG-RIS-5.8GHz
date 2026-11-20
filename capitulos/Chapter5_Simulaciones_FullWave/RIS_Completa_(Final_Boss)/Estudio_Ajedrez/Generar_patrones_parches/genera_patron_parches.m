%D_macro = 25.86e-3;
%W_macro_bit0 = 9.36e-3;
%W_macro_bit1 = 14.73e-3;

patron = repmat([ones(8,8) zeros(8,8); zeros(8,8) ones(8,8)], 1, 1);
% p1=[zeros(4,4) ones(4,4);ones(4,4) zeros(4,4)];
% p2=[zeros(2,4) ones(2,4);ones(2,4) zeros(2,4);zeros(2,4) ones(2,4);ones(2,4) zeros(2,4)];
% p3=p2';
% p4=repmat([zeros(2,2) ones(2,2);ones(2,2) zeros(2,2)],2,2);
% patron = [p2 p4;p1 p3];
[N,M]=size(patron);
cont = 0;

fid_oe=fopen('patron.txt','w');%Abrir fichero

fprintf(fid_oe,'-- Script recorded on xxxxx\n');
fprintf(fid_oe,'application = cf.Application.GetInstance()\n');
fprintf(fid_oe,'\n');

for n=1:N
    for m =1:M
        cont = cont +1;
        %posx = (-N/2-1+0.5+n)*D_macro;
        posx= strcat(num2str(-N/2-1+0.5+n),'*D_macro');
        %posy = (-M/2-1+0.5+m)*D_macro;
        posy= strcat(num2str(-M/2-1+0.5+m),'*D_macro');
        if patron(n,m)==0
            %W_macro = W_macro_bit0;
            W_macro = 'W_macro_bit0';
        else
            %W_macro = W_macro_bit1;
            W_macro = 'W_macro_bit1';
        end    
        fprintf(fid_oe,'-- AddRectangle\n');
        fprintf(fid_oe,'properties = cf.Rectangle.GetDefaultProperties()\n');
        fprintf(fid_oe,'properties.DefinitionMethod = cf.Enums.RectangleDefinitionMethodEnum.BaseAtCentre\n');
%        fprintf(fid_oe,'properties.Origin.U = "%s"\n',num2str(posx));
%        fprintf(fid_oe,'properties.Origin.V = "%s"\n',num2str(posy));
%        fprintf(fid_oe,'properties.Width = "%s"\n',num2str(W_macro));
%        fprintf(fid_oe,'properties.Depth = "%s"\n',num2str(W_macro));
        fprintf(fid_oe,'properties.Origin.U = "%s"\n',posx);
        fprintf(fid_oe,'properties.Origin.V = "%s"\n',posy);
        fprintf(fid_oe,'properties.Width = "%s"\n',W_macro);
        fprintf(fid_oe,'properties.Depth = "%s"\n',W_macro);

        fprintf(fid_oe,'properties.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane\n');
        fprintf(fid_oe,'globalXY = application.Project.Definitions.Workplanes:Item("Global XY")\n');
        fprintf(fid_oe,'properties.LocalWorkplane.ReferencedWorkplane = globalXY\n');
        fprintf(fid_oe,'rectangle%s = application.Project.Contents.Geometry:AddRectangle(properties)\n',num2str(cont));
        fprintf(fid_oe,'\n');
    end    
end

fclose all;
%{
-- Script recorded on Tue May 5 10:19:58 2026
application = cf.Application.GetInstance()

-- AddRectangle
properties = cf.Rectangle.GetDefaultProperties()
properties.DefinitionMethod = cf.Enums.RectangleDefinitionMethodEnum.BaseAtCentre
properties.Origin.U = "0.8"
properties.Origin.V = "-D/2"
properties.Width = "w1"
properties.Depth = "w1"
properties.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
globalXY = application.Project.Definitions.Workplanes:Item("Global XY")
properties.LocalWorkplane.ReferencedWorkplane = globalXY
rectangle1 = application.Project.Contents.Geometry:AddRectangle(properties)

%}

%Comandos para la consola de Matlab:

%Plotear el patron de celdas: 
figure;
imagesc(patron);
colormap(gray); % El mapa de colores de la foto de Josep
axis equal tight; % Cuadraditos perfectos y sin bordes blancos sobrantes

%Para escupir el txt: type patron.txt