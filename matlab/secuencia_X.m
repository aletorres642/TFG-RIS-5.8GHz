
% NOTA INICIAL: hay que tener en cuenta que estamos haciendo una resta
% respecto a la normal, si queremos que apunte a 20 grados: 90 - 70 = 20,
% en el parámetro theta deseada habrá que poner 70 grados !!!!!

f = 5.8e9;              % Frecuencia de trabajo
c = 3e8;                % Velocidad luz
lambda = c / f;         % Longitud de onda

D_celda = 26e-3;     % Periodicidad
d = D_celda / lambda; % Separacion entre parches medida en lambdas

% Input: el angulo de disparo deseado
theta_deseada = 30; % Ojo que está en grados
theta_real = 90 - theta_deseada;
theta_rad = theta_deseada * pi/180; % Pasamos a radianes
fprintf('Queremos apuntar a %.1f grados\n', theta_real);

% Cálculo Ley Snell: sin(theta) = lambda/gamma
if theta_deseada == 0
    gamma = 10000;
else 
    gamma = lambda/sin(theta_rad);
end

N = gamma/D_celda; % Número de celdas que caben en esa longitud 

fprintf('Harían falta un total de %.2f celdas\n', N);


fprintf('----------------------------------------\n', N);
% No podemos partir una celda a la mitad así que como necesitamos mínimo 
% dos bits para hacer algo, implantaremos la siguiente condición:
N_bits = round(N); % Redondeamos al entero más cercano

if N_bits < 2
    N_bits = 2;
end

% Si el numero de celdas ha sido recalculado (porque haya salido decimal), 
% volvemos a recalcular Snell:

Gamma = N_bits * D_celda;
theta_final = asin(lambda/Gamma)*180/pi; % Por si saliese otro ángulo 
                                         % debido a la nueva gamma

theta_real = 90 - theta_final;
fprintf('Celdas reales usadas (Entero): %d\n', N_bits);
fprintf('--> Ángulo real resultante: %.1f grados\n', theta_real);

% Ahora viene el calculo de 1s y 0s de la secuencia
num_ceros = floor(N_bits / 2); % Para calcular un número de 0s y 1s lo más 
                               % simetrico posible ; floor hace que si es
                               % impar, redondee hacia abajo
num_unos = N_bits - num_ceros;

patron = [zeros(1, num_ceros), ones(1, num_unos)]; % Crea dicho patrón

fprintf('----------------------------------------\n', N);

fprintf('El patrón final será [%s]\n', num2str(patron(1:min(20, end))));

% Ahora lleno dicho patrón generado con un array grande (por ejemplo, 32
% elementos)

N_array = 20;
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

an = 1 - 2 * secuencia_final;
array_1d(an, 0, d, 1);