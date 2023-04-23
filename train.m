net = ResNet18;
opts = trainingOptions ('sgdm
	'MiniBatchsize', 20,
	'MaxEpochs',20, ...
	'Shuffle', 'every-epoch'
	"InitialLearnRate',0.001
	'ValidationData', valDS,..
	"Plots",'training-progress'
	'ValidationPatience', 3, 'ExecutionEnvironment', 'gpu');
	
	
	modified net 10mins = trainNetwork (trainDs, net, opts);