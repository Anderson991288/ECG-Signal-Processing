imagepath = fullfile('gray scale-3600','training');
imds = imageDatastore(imagepath, 'IncludeSubfolders',true, 'LabelSource','folderNames');


net = restnet18;


try
   inputSize = net(1).InputSize; 
catch
   inputSize = net.Layers(1).InputSize; 
end

imds.ReadFcn = @(loc)imresize(imread(loc),inputSize(1:2)); 


[trainDS,valDS] = splitEachLabel(imds,0.7,0.3, 'randomized');