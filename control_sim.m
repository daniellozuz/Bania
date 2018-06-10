function [t, x] = control_sim(tau, u, T, t0, x0, h, x_set, x_delta)

    x = x0;
    t = 0;
    tau = [0, tau];
    u = [[0; 0], u];
    
    for j = 1:length(tau)-1
        [t_temp, x_temp] = rk4(@f, tau(1, j+1), tau(1,j), x(:, end), h, u(1:2, j), x_delta);
        t = [t, t_temp(2:end)];
        x = [x, x_temp(:, 2:end)];
    end
    [t_temp, x_temp] = rk4(@f, T, tau(1, end), x(:, end), h, u(1:2, end), x_delta);
    t = [t, t_temp(2:end)];
    x = [x, x_temp(:, 2:end)];
end