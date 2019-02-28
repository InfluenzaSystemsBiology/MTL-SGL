clear;
clc;

%% add path
addpath(genpath('../'));
%% load dtaa
load Data.mat;

%% run Multi-task Sparse Group Lasso

groups = {[1:162],[163:167]};
GW = [length(groups{1}), length(groups{2})];
GW = sqrt(GW);

d = length(Feature);
lambda1 = 0.1;  % parameter before the multi-task (l2) term
lambda2 = 0.1; % parameter before the group lasso (l2) term
lambda3 = 5; % parameter before sparse l1 norm

%  Bootstrap

Arr = cell(1);

for i = 1:100
    fprintf('round %d ...\n',i);
    % random pick 80% sample
    Xtmp = Xmtl;
    Ytmp = Ymtl;
    
    X = cell(1);
    Y = cell(1);
    for j = 1:5
        idx = randperm(length(Ytmp{j}));
        num = floor(length(Ytmp{j})*0.8);
        idx = idx(1:num);
        X{j} = Xtmp{j}(idx,:);
        Y{j} = Ytmp{j}(idx);
    end

    [W,~] = MTL_SGL(X, Y, lambda1, lambda2,lambda3, groups,GW);
    Arr{i} = W;
end

CleanW = cell(1);
Bootstrap = zeros(size(Arr{1}));
AddAll = zeros(size(Arr{1}));
for i = 1:100
    w = Arr{i};
    tmp = abs(w);
    w(find(tmp < 0.01)) = 0;
    CleanW{i} = w;
    tmp = w;
    tmp(find(w ~= 0)) = 1;
    Bootstrap = Bootstrap + tmp;
    AddAll = AddAll + w;
end

Sel = Bootstrap;
Sel(find(Sel < 80)) = 0;
Sel(find(Sel >= 80)) = 1;

unidx = find(Sel == 0);
idx = find(Sel == 1);
AddAll(unidx) = 0;
FinalW = zeros(size(AddAll));
FinalW(idx) = AddAll(idx)./Bootstrap(idx);

tmp = FinalW;
tmp(find(tmp ~= 0)) = 1;
tmp = sum(tmp,2);
tmp(find(tmp == 0)) = 1;
Global_W = sum(FinalW,2)./tmp;

save Res.mat

%%
[Final_RMSE, Final_Relative_Err_sgl] = Main_Test(FinalW, Xmtl, Ymtl);

pre_y1 = Xmtl{1}*FinalW(:,1);
pre_y2 = Xmtl{2}*FinalW(:,2);
pre_y3 = Xmtl{3}*FinalW(:,3);
pre_y4 = Xmtl{4}*FinalW(:,4);
pre_y5 = Xmtl{5}*FinalW(:,5);

cc1 = min(min(corrcoef(Ymtl{1},pre_y1)));
cc2 = min(min(corrcoef(Ymtl{2},pre_y2)));
cc3 = min(min(corrcoef(Ymtl{3},pre_y3)));
cc4 = min(min(corrcoef(Ymtl{4},pre_y4)));
cc5 = min(min(corrcoef(Ymtl{5},pre_y5)));
Final_CC = [cc1 cc2 cc3 cc4 cc5];

Final_accurcy = [];

tmp1 = Ymtl{1};
tmp2 = pre_y1;
tmp1(find(tmp1 < 2)) = 0;
tmp1(find(tmp1 >= 2)) = 1;
tmp2(find(tmp2 < 2)) = 0;
tmp2(find(tmp2 >= 2)) = 1;
acc = (length(tmp1)-sum(abs(tmp1-tmp2)))/length(tmp1);
Final_accurcy = [Final_accurcy acc];

tmp1 = Ymtl{2};
tmp2 = pre_y2;
tmp1(find(tmp1 < 2)) = 0;
tmp1(find(tmp1 >= 2)) = 1;
tmp2(find(tmp2 < 2)) = 0;
tmp2(find(tmp2 >= 2)) = 1;
acc = (length(tmp1)-sum(abs(tmp1-tmp2)))/length(tmp1);
Final_accurcy = [Final_accurcy acc];

tmp1 = Ymtl{3};
tmp2 = pre_y3;
tmp1(find(tmp1 < 2)) = 0;
tmp1(find(tmp1 >= 2)) = 1;
tmp2(find(tmp2 < 2)) = 0;
tmp2(find(tmp2 >= 2)) = 1;
acc = (length(tmp1)-sum(abs(tmp1-tmp2)))/length(tmp1);
Final_accurcy = [Final_accurcy acc];

tmp1 = Ymtl{4};
tmp2 = pre_y4;
tmp1(find(tmp1 < 2)) = 0;
tmp1(find(tmp1 >= 2)) = 1;
tmp2(find(tmp2 < 2)) = 0;
tmp2(find(tmp2 >= 2)) = 1;
acc = (length(tmp1)-sum(abs(tmp1-tmp2)))/length(tmp1);
Final_accurcy = [Final_accurcy acc];

tmp1 = Ymtl{5};
tmp2 = pre_y5;
tmp1(find(tmp1 < 2)) = 0;
tmp1(find(tmp1 >= 2)) = 1;
tmp2(find(tmp2 < 2)) = 0;
tmp2(find(tmp2 >= 2)) = 1;
acc5 = (length(tmp1)-sum(abs(tmp1-tmp2)))/length(tmp1);
Final_accurcy = [Final_accurcy acc];

%% performance visulization 

subplot(3,2,1);
plot(Ymtl{1},abs(pre_y1),'*');
hold on
set(gca,'XTick',[1:10]);
set(gca,'YTick',[1:10]);
plot([0,10],[0,10],'r');
subplot(3,2,2);
plot(Ymtl{2},abs(pre_y2),'*');
hold on
set(gca,'XTick',[1:10]);
set(gca,'YTick',[1:10]);
plot([0,10],[0,10],'r');
subplot(3,2,3);
plot(Ymtl{3},abs(pre_y3),'*');
hold on
set(gca,'XTick',[1:10]);
set(gca,'YTick',[1:10]);
plot([0,10],[0,10],'r');
subplot(3,2,4);
plot(Ymtl{4},abs(pre_y4),'*');
hold on
set(gca,'XTick',[1:10]);
set(gca,'YTick',[1:10]);
plot([0,10],[0,10],'r');
subplot(3,2,5);
plot(Ymtl{5},abs(pre_y5),'*');
hold on
set(gca,'XTick',[1:10]);
set(gca,'YTick',[1:10]);
plot([0,10],[0,10],'r');








