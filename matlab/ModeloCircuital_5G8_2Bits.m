clc; clear; close all;

f = 4e9:0.001e9:8e9;
w = 2*pi*f;

% ESTADO 1 ('00') -> EL SUELO (-180º)
% Simula el parche completo (cubriendo la celda).
% EL objetivo es que se comporte como CC
Lo1 = 2e-9;
Lp1 = (1e-12);   
Cp1 = (1e-12); 
zin1 = (1-w.*w*Lp1*Cp1).*(1i*w*Lp1)./(1-w.*w*(Lo1+Lp1)*Cp1);
rho1 = (zin1-50)./(zin1+50);

% ESTADO 2 ('01') -> OBJETIVO: -90º
Lo2 = 2e-9;
Lp2 = (0.85e-9);   % Ajustar esto hace que suba y baje
Cp2 = (0.362e-12); % Ajustar esto hace que vaya de izquierda a derecha
zin2 = (1-w.*w*Lp2*Cp2).*(1i*w*Lp2)./(1-w.*w*(Lo2+Lp2)*Cp2);
rho2 = (zin2-50)./(zin2+50);

% ESTADO 3 ('10') -> OBJETIVO: 0º
% Reduce aún más Lp y Cp para subir la curva hasta el 0.
Lo3 = 2e-9;
Lp3 = (0.7e-9);   
Cp3 = (0.279e-12); 
zin3 = (1-w.*w*Lp3*Cp3).*(1i*w*Lp3)./(1-w.*w*(Lo3+Lp3)*Cp3);
rho3 = (zin3-50)./(zin3+50);

% ESTADO 4 ('11') -> OBJETIVO: +90º
% El parche más pequeño de todos.
Lo4 = 2e-9;
Lp4 = (0.55e-9);   
Cp4 = (0.193e-12); 
zin4 = (1-w.*w*Lp4*Cp4).*(1i*w*Lp4)./(1-w.*w*(Lo4+Lp4)*Cp4);
rho4 = (zin4-50)./(zin4+50);

% El ploteo
figure(1);
plot(f, unwrap(angle(rho1))*180/pi, 'LineWidth', 2, 'DisplayName', '00 (Ref -180)'); hold on;
plot(f, unwrap(angle(rho2))*180/pi, 'LineWidth', 2, 'DisplayName', '01 (Meta -90)');
plot(f, unwrap(angle(rho3))*180/pi, 'LineWidth', 2, 'DisplayName', '10 (Meta 0)');
plot(f, unwrap(angle(rho4))*180/pi, 'LineWidth', 2, 'DisplayName', '11 (Meta +90)');
grid on;

xline(5.8e9, 'g--', 'LineWidth', 1.5, 'Label', '5.8 GHz');

% Líneas objetivo (donde deben caer las curvas en 5.8G)
yline(-180, 'm:', 'LineWidth', 1.5, 'Label', 'Estado 00');
yline(-90,  'm:', 'LineWidth', 1.5, 'Label', 'Estado 01');
yline(0,    'm:', 'LineWidth', 1.5, 'Label', 'Estado 10');
yline(90,   'm:', 'LineWidth', 1.5, 'Label', 'Estado 11');

xlabel('Frecuencia (Hz)');
ylabel('Fase (Grados)');
title('Diseño RIS 2-Bits');
%legend('Location', 'best');
ylim([-240 180]);
yticks(-240:20:180);