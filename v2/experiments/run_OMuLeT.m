clear;

%% load data
load("../data/model.mat");
load("../data/forecasts_tra.mat");
load("../data/predict.mat");
load("../data/predict_flag.mat");

opts.error_type = 1; % 1 distance, 2 L1, 3 L2
opts.unit_change = 1.852;
opts.use_predict = 1;
opts.geo = 1;

para=[0.79983    0.83239    0.1053  151.2719    0.2699    0.1235];
opts.rho=para(1);
opts.gamma=para(2);
opts.omega=para(3);
opts.mu=para(4);
opts.nu=para(5);
opts.eta=para(6);

[m, d, T, N] = size(X);
W_init = [1/m*ones(T*m,1)];
[W P] = back_tracking(X(:,:,2:end,:), Y(:,2:end,:), time, W_init, opts, @OMuLeT, @predict_renorm, @predict_renorm);

predict(21).name = "OMuLeT";
predict(21).tra = P;
predict(21).tra_W = W;

save('../data/predict.mat','predict');
