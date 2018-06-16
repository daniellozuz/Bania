function [ quality ] = rk4_simul_wrapper(x0, steps, tau, u, t_end, x_set, ro)
    [quality, ~, ~] = rk4_simul(x0, steps, tau, u, t_end, x_set, ro);
end
