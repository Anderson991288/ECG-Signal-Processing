# WFDB


* WFDB主要用於儲存ECG數據，可以對波形數據執行各種分析，包括視覺化、特徵提取和演算法開發。

* WFDB提供了讀取、寫入和操作生理波形數據的工具庫。且支援多種文件格式，例如標準的WFDB格式（".dat"），用於儲存數字化的波形數據，以及頭文件（".hea"），包含有關訊號及其註解的訊息。

# 在Colab 使用 WFDB 
* 執行以下程式，從MIT-BIH數據庫讀取資料
```
pip install wfdb
import wfdb

wfdb.dl_database('mitdb', 'mitdb')

record = wfdb.rdsamp('mitdb/103', sampto=3000)
annotation = wfdb.rdann('mitdb/103', 'atr', sampto=3000)
```
