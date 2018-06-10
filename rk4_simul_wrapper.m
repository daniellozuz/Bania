function [ quality ] = rk4_simul_wrapper(x0, steps, tau1, tau2, t_end, x_set, ro)
    [quality, ~, ~] = rk4_simul(x0, steps, tau1, tau2, t_end, x_set, ro);
end
