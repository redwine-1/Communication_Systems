% Power distribution in amplitude modulation

modulation_index = linspace(0, 1, 100);  % Normalized modulation index (0 to 1)
A_c = 1;  % Carrier amplitude
percentage_modulation = modulation_index * 100;  % Convert to percentage
sideband_power = ((modulation_index.^2) / 4) * 100;
carrier_power = 100 - sideband_power;

figure;
plot(percentage_modulation, carrier_power, 'DisplayName', 'Carrier');
hold on;
plot(percentage_modulation, sideband_power, 'DisplayName', 'Sidebands');
hold off;

grid on;
xlabel('Percentage modulation');
ylabel('Percentage of total transmitted power');
legend;
title('Amplitude Modulation Power Distribution');
