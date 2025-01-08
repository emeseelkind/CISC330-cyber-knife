%{
Test: Test each projector on at least 3 suitable points of your choice, make a sketch, run your
module and show that it produces the predicted results
%}
% q2_xray_projection.m
function [] = test_q2
    disp("Tests for marker projection of points in CK to detector frame A and B");

    % Define test points
    disp('Test number 1 [0; 0; 0]: ');
    [coord_A, coord_B] = q2_xray_projection([0; 0; 0]);
    disp('Points in the A detector image frames: ');
    disp(coord_A(1:3));
    disp('Points in the B detector image frames: ');
    disp(coord_B(1:3));

    disp('Test number 2 [1;0;0]: ');
    [coord_A, coord_B] = q2_xray_projection([1;0;0]);
    disp('Points in the A detector image frames: ');
    disp(coord_A(1:3));
    disp('Points in the B detector image frames: ');
    disp(coord_B(1:3));

    disp('Test number 3 [1;1;1]: ');
    [coord_A, coord_B] = q2_xray_projection([1;1;1]);
    disp('Points in the A detector image frames: ');
    disp(coord_A(1:3));
    disp('Points in the B detector image frames: ');
    disp(coord_B(1:3));
end
