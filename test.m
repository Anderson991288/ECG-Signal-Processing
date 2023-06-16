%´ú¸Õ°V½mµ²ªG
% testimagepath = fullfile('gray data-900-w over','testing 4type');
% imdsTest = imageDatastore(testimagepath, 'IncludeSubfolders',true, 'LabelSource','folderNames');
imdsTest.ReadFcn = @(loc)imresize(imread(loc),inputSize(1:2));
[Name,probs_1] = classify(modified_net_10mins,imdsTest);
accuracy = sum(Name == imdsTest.Labels)/numel(imdsTest.Labels);

N = 1000; % Number of Testing data
% 
% % LF = imdsTest.Labels(1:160,1);
% LN = imdsTest.Labels(1:1000,1);
% LQ = imdsTest.Labels(1001:2000,1);
% LS = imdsTest.Labels(2001:2540,1);
% LV = imdsTest.Labels(2541:3540,1);
% 
% % TF = Name(1:160,1);
% TN = Name(1:1000,1);
% TQ = Name(1001:2000,1);
% TS = Name(2001:2540,1);
% TV = Name(2541:3540,1);
% 
% % AN = sum(LN == TN)/numel(LN);
% AQ = sum(LQ == TQ)/numel(LQ);
% AS = sum(LS == TS)/numel(LS);
% AV = sum(LV == TV)/numel(LV);
% AF = sum(LF == TF)/numel(LF);

plotconfusion(imdsTest.Labels,Name);

