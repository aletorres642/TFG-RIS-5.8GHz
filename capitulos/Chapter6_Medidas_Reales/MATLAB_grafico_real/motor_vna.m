instrreset;
close all;
clear all;
clc;

% CONFIGURACION VNA
PNA = visa('agilent','TCPIP::158.109.66.106::INSTR');   % PNA X instrument
PNA.InputBufferSize = 8388608;  
PNA.ByteOrder = 'littleEndian';
fopen(PNA);

% Leer vector de frecuencias configurado en el VNA
fprintf(PNA,'FORM:DATA ASCII'); % asegura formato ASCII
freq_str = query(PNA,'SENS:FREQ:DATA?');
frequencias = str2num(freq_str); % vector de frecuencias reales en Hz

% CONFIGURACION MOTOR
motor = 1; %axis 1 = azimuth, axis 2 = roll, axis 3 = polar
speed = 40; % velocidad %
dir = 'SHO';

t = tcpip('158.109.74.12',4444);
fopen(t)
fprintf(t,'@REM\n'); %control remoto
fscanf(t)
fprintf(t,'MOVE:POSI:AXIS %s\n',num2str(motor))
fprintf(t,'MOVE:POSI:SPEE %s\n',num2str(speed))
fprintf(t,'MOVE:POSI:DIRE %s\n',dir)

% PARAMETROS DE ESCANEO
ph_med = [-90:1:90]; % posiciones de medicion
n_pos = length(ph_med);
MatrixData = cell(n_pos,1);

tic
for cont2 = 1:n_pos
    fprintf('Posicion objetivo: %d grados\n',ph_med(cont2))
    fprintf(t,'MOVE:POSI:TO %d\n',ph_med(cont2)); % nueva posicion
    fprintf(t,'MOVE:POSI:STAR\n'); % empieza movimiento
    pause(.5);
    fscanf(t);
    pause(.5);
    fprintf(t,'CONF:AXIS3:POSI?\n');% pregunta donde esta
    pause(5); % tiempo muestreo

    % PNA ACQUISITION 
    fprintf(PNA,'*CLS'); % limpia errores previos
    fprintf(PNA,'FORM:BORD SWAP'); % orden de bytes
    fprintf(PNA,'FORM:DATA ASCII'); % formato ASCII
    fprintf(PNA,'CALC:PAR1:DEF S12'); % define el parámetro S21
    DataVector = query(PNA,'CALC:DATA:SDAT?'); % lectura sincronizada
    x = str2num(DataVector); %convierte a números

    NumberPoints = length(x)/2; % cada punto tiene parte real e imaginaria
    MatrixTEMP = reshape(x,2,NumberPoints)'; % columnas: [Re  Im]
    MatrixData{cont2} = MatrixTEMP;


end
toc

% GUARDAR TODO
Device = 'Medicion_prototipo';
save(Device,'ph_med','frequencias','MatrixData');
fprintf(t,'@LOC\n'); %control remoto a local
fclose(t)
fclose(PNA)
instrreset;

