clc;close all; 
% ��data
imagepath = fullfile('gray scale_3-400','5TYPE');
imds = imageDatastore(imagepath, 'IncludeSubfolders',true, 'LabelSource','folderNames');

% ��ܺ���
net = Alexnet;

% get InputSize
try
   inputSize = net(1).InputSize; 
catch
   inputSize = net.Layers(1).InputSize; 
end


% �վ�v���j�p
imds.ReadFcn = @(loc)imresize(imread(loc),inputSize(1:2)); 

% imds = shuffle(imds);

% ��data����training,testing
[trainDS1,imdsTest] = splitEachLabel(imds,0.8,0.2, 'randomized');

% ��data����training,val
[trainDS2,valDS] = splitEachLabel(trainDS1,0.8,0.2, 'randomized');

% ��data����training,val
% [trainDS,valDS] = splitEachLabel(imds,0.8,0.2, 'randomized');