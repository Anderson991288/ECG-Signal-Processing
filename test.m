%号沏試訓練結果
%使用一個已經訓練好的深度學習模型 (modified net_10mins)對一個包含潮試圖像的路料集 (imdstest)進厅分類
%然後計算accuracy

testimagepath = fullfile ('gray scale-3600', 'testing');
imdsTest = imace Datastore (tesf magepath, 'Include subfolders',true, "LabelSource' ,'folderNames');
imdsTest.ReadFcn = @ (loc) imresize (imread (loc) , inputSize (1:2)) ;
[Name,probs_1] = classify (modified_net_10mins,imdsTest);
accuracy = sum (Name== imdsTest.Labels)/nume l (imdsTest.Labels);