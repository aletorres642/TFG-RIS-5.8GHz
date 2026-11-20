% Ctes. físicas
c = 3e8; % Velocidad de la luz
eps0 = 8.854e-12; % Permitividad del vacío
mu0 = 4*pi*1e-7; % Permeabilidad del vacío

% Parámetros geométricos 
D = 2e-3; % Periodicidad de la celda
gap = 0.2e-3; % Hueco entre parches (w en el paper Luukkonen)
d = 1e-3; % Grosor del sustrato
eps_r = 10.2; % Permitividad relativa del sustrato 
Z0 = sqrt(mu0/eps0); % Impedancia del vacío

% Vector de frecuencia
f = 8e9:0.01e9:18e9; % Freq. de 8 a 18 GHz
w_rad = 2*pi*f; % Freq. angular 

% Permitividad efectiva
e_eff = (eps_r + 1)/2;

% Número de onda efectivo
k_eff = w_rad*sqrt(e_eff*eps0*mu0);
k0 = w_rad*sqrt(eps0*mu0); % Numero de onda en el vacio

% Parámetros de rejilla (alfa)
alfa = ((k_eff*D)/pi).*log(1./sin((pi*gap)/(2*D)));

% Preparacion Ploteo
figure;
hold on;
angulos = [0, 60, 85]; % Diferentes angulos de incidencia
colores = ['g', 'b', 'r']; % Verde, Azul, Rojo para la grafica

% Bucle para distintos angulos (Polarizacion TE)
for i = 1:length(angulos)
    theta = angulos(i)*pi/180; % Paso de grados a radianes
    
    % Impedancia del vacio para onda TE
    Z0_TE = Z0/cos(theta);
    
    % Impedancia de la rejilla de parches 
    n_eff = sqrt(mu0/(e_eff*eps0)); % Impednancia intrínseca efectiva
    factor_angulo = 1./(1-(((k0.^2)./(2*k_eff.^2))*(sin(theta).^2))); % Correccion Babinet
    Zg = -1i*(n_eff./(2*alfa)).*factor_angulo;
    
    % Impedancia del sustrato
    kz = k0.*sqrt(eps_r-sin(theta)^2); % Cte. propagacion en diagonal (Snell)
    Zd_TE = (w_rad*mu0)./kz; % Impedancia del dielectrico TE
    Zs = 1i*Zd_TE.*tan(kz*d);
    
    % Impednacia total 
    Z_inp = (Zg.*Zs)./(Zg+Zs);
    
    % Coeficiente de reflexion 
    gamma = (Z_inp-Z0_TE)./(Z_inp+Z0_TE);
    
    % Fase de reflexión en grados
    fase_grados = angle(gamma)*180/pi;
    
    % Ploteo iterativo de cada curva
    plot(f/1e9, fase_grados, colores(i), 'LineWidth', 2, 'DisplayName', ['\theta = ', num2str(angulos(i)), '^\circ']);
end

% Ajustes finales del ploteo
grid on;
xlabel('Frecuencia (GHz)');
ylabel('Fase de Reflexión (Grados)');
title('Fase de Reflexión - Modelo de Luukkonen (Fig. 8, Pol. TE)');
ylim([-180 180]);
xlim([8 18]);
legend('show', 'Location', 'northeast');
hold off;