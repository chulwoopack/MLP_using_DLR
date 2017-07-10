function OutData=Cal_Kurtosis(Data)

Kurtosis=0;

n=size(Data);
for i=1:n(2)
    Kurtosis=Kurtosis+(Data(i)-mean(Data))^4;
end
OutData=Kurtosis/((n(2)-1)*(std(Data))^4);
end