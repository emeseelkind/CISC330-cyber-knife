%{
• Input: As you see best
• Output: maxMLE
%}

function maxMLE = q6_target_registration_error_simulation()
    % The allotted maximum target registration error (maxTRE) for this clinical procedure is 2.0 mm
    maxTRE = 2.0; %mm
    
    % Simulate the marker localization error by adding an error of random direction and of a fixed magnitude. 
    % Start with zero error (MLE=0) and gradually increase the magnitude by 0.1 mm 
    init_MLE = 0.0;
    inc_MLE = 0.1; %mm
    n = 1000;

    %marker_localiz_err_vec = random_direction /norm(random_direction);
    M1CK = [30, -30, 0];
    M2CK = [-30, 0, 30];
    M3CK = [0, -30, 60];
    MCK = [M1CK; M2CK; M3CK];

    M1CT = [0, -40, -10];
    M2CT = [-60, -10, 20];
    M3CT = [-30, -40, 50];
    MCT = [M1CT; M2CT; M3CT];
    TCCT = [-30; 20; 20];
    TCCK = [0, 30, 30];
    
    % results storage
    results = [];

    % Start with zero error, increase the magnitude by 0.1 mm and stop when
    %TRE starts exceeding the maxTRE clinical limit
    for MLE = init_MLE : inc_MLE : maxTRE
        TRE_vec = zeros(1, n);  
        
        for i = 1: n
            % Simulate the marker localization error by adding an error of random direction and of a fixed magnitude.
            M1CK_err = M1CK + MLE * randn(1, 3);
            M2CK_err = M2CK + MLE * randn(1, 3);
            M3CK_err = M3CK + MLE * randn(1, 3);
            MCK_err = [M1CK_err; M2CK_err; M3CK_err];
            
            target_point_CK = q5_target_registration(TCCT, MCT, MCK_err);
            % we assume that the tumor and the markers in CT frame were perfectly localized with zero error
            TCCK_q5 = q5_target_registration(TCCT, MCT, MCK);
            TRE = norm(target_point_CK - TCCK_q5);  % Compare with ground truth
            
            TRE_vec(i) = TRE;  % Store TRE for this simulation
        end
        
        meanTRE = mean(TRE_vec);
        
        % Store results (MLE, mean TRE, and whether clinical requirement is met)
        results = [results; MLE, meanTRE];
        fprintf('MLE: %.2f mm, Mean TRE: %.2f mm\n', MLE, meanTRE);
        
        % The simulation cycle will break after exceeding the allowable maxMLE
        if meanTRE > maxTRE
            fprintf('TRE exceeds %.1f mm for MLE = %.2f mm\n', maxTRE, MLE);
            break;
        end
        MLE = MLE + inc_MLE;
    end
    maxMLE = MLE;
end