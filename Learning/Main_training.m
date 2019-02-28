clear;
clc;

%% add path
addpath('./Funs')
addpath('./Data')

%% load data

load Data.mat

%% parameter setting
groups = {[1:162],[163:167]};
GW = [length(groups{1}), length(groups{2})];
GW = sqrt(GW);

d = length(Feature);
lambda1 = 0.1;  % parameter for the multi-task (l2) term
lambda2 = 0.1; % parameter for the group lasso (l2) term
lambda3 = 5; % parameter for sparse l1 norm

%%  Learning

[Final_W_MTL_sgl Tar] = MTL_SGL(Xmtl, Ymtl, lambda1, lambda2,lambda3, groups, GW);

%%  RMSE

[Final_RMSE_sgl, Final_Relative_Err_sgl] = Main_Test(Final_W_MTL_sgl, Xmtl, Ymtl);


%% perormance analyese
 
pre_y1 = Xmtl{1}*Final_W_MTL_sgl(:,1);
pre_y2 = Xmtl{2}*Final_W_MTL_sgl(:,2);
pre_y3 = Xmtl{3}*Final_W_MTL_sgl(:,3);
pre_y4 = Xmtl{4}*Final_W_MTL_sgl(:,4);
pre_y5 = Xmtl{5}*Final_W_MTL_sgl(:,5);

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

