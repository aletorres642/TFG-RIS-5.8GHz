clear all
%close all
clc

RIS = load('Medicion_prototipo_jp.mat');
RIS_ref = load('Medicion_prototipo_ref_jp.mat');
RIS.frequencias=RIS.frequencias/1e9;
s21_RIS_ref=RIS_ref.MatrixData(:,1)+1j*RIS_ref.MatrixData(:,2);
s21_RIS=RIS.MatrixData(:,1)+1j*RIS.MatrixData(:,2);

%{
aux=fft(s21_RIS_ref);aux(1:150)=0;aux(191:201)=0;s21_RIS_ref_n=ifft(aux);
S21_RIS_dB_ref=20*log10(abs(s21_RIS_ref_n));
aux=fft(s21_RIS);aux(1:150)=0;aux(191:201)=0;s21_RIS_n=ifft(aux);
S21_RIS_dB=20*log10(abs(s21_RIS_n));
medida_RIS_normal=s21_RIS_n./s21_RIS_ref_n;
%}

%%{
med_norm=s21_RIS./s21_RIS_ref;
fft_med=fft(med_norm);
fft_med(23:178)=0;
med_norm_n=ifft(fft_med);
medida_RIS_normal=med_norm_n;
%}


figure(1)
plot(RIS.frequencias, 20*log10(abs(medida_RIS_normal)), 'LineWidth',1.5);
grid on;
xlabel('Frecuencia (GHz)');
ylabel('(dB)');

axis([4 6 -50 0]);

figure(2)
plot(RIS.frequencias,rad2deg(mod(unwrap(angle(medida_RIS_normal)+pi),2*pi)-pi), 'LineWidth',1.5);
grid on
xlabel('Frecuencia (GHz)')
ylabel('Fase (º)')
axis([4 6 -180 180]);yticks([-180 -135 -90 -45 0 45 90 135 180])



freq=RIS.frequencias.';
writematrix([freq abs(medida_RIS_normal) angle(medida_RIS_normal)],'medida_RIS_normal.txt');