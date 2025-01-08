%{
Hint: The marker image points are in detector image frame, but the reconstruction is done in CK
frame, alas you first need to transform the input to CK frame. And consult the lecture notes re X-ray
reconstruction
%}

% q2_xray_projection.m
% q3_marker_reconstruction.m

function test_q3
    %Simulated ground-truth vertebra model in CT imaging frame

    %Test the module on the same simple ground truth points you used for testing the X-ray projector.
    point_CK = [0; 0; 0];
    [CK_toA, CK_toB] = q2_xray_projection(point_CK);
    CK_toA = CK_toA(1:3);
    CK_toB = CK_toB(1:3);
    [reconstructed_point_CK, REM] = q3_marker_reconstruction (CK_toA, CK_toB);
    disp("Reconstructed point in CK frame ");
    disp(reconstructed_point_CK);
    disp("REM");
    disp(REM);

    % Test the module by projecting CCK, M1CK, M2CK, M3CK onto the detectors, reconstruct them, 
    % and show that your reconstructor produces perfect results, with a zero (or rather near-zero) residual error metric.
    
    % points_CK = [M1CK, M2CK, M3CK, TCCT];
    M1CK = [30; -30; 0];
    M2CK = [-30; 0; 30];
    M3CK = [0; -30; 60];
    TCCK = [0; 30; 30];
    disp('Test number 1 M1CK [30; -30; 0]: ');
    [CK_toA, CK_toB] = q2_xray_projection(M1CK);
    CK_toA = CK_toA(1:3);
    CK_toB = CK_toB(1:3);
    [reconstructed_point_CK, REM] = q3_marker_reconstruction (CK_toA, CK_toB);
    disp("Reconstructed point in CK frame ");
    disp(reconstructed_point_CK);
    disp("REM");
    disp(REM);

    disp('Test number 2 M2CK [-30; 0; 30]: ');
    [CK_toA, CK_toB] = q2_xray_projection(M2CK);
    CK_toA_3 = CK_toA(1:3);
    CK_toB_4 = CK_toB(1:3);
    [reconstructed_point_CK, REM] = q3_marker_reconstruction(CK_toA_3, CK_toB_4);
    disp("Reconstructed point in CK frame ");
    disp(reconstructed_point_CK);
    disp("REM");
    disp(REM);

    disp('Test number 3 M3CK [0; -30; 60]: ');
    [CK_toA, CK_toB] = q2_xray_projection(M3CK);
    CK_toA_5 = CK_toA(1:3);
    CK_toB_6 = CK_toB(1:3);
    [reconstructed_point_CK, REM] = q3_marker_reconstruction(CK_toA_5, CK_toB_6);
    disp("Reconstructed point in CK frame ");
    disp(reconstructed_point_CK);
    disp("REM");
    disp(REM);

end
