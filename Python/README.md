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

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/8c9b2fbb-49bf-4d52-8ab0-513bb070af6d)


### 結果

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/7c66e164-45f9-499d-ad2a-1475f6f79816)

![image](https://github.com/Anderson991288/ECG-Signal-Processing/assets/68816726/65356309-bd25-4aa2-b78c-37b8b772386b)
