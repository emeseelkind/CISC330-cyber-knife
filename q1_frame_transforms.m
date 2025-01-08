%{
Q1: Frame Transforms
• Task: Develop a module to generate frame transformations from the 
CK frame to the A and B detector image frames. 
(Feel free to implement it as one function or two separate functions, 
one for each detector.)
• Input: none
• Output: Two 4x4 homogeneous matrices, from CK frame the A and B detector frames.
%}

function CK_toA = q1_frame_transforms_A()
    SAD = 100; 
    %find x and y
    x =  SAD * (sqrt(2)/2);
    y =  SAD * (sqrt(2)/2);
    
    % no translation in z direction
    T = inv([1 0 0 -(x);0 1 0 -(-y);0 0 1 -(0);0 0 0 1]);
    R = [cosd(45) -sind(45) 0 0; sind(45) cosd(45) 0 0; 0 0 1 0; 0 0 0 1];
    CK_toA = inv(T*R);

end

function CK_toB = q1_frame_transforms_B()
    SAD = 100;
    %find x and y
    x =  SAD * (sqrt(2)/2);
    y =  SAD * (sqrt(2)/2);

    % no translation in z direction
    T = inv([1 0 0 -(-x);0 1 0 -(-y);0 0 1 -(0);0 0 0 1]);
    R = [cosd(-45) -sind(-45) 0 0; sind(-45) cosd(-45) 0 0; 0 0 1 0; 0 0 0 1];
    CK_toB = inv(T*R);
end
