function [mse,a,b,c]=MyBPNN(train_inp,train_out)
%---------------------------------------------------------
% MATLAB neural network backprop code
% by Phil Brierley
% www.philbrierley.com
% 29 March 2006
%
% This code implements the basic backpropagation of
% error learning algorithm. The network has tanh hidden  
% neurons and a linear output neuron.
%
% adjust the learning rate with the slider
%
% feel free to improve!
%
%--------------------------------------------------------



%user specified values
hidden_neurons = 3;
hidden2_neurons = 2;
epochs =3000;




% ------- load in the data -------

% XOR data
%train_inp = [1 1; 1 0; 0 1; 0 0];
%train_out = [1; 0; 0; 1];

% check same number of patterns in each
if size(train_inp,1) ~= size(train_out,1)
    disp('ERROR: data mismatch')
   return 
end    

%standardise the data to mean=0 and standard deviation=1
%inputs
mu_inp = mean(train_inp);
sigma_inp = std(train_inp);
train_inp = (train_inp(:,:) - mu_inp(:,1)) / sigma_inp(:,1);

%read how many patterns
patterns = size(train_inp,1);

%add a bias as an input
bias = ones(patterns,1);
train_inp = [train_inp bias];

%read how many inputs
inputs = size(train_inp,2);

%---------- data loaded ------------


%--------- add some control buttons ---------

%add button for early stopping
hstop = uicontrol('Style','PushButton','String','Stop', 'Position', [5 5 70 20],'callback','earlystop = 1;'); 
earlystop = 0;

%add button for resetting weights
hreset = uicontrol('Style','PushButton','String','Reset Wts', 'Position', get(hstop,'position')+[75 0 0 0],'callback','reset = 1;'); 
reset = 0;

%add slider to adjust the learning rate
hlr = uicontrol('Style','slider','value',.1,'Min',.01,'Max',1,'SliderStep',[0.01 0.1],'Position', get(hreset,'position')+[75 0 100 0]);


% ---------- set weights -----------------
%set initial random weights
weight_input_hidden = .5*(randn(inputs,hidden_neurons));
weight_input_hidden2 = .5*(randn(hidden_neurons+1,hidden2_neurons)); %+1 for bias
weight_hidden_output = .5*(randn(1,hidden2_neurons+1)); %+1 for bias


%-----------------------------------
%--- Learning Starts Here! ---------
%-----------------------------------

%do a number of epochs
for iter = 1:epochs
    
    cnt_Cancer=0.001;
    cnt_Normal=0.001;
    cnt_Total=0.002;
    
    %blr=0.2-(0.2-0.001)*iter/epochs;
    blr=0.9;

    %loop through the patterns, selecting randomly
    for j = 1:patterns
        
        %select a random pattern
%         patnum = round((rand * patterns) + 0.5);
%         if patnum > patterns
%             patnum = patterns;
%         elseif patnum < 1
%             patnum = 1;    
%         end
        patnum = j;
        %set the current pattern
        patnum
        this_pat = train_inp(patnum,:);
        act = train_out(patnum,1);
        
        %dlr START
        if act==1
            cnt_Cancer = cnt_Cancer+1;
        else
            cnt_Normal = cnt_Normal+1;
        end
        cnt_Total = cnt_Normal+cnt_Cancer;
        % Normal is major
        if cnt_Cancer <= cnt_Normal
            blr_for_Major = cnt_Cancer/cnt_Total;
            blr_for_Minor = cnt_Normal/cnt_Total;
        % Cancer is major
        else
            blr_for_Major = cnt_Normal/cnt_Total;
            blr_for_Minor = cnt_Cancer/cnt_Total;
        end
        % Normal is major
        blr_init=.2; %.6 / .6
        blr_tuned=.5;
        if cnt_Cancer <= cnt_Normal
            % Cancer case (high LR)
            if act==1
                blr = blr_init+blr_tuned*blr_for_Minor;
            % Normal case (low LR)
            else
                blr = blr_init+blr_tuned*blr_for_Major;
            end
        % Cancer is major
        else
            % Cancer case (low LR)
            if act==1
                blr = blr_init+blr_tuned*blr_for_Major;
            % Normal case (high LR)
            else
                blr = blr_init+blr_tuned*blr_for_Minor;
            end
        end
        %dlr END
    
        
        
        %calculate the current error for this pattern
        %Input-hidden layer 1
        z_sum = (this_pat*weight_input_hidden)'; %((1X4)*(4X3))'
        
%         mu_inp = mean(z_sum);
%         sigma_inp = std(z_sum);
%         z_sum = (z_sum(:,:) - mu_inp(:,1)) / sigma_inp(:,1);
        
        z_j = sigmoid(z_sum);
        z_j = [z_j ; 1.];
        
        %hidden layer1 - hidden layer 2
        z_2_sum = (z_j'*weight_input_hidden2)'; %(4X1)'(4X2)
        
%         mu_inp = mean(z_2_sum);
%         sigma_inp = std(z_2_sum);
%         z_2_sum = (z_2_sum(:,:) - mu_inp(:,1)) / sigma_inp(:,1);
        
        z_2_l = sigmoid(z_2_sum);
        z_2_l = [z_2_l;1.]; %1. for bias %z_2_sum=(3X1)
        
        % hidden2 - output
        o_sum = sigmoid(z_2_l')*weight_hidden_output';
            
        o_k = sigmoid(o_sum);
        error = (act - o_k);

        % back propagate
        % adjust weight hidden - output
        
        %output - hidden2
        delta2 = error.*derivativeOfSigmoid(o_sum);
        delta_v_lk = delta2*blr*z_2_l; %(3X1)
        
        %hidden2 - hidden1
        for uu=1:hidden2_neurons
            deca(uu,1)=derivativeOfSigmoid(z_2_sum(uu,1))*delta2*weight_hidden_output(1,uu);
        end
        delta_w_jl = blr*(z_j*deca'); %(4X2)
        
        %hidden1 - input
        for yy=1:hidden_neurons
            nona(1,yy)= (deca(1,1)*weight_input_hidden2(yy,1)+deca(2,1)*weight_input_hidden2(yy,2))*derivativeOfSigmoid(z_sum(yy,1));
        end
        delta_u_ij = blr*(this_pat'*nona);
        
        weight_input_hidden2 = weight_input_hidden2 + delta_w_jl;
        weight_hidden_output = weight_hidden_output + delta_v_lk';
        weight_input_hidden = weight_input_hidden + delta_u_ij;
   
    end
    % -- another epoch finished
    
    %plot overall network error at end of each epoch
    error = (train_out - o_k);
    err(iter) = (sum(error.^2))/30;
    
    figure(1);
    plot(err)
    
    %reset weights if requested
%     if reset
%         weight_input_hidden = (randn(inputs,hidden_neurons) - 0.5)/10;
%         weight_hidden_output = (randn(1,hidden_neurons) - 0.5)/10;
%         cleafprintf('weights reaset after %d epochs\n',iter);
%         reset = 0;
%     end
    
    %stop if requested
    if earlystop
        fprintf('stopped at epoch: %d\n',iter); 
        break 
    end 

    %stop if error is small
    if 0.154 <= err(iter) & err(iter) <= 0.155 & 100 < iter
        fprintf('converged at epoch: %d\n',iter);
        break 
    end
       
end
mse=err(iter);
a=weight_hidden_output;
b=weight_input_hidden;
c=weight_input_hidden2;
   %-----FINISHED--------- 
   %display actual,predicted & error
%    fprintf('state after %d epochs\n',iter);
%    a = (train_out* sigma_out(:,1)) + mu_out(:,1);
%    b = (pred'* sigma_out(:,1)) + mu_out(:,1);
%    act_pred_err = [a b b-a]
%    
%   
  
