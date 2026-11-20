
f=4e9:0.001e9:8e9;
w=2*pi*f;
Z0 = 120*pi;

% Linea azul
Lo1 = 2e-9;
Lp1 = 0e-9; % Izquierda (bajar valor) / Derecha (subir valor) 
Cp1 = 0.25e-12; % Derecha (bajar valor) / Izquierda (subir valor) 
zin1=(1-w.*w*Lp1*Cp1).*(1i*w*Lo1)./(1-w.*w*(Lo1+Lp1)*Cp1); 
rho1=(zin1-Z0)./(zin1+Z0);

% Linea naranja
Lo2 = 2e-9;
Lp2 = 0e-9; % Parche !
Cp2 = 0.5e-12; % Gap !
zin2=(1-w.*w*Lp2*Cp2).*(1i*w*Lo2)./(1-w.*w*(Lo2+Lp2)*Cp2);
rho2=(zin2-Z0)./(zin2+Z0);



plot(f,unwrap(angle(rho1))*180/pi,f,unwrap(angle(rho2))*180/pi,f,unwrap(angle(rho1))*180/pi-unwrap(angle(rho2))*180/pi);grid

yline(-180, 'm:', 'LineWidth', 2, 'Label', 'Ref -180', 'Color', 'm'); 
xline(5.8e9, 'g--', 'LineWidth', 1.5, 'Label', '5.8 GHz', 'Color', 'g');
