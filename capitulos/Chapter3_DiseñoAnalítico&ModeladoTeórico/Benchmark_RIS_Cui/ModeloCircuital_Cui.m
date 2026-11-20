% --- PARÁMETROS INICIALES ---
f_hz = 7e9:0.001e9:14e9;
f_ghz = f_hz / 1e9; % Convertimos el vector a GHz para la gráfica
w = 2*pi*f_hz;
Z0 = 120*pi;

% --- LÍNEA AZUL (Bit 0) ---
Lo1 = 2.76e-9;
Lp1 = 0.002e-9; 
Cp1 = 0.14236e-12; 
zin1 = (1-w.*w*Lp1*Cp1).*(1i*w*Lo1)./(1-w.*w*(Lo1+Lp1)*Cp1); 
rho1 = (zin1-Z0)./(zin1+Z0);

% --- LÍNEA NARANJA (Bit 1) ---
Lo2 = 2.76e-9;
Lp2 = 0.079e-9;
Cp2 = 0.0494e-12;
zin2 = (1-w.*w*Lp2*Cp2).*(1i*w*Lo2)./(1-w.*w*(Lo2+Lp2)*Cp2);
rho2 = (zin2-Z0)./(zin2+Z0);

% --- CÁLCULO DE FASES ---
fase1 = unwrap(angle(rho1))*180/pi;
fase2 = unwrap(angle(rho2))*180/pi;
desfase_diff = fase2 - fase1;

% --- DIBUJO DE LA GRÁFICA (FORMATO TFG GIGANTE) ---
figure; 
plot(f_ghz, fase1, 'LineWidth', 2.5); % Líneas un pelín más gruesas
hold on;
plot(f_ghz, fase2, 'LineWidth', 2.5); 
plot(f_ghz, desfase_diff, 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 2.5); 
grid on;

% --- MARCAS Y LÍNEAS DE REFERENCIA (Escala en GHz) ---
yline(180, 'm:', 'LineWidth', 2, 'Label', 'Ref 180^\circ', 'LabelHorizontalAlignment', 'left', 'FontSize', 16); 

% Línea de 10 GHz en rojo oscuro
xline(10, 'r--', 'LineWidth', 2, 'Label', '10 GHz', 'LabelHorizontalAlignment', 'center', 'LabelVerticalAlignment', 'bottom', 'FontSize', 16, 'Color', [0.7 0 0]);

% Puntos exactos de cruce en la nueva escala
plot([9.315, 11.588], [180, 180], 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

% Textos de los cruzamientos más grandes y subidos a 196 para dejar espacio libre
text(9.315, 196, '9.315 GHz', 'Color', [0.7 0 0], 'FontSize', 16, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
text(11.588, 196, '11.588 GHz', 'Color', [0.7 0 0], 'FontSize', 16, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

% --- FORMATO ESTÉTICO MAXIMIZADO ---
set(gcf, 'Color', 'w'); 
set(gca, 'Color', 'w'); 
set(gca, 'XColor', 'k', 'YColor', 'k'); 
set(gca, 'LineWidth', 1.5); % Engrosamos la línea de la caja de los ejes

% ¡NÚMEROS DE LOS EJES GIGANTES!
set(gca, 'FontSize', 18); 

% Títulos de los ejes masivos
xlabel('Frecuencia (GHz)', 'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Fase (Grados)', 'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k');

% Leyenda grande con marco bien definido
lgd = legend('Bit 0', 'Bit 1', 'Desfase Diferencial', 'Location', 'southwest', 'FontSize', 16);
set(lgd, 'TextColor', 'k', 'Color', 'w', 'EdgeColor', 'k', 'LineWidth', 1.5);

hold off;