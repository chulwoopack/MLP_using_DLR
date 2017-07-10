function OutData=Cal_Skewness(Data)

Skewness=0;

n=size(Data);
for i=1:n(2)
    Skewness=Skewness+(Data(i)-mean(Data))^3;
end
OutData=Skewness/((n(2)-1)*(std(Data))^3);
end