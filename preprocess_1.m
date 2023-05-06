clc;close all; 
% 抓data
imagepath = fullfile('gray scale_3-400','5TYPE');
imds = imageDatastore(imagepath, 'IncludeSubfolders',true, 'LabelSource','folderNames');

% 選擇網路
net = Alexnet;

% get InputSize
try
   inputSize = net(1).InputSize; 
catch
   inputSize = net.Layers(1).InputSize; 
end


% 調整影像大小
imds.ReadFcn = @(loc)imresize(imread(loc),inputSize(1:2)); 

% imds = shuffle(imds);

% 把data分類training,testing
[trainDS1,imdsTest] = splitEachLabel(imds,0.8,0.2, 'randomized');

% 把data分類training,val
[trainDS2,valDS] = splitEachLabel(trainDS1,0.8,0.2, 'randomized');

% 把data分類training,val
% [trainDS,valDS] = splitEachLabel(imds,0.8,0.2, 'randomized');