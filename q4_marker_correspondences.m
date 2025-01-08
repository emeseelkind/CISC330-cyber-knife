%{
Q4. Marker Correspondences
• Task: Develop a module to resolve the correspondences in the reconstruction of 3 identical
markers. Explain the method in comments.
• Input: Three points in the A image frame, three points in the B image frame.
• Output: Correspondence matrix (refer to class notes.)
• Test: Project the M1CK, M2CK, M3C onto two the X-ray detectors – you have already done this. (1) Feed
the resulting image points to your module and show that you resolve their correct correspondences.
(2) Swap M1 and M2 in image A, feed the points to your module and show that you can resolve
correct correspondences. Run the above for a slightly different set of marker screws: M1CK =
[30, -30, 0], M2CK = [-30, 0, 0], M3CK = [0, -30, 60]. Report and explain your findings
%}

% q3_marker_reconstruction.m
function [correspondence_matrix] = q4_marker_correspondences(A,B)
    REM_matrix = zeros(3,3);

    for i = 1:length(A)
        for j = 1:length(B)
            [reconstructed_point_CK, REM] = q3_marker_reconstruction(A(:,i),B(:,j));
            REM_matrix(i,j) = REM;
        end
    end
    disp(REM_matrix);

    %initializing correspondance matrix
    correspondence_matrix = zeros(3,2);

    %assigning correspondance of points by using REM
    for i=1:length(REM_matrix)
        for j=1:length(REM_matrix)
            if (abs(REM_matrix(i,j)) < 0.0015)
                correspondence_matrix(i,1) = i;
                correspondence_matrix(i,2) = j;
            end
        end
    end
end