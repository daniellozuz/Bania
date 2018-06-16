clear variables
close all
clc

%% initial values
u_max = 0.2;
u_min = -u_max;
x0 = [0.11; 0.75; 1; 0]; %initial position of first and second robot arm
x_set = [1; 1; 0; 0]; %end position
steps = 100; %steps per switch
t_end = 4.5; %end time
%%
% tau1 = [0.5; 1; 1.5; 2]; %switch time for first arm
% tau2 = [0.5; 1; 1.5; 2];
tau = 0.5:0.5:4;
u1  =[u_max, 0, u_min, 0];
u2 = [0, u_max, 0, u_min];
u = [u1, u1; u2, u2];
ro = 1500;

[RK4_h, ~, ~] = rk4_simul(x0, steps, tau, u, t_end, x_set, ro);
%quality = RK4_multicontrol(tau_u, @dxdt, T, t0, x0, h, x_set, ro)
A = [eye(8); -eye(8)];
b = 4*ones(16,1);
res = fmincon(@(tau)rk4_simul_wrapper(x0, steps, tau, u, t_end, x_set, ro), tau,  A, b);
tau = res;
[~, x, t] = rk4_simul(x0, steps, tau, u, t_end, x_set, ro);
figure(1);
hold on; grid on;
plot(t, x(:,1), 'r');
plot(t, x(:,2));
title('x1(t), x2(t)')
hold off;

figure(2); grid on;
iks = cos(x(1,:)) + cos(x(1,:) + x(2,:));
igrek = sin(x(1,:)) + sin(x(1,:) + x(2,:));
%plot(iks, igrek);
line([0 cos(x(end, 1))], [0 sin(x(end, 1))])
line([cos(x(end, 1)) cos(x(end, 1))+cos(x(end, 1)+x(end, 1))], [sin(x(end, 1)) sin(x(end, 1))+sin(x(end, 1)+x(end, 1))])
title('Position')
axis([-2 2 -2 2])
