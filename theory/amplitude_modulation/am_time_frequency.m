clc
clear global;
close all;

% Frequencies
Fs = 1000; % sampling
Fc = 100; % carrier
Fm = 5; % message

% Amplitudes
Ac = 2; % carrier
Am = 3; % message

duration = 1;
t = 0:1/Fs:duration;
f = linspace(-Fs/2, Fs/2, length(t));
ka = 1/Am; % modulation sensitivity
mu = ka*Am; % modulation index

% Signal
carrier = Ac .* sin(2 * pi * Fc .* t);
message = Am .* sin(2 * pi * Fm .* t);
modulated = carrier .* (1 + ka.*message);
envelope = abs(hilbert(modulated));
fft_result = abs(fftshift(fft(modulated)));

% Create figure
figure;
rwo = 4;
col = 1;

% Create slider at the bottom of the graph
uicontrol('Style', 'text', 'Position', [550 20 120 20], 'String', 'Modulation Index');
modulation_index_slider = uicontrol('Style', 'slider', 'Min', 0.1, 'Max', 2.5, 'Value', mu, 'Position', [550 40 200 20]);

subplot(rwo, col, 1);
h1 = plot(t, message);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Message Signal (Frequency: ' num2str(Fm) 'Hz)']);
axis padded;
grid on;

subplot(rwo, col, 2);
h2 = plot(t, carrier);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Carrier Signal (Frequency: ' num2str(Fc) 'Hz)']);
axis padded;
grid on;

subplot(rwo, col, 3);
h3 = plot(t, modulated);
hold on;
h4 = plot(t, envelope, 'r', 'LineWidth', 2); % Add handle for envelope plot
xlabel('Time (s)');
ylabel('Amplitude');
title(['Modulated Signal (Modulation Index: ' num2str(mu*100) '%)']);
axis padded;
grid on;

subplot(rwo, col, 4);
h5 = plot(f, fft_result);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title(['Modulated Signal Spectrum (Modulation Index: ' num2str(mu*100) '%)']);
axis padded;
grid on;

% Update plot in real-time
while ishandle(h1)
    mu = get(modulation_index_slider, 'Value');
    ka = mu/Am;
    
    modulated = carrier .* (1 + ka.*message);
    envelope = abs(hilbert(modulated));
    fft_result = abs(fftshift(fft(modulated)));
    
    % Update plots
    set(h3, 'YData', modulated);
    set(h4, 'YData', envelope);
    set(h5, 'YData', fft_result);
    
    % Update titles
    title(h3.Parent, ['Modulated Signal (Modulation Index: ' num2str(mu*100) '%)']);
    title(h5.Parent, ['Modulated Signal Spectrum (Modulation Index: ' num2str(mu*100) '%)']);
    
    drawnow;
end