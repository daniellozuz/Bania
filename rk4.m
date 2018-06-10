function [t, x] = rk4(x0, u, T, dt)
    %% initial values
    t = 0:dt:T;
    steps = length(t);
    x = zeros(steps, 4);
    x(1,:) = x0; % initialize with value

    %% rk4
    for i = 1:steps-1
        k1 = dt*f(x(i,:), u);
        k2 = dt*f(x(i,:)+0.5*k1, u);
        k3 = dt*f(x(i,:)+0.5*k2, u);
        k4 = dt*f(x(i,:)+k3,     u);

        dx = (k1 + 2*k2 + 2*k3 + k4)/6;
        x(i+1,:) = x(i,:) + dx;
    end
end