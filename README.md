# ECG-Signal-Processing
## Convert electrocardiosignal into 2-D grayscale instead of traditional ECG.

### Reference Paper : Research on Personal Identity Verification Based on Convolutional Neural Network

a) Data structure conversion
 * transforming data from 1D structure of ECG signal to 2D structure data

b) Data segmentation and generation of grayscale image

  *  Min-Max standardization processing.
 *  Each data formed after the segmentation contains 3600 sample points.
 * generation of the grayscale image





![螢幕擷取畫面 2023-04-23 111210](https://user-images.githubusercontent.com/68816726/233817697-3061fe4b-4822-45ce-80fb-4d9a8fcadf2f.png)


![螢幕擷取畫面 2023-04-23 111235](https://user-images.githubusercontent.com/68816726/233817700-548381fb-f91f-492e-855b-a71c87299a5c.png)


![圖片](https://user-images.githubusercontent.com/68816726/235293407-ebf3ffec-a059-480f-a283-4208a6b2ec94.png)

![圖片](https://user-images.githubusercontent.com/68816726/235293431-968b70ea-3810-4a3b-ad61-59b0e48b2f5e.png)


## SMOTE (Synthetic Minority Over-sampling Technique) :

【SMOTE 方法 : 合成少數過採樣方法】
我們引進了新的方法叫做 SMOTE 方法，這是 2002 年提出的一篇論文，主要概念也就是在少數樣本位置近的地方，人工合成一些樣本，整個算法的流程如下 :

    設定一個採樣倍率 N，也就是對每個樣本需要生成幾個合成樣本
    設定一個近鄰值 K ，針對該樣本找出 K 個最近鄰樣本並從中隨機選一個
    根據以下公式來創造 N 個樣本


* 這個程式是實現SMOTE (Synthetic Minority Over-sampling Technique)算法的函數，該算法用於解決不平衡數據集的問題

### Inputs:
- `X`: Original dataset `(n x d)` matrix
- `N`: Percentage of data-augmentation intended, Typically, N > 100, if N < 100, then N is set to 100. `(scalar)`
- `k`: number of nearest neighbors to consider while performing augmentation `(scalar)`
 
### Outputs:
- `X_smote`: augmented dataset containing original data as well. `(m x d)` matrix, where `m > n`

```
function [X,C,Xn,Cn] = smote(X, N, k, options)
    arguments
        X (:,:) % 觀察矩陣
        N (:,1) double {mustBeNonnegative} = 1 % 合成量
        k (:,1) double {mustBePositive,mustBeInteger} = 5 % 考慮的最近鄰居數量
        options.Class (:,1) {mustBeSameSize(options.Class,X)} % 類向量：決定每個觀察的類別
        options.SynthObs (:,1) {mustBeSameSize(options.SynthObs,X)} % 合成向量。決定每個觀察作為合成的基數使用的次數
    end
```

* 這個函數有四個輸入參數，其中 X 是觀察矩陣，N 是合成量，k 是考慮的最近鄰居數量，options 包含選擇性的類向量和合成向量。

```
    % Handle optional Class vector
    if isfield(options,'Class')
        C = options.Class;
    else
        C = ones(size(X,1),1); % 如果未給定類向量，則將所有觀察默認為相同類別：[1]
    end
    uC = unique(C); % 類別列表
    nC = groupcounts(C); % 每個類別的觀察數量

    % Handle N - must have one number for each class
    if isempty(N) % 如果 N 為空，則執行平衡處理
        if numel(uC)<2 % 類向量中必須至少包含兩個類別才能進行平衡處理
            error('Class vector must contain at least 2 classes to balance.');
        end
        N = max(nC)./nC-1; % 計算每個類別的過採樣百分比，以達到與多
```

* 這裡處理可選的類向量。如果 options 中存在 Class，則將其存儲在 C 中。否則，C 被設置為一個大小為 X 行數的向量，並且所有觀察被歸類為類別 1。uC 存儲所有不同的類別，nC 則記錄每個類別的觀察數量。

```
    % Handle N - must have one number for each class
    if isempty(N) % 如果 N 為空，則執行平衡處理
        if numel(uC)<2 % 類向量中必須至少包含兩個類別才能進行平衡處理
            error('Class vector must contain at least 2 classes to balance.');
        end
        N = max(nC)./nC-1; % 計算每個類別的過採樣百分比，以達到與多

```

* 這個程式用於讀取來自文件夾的心跳聲音數據，對其進行SMOTE算法過採樣，然後將其轉換為灰度圖像保存到文件夾中。

```
type = ['F'; 'S']; % 聲音類型
L = 400; % 每個心跳聲音樣本的長度
k = 10; % 考慮 5 個最近鄰居
N = 9; % 過採樣到原始數據集的 1.5 倍大小

for i = 1:size(type, 1)
    % 讀取當前類型的心跳聲音數據
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
    
    % 將過採樣的數據保存為灰度圖像
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
* 這個程序中， type 是兩種不同類型的心跳聲音類型。對於每種類型，程序會從文件夾中讀取 500 條心跳聲音數據，每條數據的長度都為 L。然後，程序使用SMOTE算法對這些數據進行過採樣，並將其保存為灰度圖像。保存的圖像會按照數據的類型（即 type）進行分組，保存在文件夾

