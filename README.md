# ECG-Signal-Processing
## 使用MIT-BIH 心電數據庫:
文件結構包含頭文件（.hea）、數據文件（.dat）和注釋文件（.atr）。
### 頭文件（.hea）
提供了關於數據記錄的一些基本訊息，例如數據的訊號數量、訊號的長度、採樣率、數據存儲格式等。下面是一個示例頭文件（100.hea）的內容：
```
100.hea
2 360 650000
MLII
V5
```
* 第一行表示記錄編號和擷取時間。
* 第二行中的數字 2 表示數據包含兩個訊號。
* 第三行中的數字 360 表示每個訊號的採樣率為 360 Hz。
* 第四行和第五行分別指定了訊號的名稱（MLII和V5）。
  
### 數據文件（.dat）
包含記錄的原始數據。數據以特定的格式（如 Format 212）儲存。每個訊號的數據交替存儲。
以十六進制顯示的數據文件（100.dat）片段如下所示：
```
E3 33 F3 80 10 F3 E5 33 F3 E3 33 F3
```
* 每三個字節（24位）表示兩個數值，分別來自兩個訊號。以示例中的數據為例，前三個字節 "E3 33 F3" 表示兩個值分別為 0x3E3 和 0x3F3。這些數值可以轉換為十進制，代表兩個訊號的第一個採樣點。

### 注釋文件（.atr）
包含了專家標註的R波位置以及每個心跳的類型。這提供了對數據的標註和分類的依據。
以十六進制顯示的注釋文件（100.atr）片段如下所示：
```
20 02 2D 01 38 00 5A 00 8C 00
```
* 每個字節表示不同的標註訊息，例如心跳類型和R波位置。

data source : https://www.physionet.org/content/mitdb/1.0.0/

WFDB Toolbox for MATLAB : https://archive.physionet.org/physiotools/matlab/wfdb-app-matlab/

開好6個資料夾再執行 data.m
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/d7e76d0a-1984-43a0-b980-609aaf0bddf0)


### MIT-BIH數據集包含了以360Hz的取樣率錄製的48個不同受試者的心電圖(ECG)訊號。數據庫中將心律不整分為5種類別，如下表:

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/3a044d66-7f51-4819-ab5f-bbd25f094c30)


## 透過改變資料長度(data length)，改善心律不整疾病判斷準確度

我們嘗試改變各種長度的資料來做訓練與測試，其中3600 (60 * 60)與400 (20 * 20)的表現較為突出，而兩者之中我們選擇400來做討論與分析

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/eff0e7bf-8ee5-4abd-880a-ec5f9e46e346)




##  利用SMOTE算法，解決F-type與S-type數據較少的問題
### SMOTE (Synthetic Minority Over-sampling Technique) 

【SMOTE 方法 : 合成少數過採樣方法】
我們採用了一種方法叫做 SMOTE，主要概念就是在少數樣本位置近的地方，人工合成一些樣本，整個算法的流程如下 :

    設定一個採樣倍率 N，也就是對每個樣本需要生成幾個合成樣本
    設定一個近鄰值 K ，針對該樣本找出 K 個最近鄰樣本並從中隨機選一個
   


###  SMOTE
- `X_smote = smote(X, N, k)` 
### Inputs
- `X`: Original dataset `(n x d)` matrix
- `N`: Percentage of data-augmentation intended, Typically, N > 100, if N < 100, then N is set to 100. `(scalar)`
- `k`: number of nearest neighbors to consider while performing augmentation `(scalar)`
 
### Code

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

### 訓練與測試

* 選擇一個CNN網路，如ResNet-18，並更改MATLAB預設的fullyConnectedLayer與classificationLayer。fullyConnectedLayer的OutputSize改成5

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/35b78a40-71af-420b-bed2-24477939f404)


* 訓練結果
  
![圖片1](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/ac2799b1-a571-4cbf-b8d3-e54d51feb451)

* 測試結果
  
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/665ef8e6-a4a8-4ec6-95f4-9f715aaa1482)
  

* 使用SMOTE後的結果，分別使用不同網路做測試

![圖片](https://user-images.githubusercontent.com/68816726/236611552-920e5e36-a6b8-4be8-aaae-d690a9400ad5.png)

* 針對結果較好的網路更改Batchsize 做測試

![圖片](https://user-images.githubusercontent.com/68816726/236611474-a79fb992-070c-40ed-90df-29d61e990dae.png)

* 下圖為**未使用**SMOTE 所產出的結果，與上圖比較可看出使用SMOTE後的準確度有一定程度的提升

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/f82fa927-59d1-446e-9d39-c3a6e550b16e)



* 以下為參考論文所提出的概念
  
### Convert electrocardiosignal into 2D grayscale instead of traditional ECG

 Research on Personal Identity Verification Based on Convolutional Neural Network

a) Data structure conversion
 * transforming data from 1D structure of ECG signal to 2D structure data

b) Data segmentation and generation of grayscale image

  *  Min-Max standardization processing.
 *  Each data formed after the segmentation contains 3600 sample points.
 * generation of the grayscale image

### Reference Paper 
[1] U. Rajendra Acharya , “A deep convolutional neural network model to classify heartbeats,” Computers in Biology and Medicine , vol. 89, no. 1, pp. 389-396, October 2017.

[2] Jia Wu, Chao Liu, Qiyu Long, Weiyan Hou, “Research on Personal Identity Verification Based on Convolutional Neural Network,” 2019 IEEE 2nd International Conference on Information and Computer Technologies.






