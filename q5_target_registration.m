%{
Q5. Target Registration
• Task: Develop a module to register a tumor target point from CT frame to CK frame.
• Input: Target point in CT frame, 3 marker points in CT frame (M1CT, M2CT, M3CT), 3 marker points in
CK frame (M1CK, M2CK, M3CK).
• Output: Target point in CK frame.
%}
function target_point_CK = q5_target_registration(TCCT, MCT, MCK)
    
    % generate CT frame
    [CT_frame_Oe, e1, e2, e3] = generate_orthonormal_frame(MCT(1,:),MCT(2,:),MCT(3,:));

    % generate CK frame
    [CK_frame_Oe, v1, v2, v3] = generate_orthonormal_frame(MCK(1,:),MCK(2,:),MCK(3,:));

    % transformation matrix for CT to home frame transformation
    F_CT_to_home = transform_frame_to_home(CT_frame_Oe, e1, e2, e3);
       
    % transformation matrix for home to CK frame transformation
    F_home_to_CK = inv(transform_frame_to_home(CK_frame_Oe, v1, v2, v3));
    
    % determine transformation matrix for CT to CK frame transformation
    % Apply CT to CK frame transformation to CT point to get the target point
    target_point_CK = F_home_to_CK * F_CT_to_home * [TCCT;1];

end
function [Oe, e1, e2, e3] = generate_orthonormal_frame(A, B, C)
    % Put Oe into a matrix in the center
    Oe = (A + B + C) / 3;
    e1 = (B - A) / norm(B - A);
    e2 = (C - A) - (dot((C - A), e1) * e1);  
    e2 = e2 / norm(e2); 
    % perpendicular to plane of marker
    e3 = cross(e1, e2);
    e3 = e3 / norm(e3);  
    %needle = -e3;
end

function F_v_to_h = transform_frame_to_home(O_v, v1, v2, v3)    
    % frame rotation to home
    R = [v1(:) v2(:) v3(:)];
    R = [R; 0,0,0];
    R= [R,[0;0;0;1]];
    % frame translation to home
    T = -O_v(:);
    i=eye(4);
    i(1:3, 4) = T;
    F_v_to_h = R * i;
end