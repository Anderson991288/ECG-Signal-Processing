## SMOTE: Imbalanced Dataset Processing

```
import imblearn
from imblearn.over_sampling import SMOTE


smote=SMOTE()
wave_smote,id_smote=smote.fit_resample(ECG_wave2,ECG_id2)

print(id_smote.value_counts())
print(wave_smote.shape)

train_new_df=pd.concat([wave_smote, id_smote],axis='columns')
print(train_new_df.shape)
```
* 將所有類別的心跳都調整到與數量最多的相同
  
  Classes: ['N': 0, 'S': 1, 'V': 2, 'F': 3, 'Q': 4]
  
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/3a0b173d-2e92-4f80-ae5a-fa62d63927a8)


### 結果
* 使用SMOTE的前後比較
* 使用SMOTE後loss較低而準確率提升

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/a92cf80f-669c-47b1-86ad-5d9786e32ecc)


  
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/ea9033be-cf9f-4d23-865e-09cbd0491c23)

* 混淆矩陣(confusion matrix)
  
  •	 用途：用於描述分類模型的性能。
  
  •	以模型得出的預測結果與正解相互對應，分成四類（預測為真/假、正解為真/假）所組成的矩陣。

   * 真正(TP)：模型正確地預測正類別。
   * 偽負(FN)：模型錯誤地預測正類別為負類別。
   * 偽正(FP)：模型錯誤地預測負類別為正類別。
   * 真負(TN)：模型正確地預測負類別。
     
  • 這四個數值可以用來計算許多評估分類器效能的指標，例如精確度（Precision）、召回率（Recall）、F1 分數（F1 Score）等。


![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/5f9688f0-917b-402c-becf-3c5d6602b0b7)


* 下圖中，對角線為預測正確。而其他部分為預測錯誤。
* 例如True Labels(真實的類別)為1但Predicted Labels(模型預設的類別)為0，也就是本來應該要分到1但模型將他分到0，這樣的數量有215個
  
![圖片1](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/06163b6b-8e88-4f26-9acb-c22389751f2a)
