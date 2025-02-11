clc
clear global;
close all;

%Frequencies
Fs = 2000; % sampling
Fc = 200; % carrier
Fm = 2; % message

%Amplitudes
Ac = 2; %carrier
Am = 1; %message

duration = 2;
t =0:1/Fs:duration;

%signal
carrier = Ac .* sin(2 * pi * Fc .* t);
message = Am * sin(2*pi*Fm*t); % square wave message signal

% modulation
modulated = carrier .*message;
envelope = abs(hilbert(modulated));

%coherent demodulation
phi = pi/2;
demodulated = Ac .* sin(2 * pi * Fc .* t + phi) .* modulated;
[b,a] = butter(6, 50/(Fs/2));
demodulated = filter(b,a,demodulated);




N = length(t);
f = linspace(-Fs/2, Fs/2, N);

% Calculate the FFT of the signals
message_fft = abs(fftshift(fft(message)));
carrier_fft = abs(fftshift(fft(carrier)));
modulated_fft = abs(fftshift(fft(modulated)));




% plot time domain
figure;

uicontrol('Style', 'text', 'Position', [300 20 120 20], 'String', 'Phi');
phi_slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 2*pi, 'Value', phi, 'Position', [300 40 200 20]);

rwo = 4;
col = 1;
subplot(rwo,col,1);
plot(t, message);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Message Signal (Frequency: ' num2str(Fm) 'Hz)']);
axis padded;
grid on;
subplot(rwo,col,2);
plot(t, carrier);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Carrier Signal (Frequency: ' num2str(Fc) 'Hz)']);
axis padded;
grid on;
subplot(rwo,col,3);
plot(t, modulated);
hold on;
plot(t, envelope, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Modulated Signal']);
axis padded;
grid on;

subplot(rwo,col,4);
h1 = plot(t, demodulated);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Demodulated Signal using Coherent Detection (phi: ' num2str(rad2deg(phi)) ' degree)']);
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


while ishandle(h1)
    phi = get(phi_slider, 'Value');
    demodulated = Ac .* sin(2 * pi * Fc .* t + phi) .* modulated;
    demodulated = filter(b,a,demodulated);
    set(h1, 'YData', demodulated);
    title(h1.Parent, ['Demodulated Signal using Coherent Detection (phi: ' num2str(rad2deg(phi)) 'degree )']);
    drawnow;
end


