%{
• Test: Test each transform on at least 3 suitable points of your choice, make a sketch, run your
module and show that it produces the predicted results.
%}

function [] = test_q1
    disp("Tests for frame transformation from CK to A and B detector frame");
    disp("CK to A frame transformation matrix");
    CK_toA = q1_frame_transforms_A();
    disp("CK to AB frame transformation matrix");
    CK_toB = q1_frame_transforms_B();

    disp("Test 1: Ck point (0,0,0)");    
    disp("First test for detector frame A");
    point_A = CK_toA * [0;0;0;1];
    point_A = point_A(1:3)
    
    disp("First test for detector frame B");
    point_B = CK_toB * [0;0;0;1];
    point_B = point_B(1:3)
    
    disp("Test 2: CK point (1,1,1)");
    disp("Second test for detector frame A");
    point_A = CK_toA * [1;1;1;1];
    point_A = point_A(1:3)
    disp("Second test for detector frame B");
    point_B = CK_toB * [1;1;1;1];
    point_B = point_B(1:3)
    
    disp("Test 3: CK point (1,0,0)");
    disp("Third test for detector frame A");
    point_A = CK_toA * [1;0;0;1];
    point_A = point_A(1:3)
    disp("Third test for detector frame B");
    point_B = CK_toB * [1;0;0;1];
    point_B = point_B(1:3)
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