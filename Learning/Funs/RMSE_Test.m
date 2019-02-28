function RMSE = RMSE_Test(W, X, Y)
n_sam = size(X, 1);
Y_pre = X*W;
RMSE = sqrt( norm( Y - Y_pre, 2 )^2 / n_sam );

