function OutData=Remove_liq_oneData(filename)

load(filename)

size_of_data=size(Epsi_C);

r=1;
for i=1:688:size_of_data(1)
    k=0;
    for j=1:687
        if ((Epsi_C(i+j)-Epsi_C(j+i-1))>0.01)
           k=1;
        end
    end
    if (k==1)
        FirstOut(r:r+687,:)= [cnode(i:i+687,:) Epsi_C(i:i+687,:) Sigm_C(i:i+687,:)];
        r=r+688;
    end
    
end
r=1;
size_of_data=size(FirstOut);
for i=1:size_of_data(1)
   if ((FirstOut(i,1)^2+FirstOut(i,2)^2)^.5<.07)  %max=.069
       OutData(r,:)=FirstOut(i,:);
       r=r+1;
   end      
end

%OutData=FirstOut;
end