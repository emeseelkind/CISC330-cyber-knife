function [maxMSE_u, maxMSE_v, plot_results] = q7_marker_reconstruction_error_simulation(maxMRE)
    M1CK = [30; -30; 0];
    M2CK = [-30; 0; 30];
    M3CK = [0; -30; 60];
    % Initialize arrays to store results for each axis
    MSE_values_u = [];
    REM_values_u = [];
    MRE_values_u = [];
    MSE_values_v = [];
    REM_values_v = [];
    MRE_values_v = [];
    MSE_incr = 0.1;
    % Initialize maxMSE trackers
    maxMSE_u = 0;
    maxMSE_v = 0;
    
    % Project the 3 ground truth markers (M1CK, M2CK M3CK) onto the two X-ray detectors
    % receive 3 pairs of corresponding marker image points (M1A, M1B), (M2A, M2B), (M2A, M2B).
    [M1A, M1B] = q2_xray_projection(M1CK);
    [M2A, M2B] = q2_xray_projection(M2CK);
    [M3A, M3B] = q2_xray_projection(M3CK);

    % We learned that MSE that occur along the detector’s u-axis and errors 
    % that occur along the v-axis tend to manifest very differently in the REM
    % computed by Q3. Alas, we must analyze them separately.
    for axis = {'u', 'v'}
        % Start the simulation with MSE=0, gradually increasing Err by 0.1 mm
        MSE = 0;
        
        while true
            % Store all marker pairs for current MSE
            marker_pairs = cell(12, 2);
            current_REM = zeros(12, 1);
            current_MRE = zeros(12, 1);
            
            j = 1;
            for i = 1:3
                % Select current marker points
                if i == 1
                    MA = M1A(1:3);
                    MB = M1B(1:3);
                    MCK = M1CK;
                elseif i == 2
                    MA = M2A(1:3);
                    MB = M2B(1:3);
                    MCK = M2CK;
                else
                    MA = M3A(1:3);
                    MB = M3B(1:3);
                    MCK = M3CK;
                end
                
                % Create error vectors based on current axis
                error_vector = zeros(3, 1);
                if strcmp(axis, 'u')
                    error_vector(1) = MSE;
                else
                    error_vector(2) = MSE;
                end
                
                % In each of the two images, spoil each marker image point
                % in the direction of just one detector coordinate axis (‘u’ or ‘v’) 
                % by adding a +/-MSE vector. 
                % (+,+)
                MA_plus = MA + error_vector;
                MB_plus = MB + error_vector;
                marker_pairs{j, 1} = MA_plus;
                marker_pairs{j, 2} = MB_plus;
                
                % (+,-)
                MA_plus = MA + error_vector;
                MB_minus = MB - error_vector;
                marker_pairs{j + 1, 1} = MA_plus;
                marker_pairs{j + 1, 2} = MB_minus;
                
                % (-,+)
                MA_minus = MA - error_vector;
                MB_plus = MB + error_vector;
                marker_pairs{j + 2, 1} = MA_minus;
                marker_pairs{j + 2, 2} = MB_plus;
                
                % (-,-)
                MA_minus = MA - error_vector;
                MB_minus = MB - error_vector;
                marker_pairs{j + 3, 1} = MA_minus;
                marker_pairs{j + 3, 2} = MB_minus;
                
                % Process all 4 pairs for current marker
                for i = 0:3
                    curr_j = j + i;
                    % Reconstruct point and get REM
                    projA_spoiled = marker_pairs{curr_j, 1};
                    projB_spoiled = marker_pairs{curr_j, 2};
                    % Feed these 12 pairs to the to Q3, to obtain 12 reconstructions and REM values. 
                    [reconstructed_marker, REM] = q3_marker_reconstruction(projA_spoiled, projB_spoiled);
                    
                    % Calculate MRE (Marker Reconstruction Error)
                    [Ma, Mb] = q2_xray_projection(MCK);
                    MA = Ma(1:3);
                    MB = Mb(1:3);
                    [reconstructed_marker2, REM2] = q3_marker_reconstruction(MA, MB);
                    
                    % For each of the 12 reconstructions, compute the MRE
                    % as the difference between corresponding reconstructed
                    % and ground truth marker positions, which yields 12 MRE values.
                    MRE = norm(reconstructed_marker - reconstructed_marker2);
                    
                    % Store all 12 corresponding (MSE, REM and MRE) triplets for future analysis
                    current_REM(curr_j) = REM;
                    current_MRE(curr_j) = MRE;
                end
                j = j + 4;
            end
            
            % Check if any MRE exceeds maxMRE
            if any(current_MRE > maxMRE)
                break;
            end
            
            if strcmp(axis, 'u')
                MSE_values_u = [MSE_values_u; repmat(MSE, 12, 1)];
                REM_values_u = [REM_values_u; current_REM];
                MRE_values_u = [MRE_values_u; current_MRE];
                maxMSE_u = MSE;  
            else
                MSE_values_v = [MSE_values_v; repmat(MSE, 12, 1)];
                REM_values_v = [REM_values_v; current_REM];
                MRE_values_v = [MRE_values_v; current_MRE];
                maxMSE_v = MSE; 
            end
            % Start the simulation with MSE=0, gradually increasing Err by 0.1 mm
            MSE = MSE + MSE_incr;
        end
    end
    
    plot_results = {MSE_values_u, MRE_values_u, maxMRE, MSE_values_v, MRE_values_v, REM_values_u, REM_values_v, maxMSE_u, maxMSE_v};
end

