% radiation_simulation_step1.m
% Step 1: Generate synthetic radiation sensor data

% Number of data points
N = 1000;

% Time axis (seconds)
t = linspace(0, 100, N);

% Base radiation level (mean counts per second)
base_level = 50;

% Simulate random fluctuations using Poisson noise
radiation_data = poissrnd(base_level, [1, N]);

% Add some spikes to simulate solar particle events
spike_indices = randi([200, 800], 1, 5); % random 5 spikes
radiation_data(spike_indices) = radiation_data(spike_indices) + randi([100, 200], 1, 5);

% Plot the synthetic radiation data
figure;
plot(t, radiation_data, 'b-', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Radiation Counts');
title('Synthetic Radiation Sensor Data');
grid on;

% Save the plot in ../plots/
if ~exist('../plots', 'dir')
    mkdir('../plots');
end
saveas(gcf, '../plots/radiation_data.png');

% Save raw data in ../data/
if ~exist('../data', 'dir')
    mkdir('../data');
end
save('../data/radiation_data.mat', 't', 'radiation_data');

