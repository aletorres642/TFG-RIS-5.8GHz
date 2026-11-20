% Crear un vídeo MP4 a partir de las imágenes
carpeta = 'Graficos_S21_prototipo';
video = VideoWriter('Evolucion_Lobulo_RIS.mp4', 'MPEG-4');
video.FrameRate = 15; % Velocidad: 15 fotos por segundo
open(video);

for f = 4:0.01:6
    nombre_archivo = fullfile(carpeta, sprintf('S21_%.2fGHz.png', f));
    if exist(nombre_archivo, 'file')
        imagen = imread(nombre_archivo);
        writeVideo(video, imagen);
    end
end

close(video);
disp('¡Vídeo completado con éxito!');