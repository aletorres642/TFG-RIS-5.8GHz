% Ctes. físicas
c = 3e8; % Velocidad de la luz
eps0 = 8.854e-12; % Permitividad del vacío
mu0 = 4*pi*1e-7; % Permeabilidad del vacío
Z0 = sqrt(mu0/eps0); % Impedancia del vacío

% Parametros geometricos
D = 8.62e-3; % Periodicidad de la celda
h = 1.6e-3; % Grosor del sustrato
h_air = 2.4e-3; % Grosor cámara aire
eps_r = 4.4; % Permitividad relativa del sustrato 
eps_r_air = 1; % Permitividad del aire

% Definicion estados (gaps)
% Aumentar --> Derecha | Dismunuir --> Izquierda
gap1 = 1.2e-3;  % Hueco Estado 1 
gap0 = 4.5e-3;  % Hueco Estado 0 

% Vector de frecuecnia y propagacion
f = 4e9:0.01e9:8e9; % Freq. de 4 a 8 GHz
w_rad = 2*pi*f; % Freq. angular 

% Permitividad efectiva y números de onda
e_eff = (eps_r + 1)/2;
k_eff = w_rad*sqrt(e_eff*eps0*mu0);
k0 = w_rad*sqrt(eps0*mu0); 
n_eff = sqrt(mu0/(e_eff*eps0)); % Impedancia intrínseca efectiva

% Ángulo de incidencia 
theta = 0 * pi/180; 
Z0_TE = Z0/cos(theta);
factor_angulo = 1./(1-(((k0.^2)./(2*k_eff.^2))*(sin(theta).^2))); 

% Propagación capa aire
kz_air = k0.*sqrt(eps_r_air-sin(theta)^2);
Zd_air = (w_rad*mu0)./kz_air;

% Propagación F4B
kz = k0.*sqrt(eps_r-sin(theta)^2); % Cte. propagación en diagonal (Snell)
Zd_TE = (w_rad*mu0)./kz; % Impedancia del dieléctrico TE

% Impedancia del sustrato (Común para ambos estados)
Z_in_air = 1i*Zd_air.*tan(kz_air*h_air); % Impedancia de entrada de la LT del Aire (CC)
Zs = Zd_TE.*(Z_in_air + 1i * Zd_TE .* tan(kz .* h)) ./ (Zd_TE + 1i * Z_in_air .* tan(kz .* h)); % Impedancia total equivalente que "ve" la rejilla de parches hacia abajo

% Estado 1
alfa1 = ((k_eff*D)/pi).*log(1./sin((pi*gap1)/(2*D)));
Zg1 = -1i*(n_eff./(2*alfa1)).*factor_angulo;
Z_inp1 = (Zg1.*Zs)./(Zg1+Zs);
gamma1 = (Z_inp1-Z0_TE)./(Z_inp1+Z0_TE);
fase1 = unwrap(angle(gamma1))*180/pi;

% Estado 0
alfa0 = ((k_eff*D)/pi).*log(1./sin((pi*gap0)/(2*D)));
Zg0 = -1i*(n_eff./(2*alfa0)).*factor_angulo;
Z_inp0 = (Zg0.*Zs)./(Zg0+Zs);
gamma0 = (Z_inp0-Z0_TE)./(Z_inp0+Z0_TE);
fase0 = unwrap(angle(gamma0))*180/pi;

% Diferencia de fase
fase_diff = abs(fase1 - fase0);
fase_diff = mod(fase_diff, 360); % Mantiene la diferencia en el rango 0-360

% Ploteo resultados
figure;
hold on;
plot(f/1e9, fase1, 'b', 'LineWidth', 2, 'DisplayName', 'Estado 1');
plot(f/1e9, fase0, 'r', 'LineWidth', 2, 'DisplayName', 'Estado 0');
plot(f/1e9, fase_diff, 'g', 'LineWidth', 2, 'DisplayName', '\Delta\Phi Diferencia');

% Líneas de referencia
yline(180, 'm:', 'LineWidth', 2, 'DisplayName', 'Ref 180^\circ'); 

grid on;
xlabel('Frecuencia (GHz)');
ylabel('Fase de Reflexión (Grados)');
title('Comparativa de Estados - Modelo Luukkonen');
ylim([-200 360]);
xlim([min(f)/1e9 max(f)/1e9]);
legend('show', 'Location', 'best');
hold off;

% Exportacion de datos para postfeko

% 1. Reestructurar los vectores gamma a matrices 1x1xN para rfwrite

S_estado1 = reshape(gamma1, [1, 1, length(f)]);
S_estado0 = reshape(gamma0, [1, 1, length(f)]);

% 2. Crear los objetos oficiales asociándoles las frecuencias y la impedancia Z0_TE
sp_1 = sparameters(S_estado1, f, Z0_TE);
sp_0 = sparameters(S_estado0, f, Z0_TE);

% 3. Escribir los archivos .s1p 

%rfwrite(sp_1, 'F4B_Estado1.s1p');
%rfwrite(sp_0, 'F4B_Estado0.s1p');

W1 = D - gap1; fprintf('El valor de W para el estado 1 es: %.4f mm\n', W1);
W0 = D - gap0; fprintf('El valor de W para el estado 0 es: %.4f mm\n', W0);