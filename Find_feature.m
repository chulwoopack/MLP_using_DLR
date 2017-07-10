function OutData=Find_feature(Data)


x=Data(:,1);
y=Data(:,2);
z=Data(:,3);
per=Data(:,4);
cond=Data(:,5);
class=Data(:,6);

size_of_data=size(Data);
r1=1;
r2=1;

for i=1:size_of_data(1)
    if class(i)>1
        Tumor_x(r1)=x(i);
        Tumor_y(r1)=y(i);
        Tumor_z(r1)=z(i);
        Tumor_per(r1)=per(i);
        Tumor_cond(r1)=cond(i);
        r1=r1+1;
    else
        Healthy_x(r2)=x(i);
        Healthy_y(r2)=y(i);
        Healthy_z(r2)=z(i);
        Healthy_per(r2)=per(i);
        Healthy_cond(r2)=cond(i);
        r2=r2+1;
    end
end    

HealthyRate = r1/(r1+r2);
TumorRate = r2/(r1+r2);

Max_Healthy=max(Healthy_per);
Min_Healthy=min(Healthy_per);
Mean_Healthy=mean(Healthy_per);
Std_Healthy=std(Healthy_per);
Var_Healthy=cov(Healthy_per);
Energy_Healthy=Cal_Energy(Healthy_per);
Entropy_Healthy=Cal_Entropy(Healthy_per);
Skewness_Healthy=Cal_Skewness(Healthy_per);
Kurtosis_Healthy=Cal_Kurtosis(Healthy_per);

Max_Healthy_cond=max(Healthy_cond);
Min_Healthy_cond=min(Healthy_cond);
Mean_Healthy_cond=mean(Healthy_cond);
Std_Healthy_cond=std(Healthy_cond);
Var_Healthy_cond=cov(Healthy_cond);
Energy_Healthy_cond=Cal_Energy(Healthy_cond);
Entropy_Healthy_cond=Cal_Entropy(Healthy_cond);
Skewness_Healthy_cond=Cal_Skewness(Healthy_cond);
Kurtosis_Healthy_cond=Cal_Kurtosis(Healthy_cond);    



Max_Tumor=max(Tumor_per);
Min_Tumor=min(Tumor_per);
Mean_Tumor=mean(Tumor_per);
Std_Tumor=std(Tumor_per);
Var_Tumor=cov(Tumor_per);
Energy_Tumor=Cal_Energy(Tumor_per);
Entropy_Tumor=Cal_Entropy(Tumor_per);
Skewness_Tumor=Cal_Skewness(Tumor_per);
Kurtosis_Tumor=Cal_Kurtosis(Tumor_per);    

Max_Tumor_cond=max(Tumor_cond);
Min_Tumor_cond=min(Tumor_cond);
Mean_Tumor_cond=mean(Tumor_cond);
Std_Tumor_cond=std(Tumor_cond);
Var_Tumor_cond=cov(Tumor_cond);
Energy_Tumor_cond=Cal_Energy(Tumor_cond);
Entropy_Tumor_cond=Cal_Entropy(Tumor_cond);
Skewness_Tumor_cond=Cal_Skewness(Tumor_cond);
Kurtosis_Tumor_cond=Cal_Kurtosis(Tumor_cond);

Max_Total=max(per);
Min_Total=min(per);
Mean_Total=mean(per);
Std_Total=std(per);
Var_Total=cov(per);
Energy_Total=Cal_Energy(per);
Entropy_Total=Cal_Entropy(per);
Skewness_Total=Cal_Skewness(per);
Kurtosis_Total=Cal_Kurtosis(per);

Max_Total_cond=max(cond);
Min_Total_cond=min(cond);
Mean_Total_cond=mean(cond);
Std_Total_cond=std(cond);
Var_Total_cond=cov(cond);
Energy_Total_cond=Cal_Energy(cond);
Entropy_Total_cond=Cal_Entropy(cond);
Skewness_Total_cond=Cal_Skewness(cond);
Kurtosis_Total_cond=Cal_Kurtosis(cond);
%OutData=[Max_Healthy Max_Tumor Mean_Healthy Mean_Tumor Std_Healthy Std_Tumor Var_Healthy Var_Tumor Energy_Healthy Energy_Tumor Entropy_Healthy Entropy_Tumor Skewness_Healthy Skewness_Tumor Kurtosis_Healthy Kurtosis_Tumor];

%OutData=[Max_Total Min_Total Std_Total Energy_Total Entropy_Total Max_Total_cond Min_Total_cond Std_Total_cond Energy_Total_cond Entropy_Total_cond HealthyRate TumorRate];
%OutData=[Max_Healthy Min_Healthy Std_Healthy Entropy_Healthy HealthyRate]; %Good one
%OutData=[Max_Total_cond Min_Total_cond Max_Total Min_Total Energy_Total Energy_Total_cond Std_Total Std_Total_cond];

%option1
%OutData=[Mean_Healthy_cond Energy_Healthy_cond Mean_Tumor Std_Tumor HealthyRate TumorRate];
%option2
OutData=[Max_Healthy_cond HealthyRate TumorRate];
%All feature
%OutData=[Max_Healthy Min_Healthy Mean_Healthy Std_Healthy Var_Healthy Energy_Healthy Entropy_Healthy Skewness_Healthy Kurtosis_Healthy Max_Healthy_cond Min_Healthy_cond Mean_Healthy_cond Std_Healthy_cond Var_Healthy_cond Energy_Healthy_cond Entropy_Healthy_cond Skewness_Healthy_cond Kurtosis_Healthy_cond Max_Tumor Min_Tumor Mean_Tumor Std_Tumor Var_Tumor Energy_Tumor Entropy_Tumor Skewness_Tumor Kurtosis_Tumor Max_Tumor_cond Min_Tumor_cond Mean_Tumor_cond Std_Tumor_cond Var_Tumor_cond Energy_Tumor_cond Entropy_Tumor_cond Skewness_Tumor_cond Kurtosis_Tumor_cond Mean_Total Var_Total Skewness_Total Kurtosis_Total Mean_Total_cond Var_Total_cond Skewness_Total_cond Kurtosis_Total_cond Max_Total Min_Total Std_Total Energy_Total Entropy_Total Max_Total_cond Min_Total_cond Std_Total_cond Energy_Total_cond Entropy_Total_cond HealthyRate TumorRate];
end