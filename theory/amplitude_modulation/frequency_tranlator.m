% Frequency domain analysis of AM signal
% this code compares the frequency domain of the message signal, carrier signal, modulated signal

clc
clear global;
close all;

%Frequencies
Fs = 2000; % sampling
Fc = 300; % carrier
Fm = 5; % message

%Amplitudes
Ac = 2; %carrier

duration = 2;
t =0:1/Fs:duration;

%signal
carrier = Ac .* cos(2 * pi * Fc .* t);
% message = square(2*pi*Fm*t); % square wave message signal
message = cos(2*pi*Fm*t); % cos wave message signal

% modulation
Am = max(message);
ka = 1/Am; %modulation sensitivity
mu = ka*Am; %modulation index
dsb_sc = carrier .*message;
N = length(t);
f = linspace(-Fs/2, Fs/2, N);

f_2 = 400;
f_3 = 200;
% up conversion
dsb_sc_up = dsb_sc .* sin(2 * pi * (f_2 - Fc) * t);

% Calculate the FFT of the signals
modulated_fft = abs(fftshift(fft(dsb_sc)));
modulated_fft_up = abs(fftshift(fft(dsb_sc_up)));


% plot fft
figure;
subplot(2,1,1);
plot(f, modulated_fft, 'r');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('FFT of Modulated Signal');
axis padded;
grid on;
xlim([-500 500]);
subplot(2,1,2);
plot(f, modulated_fft_up, 'b');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('FFT of Frequency Translated Signal');
axis padded;
grid on;
xlim([-500 500]);







