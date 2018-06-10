function J = J(T, x_end, x_set, ro)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    J = T + 1/2.* ro * sum((x_set' - x_end).^2); 
end

