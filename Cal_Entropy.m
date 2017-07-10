function OutData=Cal_Entropy(Data)

Entropy=0;

n=size(Data);
for i=1:n(2)
    Entropy=Entropy+Data(i)*log(Data(i));
end
OutData=Entropy/n(2);
end