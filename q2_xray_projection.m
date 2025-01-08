%{
Task: To test the X-ray reconstruction software that you will develop, you first need to develop a
digital X-ray projector to create ground-truth X-ray images. It will be sufficient to project a point in CK
space onto the 2 imaging detectors and report the resulting coordinates in detector image frame.
This will simulate a segmented marker in the X-ray images, which you will use as input for the
reconstructor software.
• Input: Point in CK frame
• Output: Points in the A and B detector image frames
%}


function [coord_A, coord_B] = q2_xray_projection(point_CK)
    % X-ray Source  
    SAD = [0;100;0;1];
    Detector = [0;-100;0;1];
    % Find normal vectors: outward from the x-z detector planes
    normal_to_detector = [0;1;0;1];

    % transformation of the X-ray source
    Source_a = rotation_about_coord_axis('z', 45, SAD);
    Source_b = rotation_about_coord_axis('z', -45, SAD);

    Detector_a = rotation_about_coord_axis('z', 45, Detector);
    Detector_b = rotation_about_coord_axis('z', -45, Detector);
    normal_vecA = rotation_about_coord_axis('z', 45, normal_to_detector);
    normal_vecB = rotation_about_coord_axis('z', -45, normal_to_detector);

    % Unit Vector: Normalize the line between the point in CK and the beam source
    dir_vec_a = (point_CK - Source_a) / norm(point_CK - Source_a); 
    dir_vec_b = (point_CK - Source_b) / norm(point_CK - Source_b); 

    % Find intersection between line and plane
    % equation of the line 
    %    t = ((A-P) ○ n ) / (v ○ n) 
    tA = dot((Detector_a - Source_a), normal_vecA) / dot(dir_vec_a, normal_vecA);
    tB = dot((Detector_b - Source_b), normal_vecB) / dot(dir_vec_b, normal_vecB);

    % Find the intersection point
    intersection_A = Source_a + dir_vec_a * tA;
    intersection_B = Source_b + dir_vec_b * tB;
    
    % Call question 1 frame transform
    CK_toA = q1_frame_transforms_A;
    CK_toB = q1_frame_transforms_B;

    coord_A = CK_toA * [intersection_A;1];
    coord_B = CK_toB * [intersection_B;1];
end

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
    x =  SAD * (sqrt(2)/2);
    y =  SAD * (sqrt(2)/2);
    % no translation in z direction
    T = inv([1 0 0 -(x);0 1 0 -(-y);0 0 1 -(0);0 0 0 1]);
    R = [cosd(45) -sind(45) 0 0; sind(45) cosd(45) 0 0; 0 0 1 0; 0 0 0 1];
    CK_toA = inv(T*R);
end
function CK_toB = q1_frame_transforms_B
    SAD = 100;

    x =  SAD * (sqrt(2)/2);
    y =  SAD * (sqrt(2)/2);
    % no translation in z direction
    T = inv([1 0 0 -(-x);0 1 0 -(-y);0 0 1 -(0);0 0 0 1]);
    R = [cosd(-45) -sind(-45) 0 0; sind(-45) cosd(-45) 0 0; 0 0 1 0; 0 0 0 1];
    CK_toB = inv(T*R);
end
