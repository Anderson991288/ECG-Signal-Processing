# ECG-Signal-Processing

## 透過改變資料長度(data length)，改善心律不整疾病判斷準確度

我們嘗試改變各種長度的資料來做訓練與測試，其中3600 (60 * 60)與400 (20 * 20)的表現較為突出，而兩者之中我們選擇400來做討論與分析

![圖片](https://user-images.githubusercontent.com/68816726/235293407-ebf3ffec-a059-480f-a283-4208a6b2ec94.png)

![圖片](https://user-images.githubusercontent.com/68816726/235293431-968b70ea-3810-4a3b-ad61-59b0e48b2f5e.png)



##  利用SMOTE算法，解決F-type與S-type數據較少的問題
### SMOTE (Synthetic Minority Over-sampling Technique) :

【SMOTE 方法 : 合成少數過採樣方法】
我們採用了一種方法叫做 SMOTE，主要概念就是在少數樣本位置近的地方，人工合成一些樣本，整個算法的流程如下 :

    設定一個採樣倍率 N，也就是對每個樣本需要生成幾個合成樣本
    設定一個近鄰值 K ，針對該樣本找出 K 個最近鄰樣本並從中隨機選一個
   


###  SMOTE:
- `X_smote = smote(X, N, k)` 
### Inputs:
- `X`: Original dataset `(n x d)` matrix
- `N`: Percentage of data-augmentation intended, Typically, N > 100, if N < 100, then N is set to 100. `(scalar)`
- `k`: number of nearest neighbors to consider while performing augmentation `(scalar)`
 

* 這個程式用於讀取來自資料夾的心跳數據，對其進行SMOTE算法過採樣，然後將其轉換為灰階圖存到資料夾中

```
type = ['F'; 'S']; % 心跳類型
L = 400; % 每個心跳樣本的長度
k = 10; % 考慮 5 個最近鄰居
N = 9; % 過採樣到原始數據集的 1.5 倍大小

for i = 1:size(type, 1)
    % 讀取目前類型的心跳數據
    X = zeros(500, L);
    for j = 1:500
        load(['D:\111專題\stft\raw data-', int2str(L), '\', type(i,:), '\', type(i,:), '_', num2str(j), '.mat']);
        X(j,:) = x(1:L);
    end
    
    % 對數據應用 SMOTE 過採樣
    Y = ones(N*size(X,1), 1);
    Y(1:size(X,1)) = 0;
    options.Class = Y;
    [X_smote, ~] = smote(X, N, k);

    % 將數據重新縮放到 [0,1] 範圍內
    X_smote = X_smote - min(X_smote(:));
    X_smote = X_smote ./ max(X_smote(:));
    
    % 將過採樣的數據存為灰階圖
    L_sqrt = sqrt(L);
    for j = 1:size(X_smote, 1)
        s_x = reshape(X_smote(j,:), L_sqrt, L_sqrt);
        imagesc(s_x);
        colormap(gray);
        set(gca, 'xtick', [], 'xticklabel', []);
        set(gca, 'ytick', [], 'yticklabel', []);
        saveas(gcf, ['D:\111專題\gray scale\gray scale_2-', int2str(L), '\5TYPE\', type(i,:), '\', type(i,:), '_', num2str(j), '.jpg']);
    end
end
```
* 這個程式中， type 是兩種不同類型的心跳聲音類型。對於每種類型，程式會從資料夾中讀取 500 條心跳聲音數據，數據的長度都是 L。然後，程式使用SMOTE對這些數據進行過採樣，並將其存為灰階圖。保存的圖像會按照數據的類型（即 type）進行分組，保存在資料夾


* 針對F-type 和 S-type 資料量不足的問題，使用SMOTE來增加資料量。

```
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
```

* 使用SMOTE後的結果，分別使用不同網路做測試

![圖片](https://user-images.githubusercontent.com/68816726/236611552-920e5e36-a6b8-4be8-aaae-d690a9400ad5.png)

* 針對結果較好的網路更改Batchsize 做測試

![圖片](https://user-images.githubusercontent.com/68816726/236611474-a79fb992-070c-40ed-90df-29d61e990dae.png)

* 下圖為**未使用**SMOTE 所產出的結果，與上圖比較可看出使用SMOTE後的準確度有一定程度的提升
![螢幕擷取畫面 2023-04-23 111210](https://user-images.githubusercontent.com/68816726/233817697-3061fe4b-4822-45ce-80fb-4d9a8fcadf2f.png)


![螢幕擷取畫面 2023-04-23 111235](https://user-images.githubusercontent.com/68816726/233817700-548381fb-f91f-492e-855b-a71c87299a5c.png)




* 以下為參考論文所提出的概念
  
### Convert electrocardiosignal into 2D grayscale instead of traditional ECG.

 Research on Personal Identity Verification Based on Convolutional Neural Network

a) Data structure conversion
 * transforming data from 1D structure of ECG signal to 2D structure data

b) Data segmentation and generation of grayscale image

  *  Min-Max standardization processing.
 *  Each data formed after the segmentation contains 3600 sample points.
 * generation of the grayscale image

### Reference Paper :
[1] U. Rajendra Acharya , “A deep convolutional neural network model to classify heartbeats,” Computers in Biology and Medicine , vol. 89, no. 1, pp. 389-396, October 2017.

[2] Jia Wu, Chao Liu, Qiyu Long, Weiyan Hou, “Research on Personal Identity Verification Based on Convolutional Neural Network,” 2019 IEEE 2nd International Conference on Information and Computer Technologies.






