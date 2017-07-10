function p = derivativeOfSigmoid(x)
% Sigmoid function: s(x) = 1 / (1+exp(-x))

% This file is from pmtk3.googlecode.com

p = (exp(-x))./((1+exp(-x)).^2);
end