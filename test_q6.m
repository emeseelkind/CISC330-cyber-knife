%{
Test: Run the simulation and analyze your findings. Does your simulation behave as expected?
Does it start breaking above the estimated bound for maxMLE?
%}
function [] = test_q6()
    maxMLE = q6_target_registration_error_simulation();
    fprintf('This is the maximum marker localization error: %.2f mm \n', maxMLE);

end