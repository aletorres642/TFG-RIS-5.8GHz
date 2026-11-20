clear all
close all
clc

% DATOS DE MEDICIÓN
load('Medicion_prototipo');
frequencias=frequencias/1e9;

% FRECUENCIAS A GRAFICAR
freqs=4:0.01:6;
num_freqs=length(freqs);

% CARPETA PARA GUARDAR IMAGENES
folder_name='Graficos_S21_prototipo';
if ~exist(folder_name,'dir')
    mkdir(folder_name);
end

% Tamaño de fuente maestro (igual que el otro script)
fs = 24;

for k = 1:num_freqs
    f_target=freqs(k);
    [~, idx_f]=min(abs(frequencias-f_target));
    S21_gain=zeros(1, length(ph_med));
    for i=1:length(ph_med)
        s21_complex=MatrixData{i}(:,1)+1j*MatrixData{i}(:,2);
        S21_gain(i)=20*log10(abs(s21_complex(idx_f)));
    end

    % --- Ventana grande y fondo blanco (mismo tamaño que el otro script) ---
    fig=figure('Name', sprintf('S21 Measurement - %.2f GHz', f_target), ...
               'NumberTitle', 'off', 'Color', 'w', ...
               'Position', [100, 100, 900, 1000]);

    % --- Una sola gráfica, sin eje derecho ---
    plot(ph_med, S21_gain, 'Color', 'b', 'LineWidth', 2);

    ax=gca;
    % Forzar TODO a negro (ejes, numeros, fondo)
    set(ax, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', ...
            'FontSize', fs, 'LineWidth', 1.5);

    xlabel('Ángulo (grados)', 'FontSize', fs + 2, 'FontWeight', 'bold', 'Color', 'k');
    ylabel('Ganancia S_{21} (dB)', 'FontSize', fs + 2, 'FontWeight', 'bold', 'Color', 'k');

    axis([-90 90 -40 5])
    xticks(-90:10:90)
    yticks(-40:5:5)
    grid on;

    % Guardar figura automáticamente
    filename=fullfile(folder_name,sprintf('S21_%.2fGHz.png', f_target));
    saveas(fig, filename);

    % Cierra la figura para no colapsar MATLAB
    close(fig);
end