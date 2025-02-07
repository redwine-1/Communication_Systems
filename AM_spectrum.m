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
carrier = Ac .* sin(2 * pi * Fc .* t);
message = square(2*pi*Fm*t); % square wave message signal

% modulation
Am = max(message);
ka = 1/Am; %modulation sensitivity
mu = ka*Am; %modulation index
modulated = carrier .* (1 + ka.*message);
envelope = abs(hilbert(modulated));

N = length(t);
f = linspace(-Fs/2, Fs/2, N);

% Calculate the FFT of the signals
message_fft = abs(fftshift(fft(message)));
carrier_fft = abs(fftshift(fft(carrier)));
modulated_fft = abs(fftshift(fft(modulated)));


% plot time domain
figure;
subplot(3,1,1);
plot(t, message);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Message Signal (Frequency: ' num2str(Fm) 'Hz)']);
axis padded;
grid on;
subplot(3,1,2);
plot(t, carrier);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Carrier Signal (Frequency: ' num2str(Fc) 'Hz)']);
axis padded;
grid on;
subplot(3,1,3);
plot(t, modulated);
hold on;
plot(t, envelope, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Modulated Signal (Modulation Index: ' num2str(mu) ')']);
axis padded;
grid on;



% plot fft
figure;
plot(f, message_fft, 'b');
hold on;
plot(f, carrier_fft, 'g', linewidth=2);
plot(f, modulated_fft, 'r');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title(['Frequency domain analysis of AM signal (carrier Freq:' num2str(Fc) 'Hz, message Freq:' num2str(Fm) 'Hz)']);
legend('Message Signal','carrier Signal', 'Modulated Signal');
axis padded;
grid on;
xlim([-500 500]);




