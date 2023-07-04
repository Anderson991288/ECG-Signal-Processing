### SMOTE: Imbalanced Dataset Processing

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
  
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/3a0b173d-2e92-4f80-ae5a-fa62d63927a8)


### 結果
* 使用SMOTE的前後比較
* 使用SMOTE後loss較低而準確率提升
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/7c66e164-45f9-499d-ad2a-1475f6f79816)


  
![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/ea9033be-cf9f-4d23-865e-09cbd0491c23)
