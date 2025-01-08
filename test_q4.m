%{
Test: Project the M1CK, M2CK, M3C onto two the X-ray detectors – you have already done this. (1) Feed
the resulting image points to your module and show that you resolve their correct correspondences.
(2) Swap M1 and M2 in image A, feed the points to your module and show that you can resolve
correct correspondences. Run the above for a slightly different set of marker screws: M1CK =
[30, -30, 0], M2CK = [-30, 0, 0], M3CK = [0, -30, 60]. Report and explain your findings
%}
function test_q4
    disp('Project the M1CK, M2CK, M3C onto two the X-ray detectors: ');
    M1CK = [30; -30; 0 ];
    M2CK = [-30; 0; 30];
    M3CK = [0; -30; 60];
    
    disp('without switching m1 and m2:');
    [M1_A, M1_B] = q2_xray_projection(M1CK);
    [M2_A, M2_B] = q2_xray_projection(M2CK);
    [M3_A, M3_B] = q2_xray_projection(M3CK);
    A = [M1_A(1:3), M2_A(1:3), M3_A(1:3)];
    B = [M1_B(1:3), M2_B(1:3), M3_B(1:3)];
    [correspondence_matrix] = q4_marker_correspondences(A, B);
    disp(correspondence_matrix);

    disp('with Swap of m1 and m2 in image A:');
    [M1_A, M1_B] = q2_xray_projection(M1CK);
    [M2_A, M2_B] = q2_xray_projection(M2CK);
    [M3_A, M3_B] = q2_xray_projection(M3CK);
    A = [M2_A(1:3), M1_A(1:3), M3_A(1:3)];
    B = [M1_B(1:3), M2_B(1:3), M3_B(1:3)];
    [correspondence_matrix] = q4_marker_correspondences(A, B);
    disp(correspondence_matrix);

    disp('Run for a slightly different set of marker screws: ');
    disp('M1CK=[30, -30, 0], M2CK=[-30, 0, 0], M3CK=[0, -30, 60]:');
    M1CK = [30; -30; 0];
    M2CK = [-30; 0; 0];
    M3CK = [0; -30; 60];
    [M1_A, M1_B] = q2_xray_projection(M1CK);
    [M2_A, M2_B] = q2_xray_projection(M2CK);
    [M3_A, M3_B] = q2_xray_projection(M3CK);
    A = [M2_A(1:3), M1_A(1:3), M3_A(1:3)];
    B = [M1_B(1:3), M2_B(1:3), M3_B(1:3)];
    [correspondence_matrix] = q4_marker_correspondences(A, B);
    disp(correspondence_matrix);

end