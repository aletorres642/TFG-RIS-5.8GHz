% [th,FA,D]=array1d(an,alfa,d,sw,freq)
% Dada una agrupacion de elementos isotropicos representa:
%   *el diagrama de radiacion en el espacio electrico y el margen visible
%   *el diagrama de radiacion en el espacio real (normal de la placa en 0 grados)
%
% Input:
%   an: coeficientes de alimentacion (1xN)
%   alfa: desfase progresivo en radianes (1x1)
%   d: separacion entre elementos en lambdas (1x1)
%   sw: si es 0 no representa los diagramas, solo hace los calculos (1x1)
%   freq: (Opcional) Frecuencia en GHz para mostrar en el titulo (1x1)
%
% Output
%   th: angulo radianes para los que se calcula el factor de agrupacion
%   FA: modulo del factor de agrupacion en espacio real
%   D: directividad de la agrupacion, escala lineal
function [th,FA,D]=array1d(an,alfa,d,sw,freq)

% Verificando si se ha introducido la frecuencia
if nargin < 5
    freq = [];
end

%Verificando las entradas
[M,N]=size(an);
if (M~=1) || (N<1), error('an debe ser un vector fila'); end
aux=size(alfa);
if (aux~=1), error('alfa tener dimensiones 1x1');end
aux=size(d);
if (aux~=1), error('d tener dimensiones 1x1');end
if (d<0), error('d tiene que ser mayor que cero');end
aux=size(sw);
if (aux~=1), error('sw tener dimensiones 1x1');end

%Angulo electrico
dpsi = pi/1000;
len = 2*pi*(1+2*d);
n_ptos = len/dpsi;
psi_el=linspace(-pi-2*pi*d+alfa,+pi+2*pi*d+alfa,n_ptos);

%Diagrama de radiacion en el espacio electrico
FA_el=abs(freqz(an,1,psi_el));

%Angulo real
th=linspace(0,pi,2*360+1);
%psi=k*d*cos(th)+alfa
psi_re=2*pi*d*cos(th)+alfa;

%Diagrama de radiacion en el espacio real
FA=abs(freqz(an,1,psi_re));

%Calculo directividad
r=find((psi_el > min(psi_re)) & (psi_el < max(psi_re)));
D=4*pi*d*abs(max(FA_el(r)).^2)/dpsi/sum(abs(FA_el(r)).^2);

if sw
% --- FORMATO ESTÉTICO TAMAÑO XL ---
    % Tamaño de fuente maestro (Cambia este número para escalar TODO de golpe)
    fs = 24; 

    % Hacemos la ventana mucho más grande [X, Y, Ancho, Alto]
    figure('Color', 'w', 'Position', [100, 100, 900, 1000]); 

% 1. REPRESENTAR EL DIAGRAMA EN EL ESPACIO ELECTRICO
    ax1 = subplot(2,1,1);
    plot(psi_el,FA_el, 'LineWidth', 2);
    hold on;
    plot(psi_re,FA,'r', 'LineWidth', 3); % Margen visible más grueso
    hold off
    grid on;

% Forzar ejes, numeros y fondo
    set(ax1, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', fs, 'LineWidth', 1.5);
    axis([-pi-2*pi*d+alfa +pi+2*pi*d+alfa 0 max(FA_el)]);
    
    % Le metemos unos espacios en blanco al final para forzar a que la caja sea más ancha
    lgd = legend('Espacio eléctrico', 'Margen visible (Real)     ', 'Location', 'best');
    set(lgd, 'FontSize', fs - 6, 'TextColor', 'k', 'Color', 'w', 'EdgeColor', 'k'); 
    
    xlabel('\psi (Radianes)', 'FontSize', fs + 2, 'FontWeight', 'bold', 'Color', 'k');
    ylabel('|FA(\psi)|', 'FontSize', fs + 2, 'FontWeight', 'bold', 'Color', 'k');
    
    if isempty(freq)
        title_str = sprintf('max(FA) = %.2f, max(FA) en MV = %.2f', max(FA_el), max(FA));
    else
        title_str = sprintf('Frecuencia: %.2f GHz | max(FA) = %.2f, MV = %.2f', freq, max(FA_el), max(FA));
    end
    title(title_str, 'FontSize', fs - 4, 'Color', 'k'); 

    % EMPUJAMOS LA GRÁFICA DE ARRIBA HACIA EL TECHO
    pos1 = get(ax1, 'Position');
    pos1(2) = pos1(2) + 0.05; 
    set(ax1, 'Position', pos1);

% 2. REPRESENTAR EL DIAGRAMA REAL (SEMICIRCULO POLAR)
    th_grados   = th*180/pi;          
    theta_n     = 90 - th_grados;     
    FA_norm     = FA/max(FA);         
    
    subplot(2,1,2);
    h_polar = polarplot(deg2rad(theta_n), FA_norm);
    
    ax2 = gca; 
    set(h_polar, 'LineWidth', 3, 'Color', 'b'); 
    
% Orientacion estilo FEKO
    ax2.ThetaZeroLocation = 'top';    
    ax2.ThetaDir          = 'clockwise';
    thetalim(ax2, [-90 90]);          
    ax2.ThetaTick = -90:30:90;        

% Forzar fondo interior y textos
    set(ax2, 'Color', 'w', 'ThetaColor', 'k', 'RColor', 'k', 'FontSize', fs - 2, 'FontWeight', 'bold');
    set(ax2, 'GridColor', 'k', 'GridAlpha', 0.5);
    title(sprintf('Directividad = %.1f (%.1f dB)',D,10*log10(D)), 'FontSize', fs, 'FontWeight', 'bold', 'Color', 'k');

% 3. REDIMENSIONADO Y SEPARACIÓN DEL SEMICÍRCULO
    pos2 = get(ax2, 'Position');
    pos2(1) = pos2(1) - 0.08; 
    pos2(3) = pos2(3) + 0.16; 
    pos2(4) = pos2(4) + 0.08; 
    pos2(2) = pos2(2) - 0.08; 
    set(ax2, 'Position', pos2);
end

%Ejemplo de QUE poner en la consola de matlab (añadiendo la frecuencia al final):
%[th,FA,D] = array1d(repmat([ones(1,4), -ones(1,4)], 1, 4), 0, 0.166, 1, 5.8);