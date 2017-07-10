function [test_inp test_out train_inp train_out] = Initializer(datasetNo)

myString=strcat('mydataset',datasetNo);
myFunc=str2func(myString);
[x T]=myFunc();
InData=[x T'];

numOfFeature=size(InData);
x=InData(:,1:numOfFeature(2)-1);
T=InData(:,numOfFeature(2));
Dataset = x';
T=T';

inputs = Dataset;
for i=1:numOfFeature(1)
    for j=1:numOfFeature(2)-1
        normalize(j,i)=(inputs(j,i)-min(inputs(j,:)))/(max(inputs(j,:))-min(inputs(j,:)));
    end
end
%normalize=(inputs-min(min(inputs)))/(max(max(inputs))-min(min(inputs)));
inputs=normalize;
targets = T;

train_inp = inputs';
train_out = targets';

test_inp = train_inp(21:30,:);
test_out = train_out(21:30,:);

train_inp = train_inp(1:20,:);
train_out = train_out(1:20,:);