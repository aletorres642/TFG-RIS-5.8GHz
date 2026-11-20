clc; clear; close all;
% Input inicial del tamaño de la RIS
N_filas = 16;   % Tamaño Y (Alto)
N_cols  = 16;   % Tamaño X (Ancho)
% ¿A dónde queremos apuntar?
angulo_Azimut   = 30;  % Mover derecha/izquierda (Usará secuencia_X)
angulo_Elevacion = 45;  % Mover arriba/abajo (Usará secuencia_Y)
% Llamada de las funciones
fprintf('Calculando vector X para %d grados...\n', angulo_Azimut);
vec_X = secuencia_X_funcion(angulo_Azimut, N_cols);
fprintf('Calculando vector Y para %d grados...\n', angulo_Elevacion);
vec_Y = secuencia_Y_funcion(angulo_Elevacion, N_filas);
% Creación de matrices 2D
% Repetimos el vector X hacia abajo
Matriz_X = repmat(vec_X, N_filas, 1);
% Repetimos el vector Y hacia la derecha (OJO: vec_Y' para trasponer)
Matriz_Y = repmat(vec_Y', 1, N_cols);
% XOR logico que suma secuencia X y secuencia Y
% Sumamos y hacemos módulo 2 para quedarnos con 0 o 1
Matriz_Final = mod(Matriz_X + Matriz_Y, 2);

% Ploteo de todo
% --- CONFIGURACION DE COLORES (MODO OSCURO) ---
mi_mapa = [0    0.4470 0.7410;   % Azul (para el 0)
           1    1      0.9];     % Blanco hueso (para el 1)
color_fondo = [0.2 0.2 0.2];     % Gris oscuro para descansar la vista
color_texto = 'w';               % Texto blanco

figure('Name', 'Diseño RIS 1-Bit', 'Color', color_fondo, 'Position', [100 100 1200 400]);

subplot(1,3,1);
imagesc(Matriz_X); 
colormap(gca, mi_mapa); 
title(['Azimut: ' num2str(angulo_Azimut) 'º'], 'Color', color_texto, 'FontSize', 12); 
axis square; 
xlabel('X', 'Color', color_texto); ylabel('Y', 'Color', color_texto);
set(gca, 'XColor', color_texto, 'YColor', color_texto); % Ejes blancos

subplot(1,3,2);
imagesc(Matriz_Y); 
colormap(gca, mi_mapa); 
title(['Elevación: ' num2str(angulo_Elevacion) 'º'], 'Color', color_texto, 'FontSize', 12); 
axis square; 
xlabel('X', 'Color', color_texto); ylabel('Y', 'Color', color_texto);
set(gca, 'XColor', color_texto, 'YColor', color_texto); % Ejes blancos

subplot(1,3,3);
imagesc(Matriz_Final); 
colormap(gca, mi_mapa); 
title('RIS FINAL (Diagonal)', 'Color', color_texto, 'FontSize', 14, 'FontWeight', 'bold'); 
axis square; 
xlabel('X', 'Color', color_texto); ylabel('Y', 'Color', color_texto);
set(gca, 'XColor', color_texto, 'YColor', color_texto); % Ejes blancos

% Barra de referencia (Leyenda)
cb = colorbar;
cb.Ticks = [0.25 0.75];
cb.TickLabels = {'Bit 0 (Azul)', 'Bit 1 (Blanco)'};
cb.Color = color_texto; 

% Exportación de datos para feko (los 1s y 0s)
disp('--- TU MATRIZ PARA COPIAR A FEKO/CST ---');
disp(Matriz_Final);