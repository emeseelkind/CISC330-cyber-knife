%{
Test: Run the registration module, compute the tumor target in CK frame, and run the registration
on ground truth M1CT M2CT M3CT points and demonstrate that your frame transform yields the ground
truth M1CK M2CK M3CK points
%}
function target_in_CK = test_q5
    disp('Compute the tumor target in CK frame on ground truth MCT points:');
    TCCT = [-30; 20; 20];
    M1CT = [0, -40, -10 ];
    M2CT = [-60, -10, 20];
    M3CT = [-30, -40, 50];
    MCT = [M1CT; M2CT; M3CT];

    M1CK = [30, -30, 0];
    M2CK = [-30, 0, 30];
    M3CK = [0, -30, 60];
    TCCK = [0, 30, 30];
    MCK = [M1CK; M2CK; M3CK];

    target_point_CK = q5_target_registration(TCCT, MCT, MCK);
    disp('Frame transform from MCT to MCK. TCCK:');
    disp(target_point_CK(1:3)');

    disp('TCCK: ');
    disp(TCCK);

    disp('Compute the inverse to validate:');
    TCCK = [0; 30; 30];
    target_point_CK = q5_target_registration(TCCK, MCK, MCT);
    disp('Frame transform from MCT to MCK. TCCK:');
    disp(target_point_CK(1:3)');
    disp('TCCT: ');
    disp(TCCT');

end