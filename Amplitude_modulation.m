clc
clear global;
close all;

%Frequencies
Fs = 4000; % sampling
Fc = 100; % carrier
Fm = 5; % message

%Amplitudes
Ac = 2; %carrier
Am = 3; %message

duration = 1;
t =0:1/Fs:duration;
ka = 1/3.5; %modulation intensity

%signal
carrier = Ac .* sin(2 * pi * Fc .* t);
message = Am .* sin(2 * pi * Fm .* t);
modulated = carrier .* (1 + ka.*message);
envelope = abs(hilbert(modulated));

% Create figure
figure;

% Create sliders at the bottom of the graph
uicontrol('Style', 'text', 'Position', [50 20 120 20], 'String', 'Carrier Frequency');
Fc_slider = uicontrol('Style', 'slider', 'Min', 50, 'Max', 200, 'Value', Fc, 'Position', [50 40 200 20]);

uicontrol('Style', 'text', 'Position', [300 20 120 20], 'String', 'Message Frequency');
Fm_slider = uicontrol('Style', 'slider', 'Min', 1, 'Max', 10, 'Value', Fm, 'Position', [300 40 200 20]);

uicontrol('Style', 'text', 'Position', [550 20 120 20], 'String', 'Modulation Sensitivity');
ka_slider = uicontrol('Style', 'slider', 'Min', 0.1, 'Max', 1, 'Value', ka, 'Position', [550 40 200 20]);


subplot(3,1,1);
h1 = plot(t, message);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Message Signal Frequency: ' num2str(Fm) 'Hz']);
axis padded;
grid on;


subplot(3,1,2);
h2 = plot(t, carrier);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Carrier Signal Frequency: ' num2str(Fc) 'Hz']);
axis padded;
grid on;

subplot(3,1,3);
h3 = plot(t, modulated);
hold on;
h4 = plot(t, envelope, 'r', 'LineWidth', 2); % Add handle for envelope plot
xlabel('Time (s)');
ylabel('Amplitude');
title(['Modulated Signal Sensitivity: ' num2str(ka)]);
axis padded;
grid on;

% Update plot in real-time
while ishandle(h1)
    Fc = get(Fc_slider, 'Value');
    Fm = get(Fm_slider, 'Value');
    ka = get(ka_slider, 'Value');
    
    message = Am .* sin(2 * pi * Fm .* t);
    carrier = Ac .* sin(2 * pi * Fc .* t);
    modulated = carrier .* (1 + ka.*message);
    envelope = abs(hilbert(modulated));
    set(h1, 'YData', message);
    set(h2, 'YData', carrier);
    set(h3, 'YData', modulated);
    set(h4, 'YData', envelope); % Update envelope plot
    
    % Update titles
    title(h1.Parent, ['Message Signal Frequency: ' num2str(Fm) 'Hz']);
    title(h2.Parent, ['Carrier Signal Frequency: ' num2str(Fc) 'Hz']);
    title(h3.Parent, ['Modulated Signal Sensitivity: ' num2str(ka)]);
    
    drawnow;
end