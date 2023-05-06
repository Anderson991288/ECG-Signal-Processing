# QRS Detection Algorithm 

### Find the R peak of the ECG signal. 
• Verify the right location as Goldindex vector. 
• Assign the variable of index to store the peak index. 
• ECG data 
- Number 100/102 
- 650000 samples 
- Match window = ±15 

### 使用到的函數 :
* 用 𝑖𝑠𝑙𝑜𝑐𝑎𝑙𝑚𝑎𝑥 來偵測 ECG 訊號中的 local maxima 包括 ecg102 and ecg100. 
* 𝑀𝑖𝑛𝑃𝑟𝑜𝑚𝑖𝑛𝑒𝑛𝑐𝑒 可以控制靈敏度。 較高的 𝑀𝑖𝑛𝑃𝑟𝑜𝑚𝑖𝑛𝑒𝑛𝑐𝑒 值會導致檢測到較少的峰
值，而較低的值會導致檢測到更多的峰值，包括可能因為雜訊而導致的較小峰值。 
* 用𝑠𝑢𝑏𝑝𝑙𝑜𝑡 在㇐個視窗產生多個圖形

* code:

```
clear
clc

load('QRS');

x= 1:650000;

locs = islocalmax(ecg100(1:650000), 'MinProminence' , 0.5);
subplot(2,1,1);plot(x,ecg100(1:650000),x(locs),ecg100(locs),'rO');
title('ecg100');


locs2 = islocalmax(ecg102(1:650000), 'MinProminence' , 0.5);
subplot(2,1,2);plot(x,ecg102(1:650000),x(locs2),ecg102(locs2),'rO');
title('ecg102');



locs = x(locs);
locs2 = x(locs2);



%tp,fp測試
tp = 0;
fp = 0;
for i = 1:numel(locs)                   %%locs為ecg100的QRS波預測位置
    if find(Goldindex100-15 <= locs(i) & locs(i) <= Goldindex100+15)    
        tp = tp + 1;
    end
end
fp = numel(locs) - tp;
fn = numel(Goldindex100) - tp;
se = tp / (tp + fn);
p = tp / (tp + fp);
der = (fn + fp)/(tp + fp + fn);
fprintf('ecg100 TP = %d , FP = %d , FN = %d , ',tp,fp,fn);
fprintf('Se = %.4f , +P = %.4f , DER = %.4f\n',se,p,der);


tp = 0;
fp = 0;
for j = 1:numel(locs2)                  %%locs2為ecg102的QRS波預測位置
    if find(Goldindex102-15 <= locs2(j) & locs2(j) <= Goldindex102+15)
        tp = tp + 1;
    end
end
fp = numel(locs2) - tp;
fn = numel(Goldindex102) - tp;
se = tp / (tp + fn);
p = tp / (tp + fp);
der = (fn + fp)/(tp + fp + fn);
fprintf('ecg102 TP = %d , FP = %d , FN = %d , ',tp,fp,fn);
fprintf('Se = %.4f , +P = %.4f , DER = %.4f',se,p,der);

```

* Result:

![untitled](https://user-images.githubusercontent.com/68816726/236611851-6841ca07-bf2e-4587-b80c-f0cf6a528e40.jpg)

