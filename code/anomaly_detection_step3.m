% anomaly_detection_step3.m
% Step 3: Detect anomalies in transmitted radiation data

pkg load statistics   % ensure statistics package is loaded

% Load transmitted data
load('../data/transmission_data.mat');  % loads t, noisy_data, delayed_data

% --- Step 1: Calculate statistics on delayed data ---
baseline_data = delayed_data(21:200);

mu = mean(baseline_data);
sigma = std(baseline_data);

threshold = mu + 3*sigma;

% --- Step 2: Detect anomalies (values > mean + 3*std) ---
threshold = mu + 3*sigma;
anomaly_indices = find(delayed_data > threshold);
anomaly_values  = delayed_data(anomaly_indices);

fprintf('Detected %d anomalies\n', length(anomaly_indices));

% --- Step 3: Plot delayed data with anomalies highlighted ---
figure;
plot(t, delayed_data, 'g-', 'LineWidth', 1.2); hold on;
plot(t(anomaly_indices), anomaly_values, 'ro', 'MarkerSize', 6, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Radiation Counts');
title('Delayed Radiation Data with Detected Anomalies');
legend('Delayed Data', 'Detected Anomalies');
grid on;

% Save the plot
if ~exist('../plots', 'dir')
    mkdir('../plots');
end
saveas(gcf, '../plots/delayed_data_anomalies.png');

% Save anomaly data
if ~exist('../data', 'dir')
    mkdir('../data');
end
save('../data/anomalies_detected.mat', 'anomaly_indices', 'anomaly_values');

