function [RMSE, Relative_Err] = Main_Test(W_MTL, X,Y)
Task_num = length(X);
RMSE = zeros(1, Task_num);
Relative_Err = zeros(1, Task_num);
for i = 1:Task_num
    RMSE(i) = RMSE_Test(W_MTL(:, i), X{i}, Y{i});
    Relative_Err(i) = RMSE(i) / mean(Y{i});
end
