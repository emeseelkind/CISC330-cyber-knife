

function [] = test_q7()
    maxMRE = q6_target_registration_error_simulation();
    [maxMSE_u, maxMSE_v, plot_results] = q7_marker_reconstruction_error_simulation(maxMRE);
    
    plot_results_test(plot_results);

end


function [] = plot_results_test(plot_results)
    % Plot for MSE vs. MRE for u-axis
    figure;
    subplot(2, 2, 1);
    scatter(plot_results{1}, plot_results{2}, 4, 'b', 'filled');
    xlabel('Mean Squared Error');
    ylabel('Marker Reconstruction Error');
    title('MRE as a Function of MSE (u axis)');
    grid on;
    yline(plot_results{3}, '--r', 'Max Allowed MRE');
    legend('Data Points', 'Max Allowed MRE');
    
    % Plot for MSE vs. MRE for v-axis
    subplot(2, 2, 2);
    scatter(plot_results{4}, plot_results{5}, 4,'red', 'filled');
    xlabel('Mean Squared Error');
    ylabel('Marker Reconstruction Error');
    title('MRE as a Function of MSE (v axis)');
    grid on;
    yline(plot_results{3}, '--r', 'Max Allowed MRE');
    legend('Data Points', 'Max Allowed MRE');
    
    % Additional Plot: MRE vs REM for u-axis
    subplot(2, 2, 3);
    scatter(plot_results{6}, plot_results{2}, 4,'b', 'filled');
    xlabel('Reconstruction Error Metric');
    ylabel('Marker Reconstruction Error');
    title('MRE as a Function of REM (u axis)');
    grid on;
    yline(plot_results{3}, '--r', 'Max Allowed MRE');
    legend('Data Points', 'Max Allowed MRE');
    
    % Additional Plot: MRE vs REM for v-axis
    subplot(2, 2, 4);
    scatter(plot_results{7}, plot_results{5}, 4,'red', 'filled');
    xlabel('Reconstruction Error Metric');
    ylabel('Marker Reconstruction Error');
    title('MRE as a Function of REM (v axis)');
    grid on;
    yline(plot_results{3}, '--r', 'Max Allowed MRE');
    legend('Data Points', 'Max Allowed MRE');
    
    % Display the largest MSE values for each axis
    disp(['Largest MSE for u-axis within maxMRE: ', num2str(plot_results{8})]);
    disp(['Largest MSE for v-axis within maxMRE: ', num2str(plot_results{9})]);
end
