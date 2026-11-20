function [secuencia_final] = secuencia_Y(tilt_input, N_array_input) % <--- CAMBIO: Convertido a función

% NOTA: Esto calcula cuánto tenemos que inclinar el haz respecto al 
% horizonte. Si quieres que el haz suba 20 grados hacia el cielo (o baje
% 20 hacia el suelo), pones 20. (Recordatorio: En 1-bit salen los dos
% haces, arriba y abajo).
f = 5.8e9;              % Frecuencia de trabajo
c = 3e8;                % Velocidad luz
lambda = c / f;         % Longitud de onda
D_celda = 26e-3;     % Periodicidad
d = D_celda / lambda; % Separacion entre parches medida en lambdas
% Input: el angulo de disparo deseado
% tilt_deseado = 30; % Comentado para usar input
tilt_deseado = tilt_input; % Asignamos valor

tilt_rad = tilt_deseado * pi/180; % Pasamos a radianes
fprintf('Queremos una inclinación de %.1f grados\n', tilt_deseado);
% Cálculo Ley Snell: sin(theta) = lambda/gamma
if tilt_deseado == 0
    gamma = 10000; % Infinito (caso recto)
else
    gamma = lambda/sin(tilt_rad); 
end
N = gamma/D_celda; % Número de celdas que caben en esa longitud 
fprintf('Harían falta un total de %.2f celdas para dicha inclinación\n', N);
fprintf('----------------------------------------\n'); 
% No podemos partir una celda a la mitad así que como necesitamos mínimo 
% dos bits para hacer algo, implantaremos la siguiente condición:
N_bits = round(N); % Redondeamos al entero más cercano
if N_bits < 2
    N_bits = 2;
end
% Si el numero de celdas ha sido recalculado (porque haya salido decimal), 
% volvemos a recalcular Snell:
Gamma = N_bits * D_celda;
tilt_final = asin(lambda/Gamma)*180/pi; % Por si saliese otro ángulo 
                                        % debido a la nueva gamma
tilt_real_1 = 90 - tilt_final;
tilt_real_2 = 90 + tilt_final;                                        
                                        
fprintf('Celdas reales usadas (Entero): %d\n', N_bits);
fprintf('--> Ángulos de elevación reales: %.1fº y %.1fº (Simétricos)\n', tilt_real_1, tilt_real_2);
% Ahora viene el calculo de 1s y 0s de la secuencia
num_ceros = floor(N_bits / 2); % Para calcular un número de 0s y 1s lo más 
                               % simetrico posible ; floor hace que si es
                               % impar, redondee hacia abajo
num_unos = N_bits - num_ceros;
patron = [zeros(1, num_ceros), ones(1, num_unos)]; % Crea dicho patrón
fprintf('----------------------------------------\n'); % <--- CAMBIO: Quitada N
fprintf('El patrón final será [%s]\n', num2str(patron(1:min(20, end))));
% Ahora lleno dicho patrón generado con un array grande (por ejemplo, 32
% elementos)
% N_array = 20; % Comentado para usar input
N_array = N_array_input; % Asignamos valor

% repmat repite la secuencia de bits, ceil redondea hacia arriba si la
% secuencia se queda corta, es decir, no voy a partir una secuencia a la
% mitad, ya que se inicia pues que acabe
secuencia_larga = repmat(patron, 1, ceil(N_array/N_bits)); 
secuencia_final = secuencia_larga(1:N_array); % Si el array es mas 
                                                    % largo de 32 
                                                    % elementos, se carga 
                                                    % los elementos 
                                                    % restantes
fprintf('Secuencia Completa (Array):  [%s ...]\n', num2str(secuencia_final(1:min(20, end))));
% an = 1 - 2 * secuencia_final;
% array_1d(an, 0, d, 1); % Comentado para evitar gráfica
end % Fin de función