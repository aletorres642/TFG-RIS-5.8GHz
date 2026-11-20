

freq = 5.8e9;
lambda = 3e8 / freq;
D_celda = 26e-3;     % Periodicidad
N_celdas = 4;       % Simulare 16 celdas por poner un ejemplo

d = D_celda / lambda; % Separacion entre parches medida en lambdas

% Segun el paper de Cui, esta secuencia logica hace que el haz se
% direccione (00110011...)
secuencia_logica = [0 0 1 1]; 

% Imponemos que:
% Bit 0: coeficiente 1
% Bit 1: coeficiente -1
an = 1 - 2 * secuencia_logica;

figure(1); title ('Secuencia 00110011... (Beam Steering)');
array_1d(an, 0, d, 1);