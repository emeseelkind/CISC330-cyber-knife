%{
Q3. Marker Reconstruction
• Task: Develop a module to reconstruct a point in CK frame from two detector 
image points. Also compute appropriate residual error metric (REM).
• Input: Point in A image frame, Point in B image frame.
• Output: Reconstructed point in CK frame and REM. Test the module on the same simple ground
truth points you used for testing the X-ray projector. Then test the module by projecting CCK, 
M1CK, M2CK, M3CK onto the detectors, reconstruct them, and show that your reconstructor 
produces perfect results, with a zero (or rather near-zero) residual error metric.
%}

function [reconstructed_point_CK, REM] = q3_marker_reconstruction (proj_A, proj_B)

    % first need to transform the input to CK frame.
    CK_toA = q1_frame_transforms_A();
    CK_toB = q1_frame_transforms_B();
    CK_toA = inv(CK_toA);
    CK_toB = inv(CK_toB);

    proj_A = CK_toA * [proj_A; 1];
    proj_B = CK_toB * [proj_B; 1];
    proj_A = proj_A(1:3);
    proj_B = proj_B(1:3);

    SAD = [0;100;0;1];

    % Find source 
    Source_a = rotation_about_coord_axis('z', 45, SAD);
    Source_b = rotation_about_coord_axis('z', -45, SAD);

    % v = (source - proj_A )/ |source - proj_A|
    vec_a = (Source_a - proj_A )/ norm(Source_a - proj_A);
    vec_b = (Source_b - proj_B )/ norm(Source_b - proj_B);

    % Intersecting lines
    vec_c = normalize (cross(vec_a, vec_b));
    
    matrix_vecs = [-vec_a(1) vec_b(1) vec_c(1); -vec_a(2) vec_b(2) vec_c(2); -vec_a(3) vec_b(3) vec_c(3)];
    inv_matrix_vecs = inv(matrix_vecs);
    matrix_points = [ Source_a(1)-Source_b(1) ; Source_a(2)-Source_b(2) ; Source_a(3)-Source_b(3)];
    t = inv_matrix_vecs * matrix_points;

    % Determining the t of the Line equation L = P + t*v
    L1 = Source_a + t(1)* vec_a;
    L2 = Source_b + t(2)* vec_b;

    % Determine symbolic intersection of lines in 3D
    reconstructed_point_CK = (L1+L2)/2;
    
    % Calculate Residual Error Metric (REM)
    REM = t(3)/2;
    REM = abs(REM);
   
end
% From assignment 1
function homogeneous_transformation_matrix = rotation_about_coord_axis(axis, angle, point)
    if axis == 'x'
        homogeneous_transformation_matrix = [1, 0, 0, 0; 0, cosd(angle), -sind(angle), 0; 0, sind(angle), cosd(angle), 0; 0, 0, 0, 1];
    elseif axis == 'y'
        homogeneous_transformation_matrix = [cosd(angle), 0, sind(angle), 0; 0, 1, 0, 0; -sind(angle), 0, cosd(angle), 0; 0, 0, 0, 1];
    elseif axis == 'z'
        homogeneous_transformation_matrix = [cosd(angle), -sind(angle), 0, 0; sind(angle), cosd(angle), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
    else
        error('Invalid axis. Choose x, y, or z.');
    end
    homogeneous_transformation_matrix = homogeneous_transformation_matrix * point;
    homogeneous_transformation_matrix = homogeneous_transformation_matrix(1:3);
end

function CK_toA = q1_frame_transforms_A
    SAD = 100; 
    %find x and y
    x =  SAD * (sqrt(2)/2);
    y =  SAD * (sqrt(2)/2);

    % no translation in z direction
    T = inv([1 0 0 -(x);0 1 0 -(-y);0 0 1 -(0);0 0 0 1]);
    R = [cosd(45) -sind(45) 0 0; sind(45) cosd(45) 0 0; 0 0 1 0; 0 0 0 1];
    CK_toA = inv(T*R);
end

function CK_toB = q1_frame_transforms_B
    SAD = 100;
    %find x and y
    x =  SAD * (sqrt(2)/2);
    y =  SAD * (sqrt(2)/2);

    % no translation in z direction
    T = inv([1 0 0 -(-x);0 1 0 -(-y);0 0 1 -(0);0 0 0 1]);
    R = [cosd(-45) -sind(-45) 0 0; sind(-45) cosd(-45) 0 0; 0 0 1 0; 0 0 0 1];
    CK_toB = inv(T*R);
end