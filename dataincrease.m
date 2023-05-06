clear;clc;close all;
close all;

y = [];
N = 800;
L = 400;
type = ['N';'S';'V';'F';'Q'];

for k = 4
    for i = 1:N
        load(['D:\111專題\stft\raw data-',int2str(L),'\',type(k,1),'\',type(k,1),'_',num2str(i),'.mat']);
         z = x;
         y(i,1:L+1) = z;
    end
    R = 2;%放大倍數
    X = smote(y, R-1 ,R-1);%第一項為原始資料，第二項為放大倍數，第三項為採樣資料數量

    for j = 1:N*R
        x = X(j,1:L+1);
        filename = strcat(['D:\111專題\stft\raw data-',int2str(L),'_w over_data increase\',type(k,1),'\',type(k,1),'_',num2str(j),'.mat']);    
    
    end
end

