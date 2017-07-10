function OutData=Cal_Energy(Data)

Energy=0;

n=size(Data);
for i=1:n(2)
    Energy=Energy+Data(i)^2; 
end

OutData=Energy/n(2);
end