clc; clear; close all;

% ==========================================
% 1. TUS VALORES DE MATLAB (Entrada)
% ==========================================
freq = 5.8e9;
D    = 26e-3;    % Periodicidad (26mm)
Er   = 4.4;      % FR-4

% Valores que te han funcionado en el tuning:
Lo  = 2e-9; 
Lp1 = 4e-9;    Cp1 = 0.2025e-12;
Lp2 = 5.7e-9;  Cp2 = 0.1155e-12;

% ==========================================
% 2. CONSTANTES FÍSICAS
% ==========================================
eo = 8.854187e-12;
uo = 4*pi*1e-7;

% ==========================================
% 3. CÁLCULO DE DIMENSIONES REALES
% ==========================================

% --- A) EL GROSOR DEL SUSTRATO (h) ---
% La inductancia del plano de masa es L = u0 * h
h_real = Lo / uo;

% --- B) EL ANCHO DEL PARCHE (W) ---
% La capacidad del gap (Cp) sigue una ley logarítmica según la separación (g)
% Despejamos 'g' de la fórmula de estructuras periódicas:
calc_gap = @(C) (2*D/pi) * asin(exp( -(C*pi) / (D*eo*(Er+1)) ));

g1 = calc_gap(Cp1); % Separación para Bit 0
g2 = calc_gap(Cp2); % Separación para Bit 1

% El ancho del parche metálico es la celda menos el hueco
W1 = D - g1;
W2 = D - g2;

% ==========================================
% 4. RESULTADOS (Lo que pondrás en FEKO)
% ==========================================
fprintf('================================================\n');
fprintf('   RESULTADOS FÍSICOS PARA LA RIS (5.8 GHz)\n');
fprintf('================================================\n');
fprintf('ESTRUCTURA FIJA:\n');
fprintf('  - Grosor del sustrato (h):  %.2f mm (Usa 1.6 mm)\n', h_real*1000);
fprintf('  - Tamaño de celda (D):      %.2f mm\n', D*1000);
fprintf('\n');

fprintf('DISEÑO BIT 0 (Azul en tu gráfica):\n');
fprintf('  - Ancho del parche (W1):    %.2f mm\n', W1*1000);
fprintf('  - Gap entre celdas (g1):    %.2f mm\n', g1*1000);
fprintf('\n');

fprintf('DISEÑO BIT 1 (Rojo en tu gráfica):\n');
fprintf('  - Ancho del parche (W2):    %.2f mm\n', W2*1000);
fprintf('  - Gap entre celdas (g2):    %.2f mm\n', g2*1000);
fprintf('================================================\n');