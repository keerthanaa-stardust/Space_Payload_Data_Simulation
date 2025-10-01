% transmission_simulation_step2.m
% Step 2: Simulate transmission noise and delay

pkg load statistics   % for random distributions

% Load the radiation data from Step 1
load('../data/radiation_data.mat');  % loads t and radiation_data

% --- Add Gaussian noise (like random interference) ---
noise_level = 5;  % standard deviation of noise
noisy_data = radiation_data + randn(size(radiation_data)) * noise_level;

% --- Add transmission delay ---
delay_samples = 20;  % delay of 20 samples (~2 seconds if N=1000 over 100s)
delayed_data = [zeros(1, delay_samples), noisy_data(1:end-delay_samples)];

% --- Plot comparison ---
figure;
plot(t, radiation_data, 'b-', 'LineWidth', 1.2); hold on;
plot(t, noisy_data, 'r--', 'LineWidth', 1.0);
plot(t, delayed_data, 'g-', 'LineWidth', 1.0);
xlabel('Time (s)');
ylabel('Radiation Counts');
title('Radiation Data: Original vs Noisy vs Delayed');
legend('Original', 'Noisy', 'Noisy + Delayed');
grid on;

% Save the plot in ../plots/
saveas(gcf, '../plots/radiation_transmission.png');

% Save processed data in ../data/
save('../data/transmission_data.mat', 't', 'noisy_data', 'delayed_data');

