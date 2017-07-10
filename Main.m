clear all
close all
clc

for i=14:15
    i
    for j=1:30
        switch i
        case 1
            [test_inp test_out train_inp train_out]=Initializer('1');
        case 2
            [test_inp test_out train_inp train_out]=Initializer('2');
        case 3
            [test_inp test_out train_inp train_out]=Initializer('3');
        case 4
            [test_inp test_out train_inp train_out]=Initializer('4');
        case 5
            [test_inp test_out train_inp train_out]=Initializer('5');
        case 6
            [test_inp test_out train_inp train_out]=Initializer('6');
        case 7
            [test_inp test_out train_inp train_out]=Initializer('7');
        case 8
            [test_inp test_out train_inp train_out]=Initializer('8');
        case 9
            [test_inp test_out train_inp train_out]=Initializer('9');
        case 10
            [test_inp test_out train_inp train_out]=Initializer('10');
        case 11
            [test_inp test_out train_inp train_out]=Initializer('11');
        case 12
            [test_inp test_out train_inp train_out]=Initializer('12');
        case 13
            [test_inp test_out train_inp train_out]=Initializer('13');
        case 14
            [test_inp test_out train_inp train_out]=Initializer('14');
        case 15
            [test_inp test_out train_inp train_out]=Initializer('15'); 
        end
        [MSE,weight_hidden_output,weight_input_hidden,weight_input_hidden2]=MyBPNN(train_inp,train_out);
        [TP TN FP FN] = Recogn([test_inp test_out],weight_hidden_output,weight_input_hidden,weight_input_hidden2);
        Result(j,1)=TP;
        Result(j,2)=TN;
        Result(j,3)=FP;
        Result(j,4)=FN;
        Result(j,5)=TN/(TN+FP);
        Result(j,6)=(TP*TN-FP*FN)/(((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN))^.5);
        Result(j,7)=MSE;
    end    
    i
    xlswrite(strcat('BPNNResult_temp_',num2str(i)),Result);
end

            