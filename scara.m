clear variables
close all
clc

%% initial values
u_max = 1;
u_min = -u_max;
x0 = [0.35; 1.6062; 0.3; 0]; %initial position of first and second robot arm
x_set = [1.7; 0; 0; 0]; %end position
steps = 100; %steps per switch
t_end = 6.5; %end time
%%
% tau1 = [0.5; 1; 1.5; 2]; %switch time for first arm
% tau2 = [0.5; 1; 1.5; 2];
tau = 0.5:0.5:6;
u1  =[u_max, 0, u_min, 0];
u2 = [0, u_max, 0, u_min];
u = [u1, u1, u1; u2, u2, u2];
ro = 1500;

[RK4_h, ~, ~] = rk4_simul(x0, steps, tau, u, t_end, x_set, ro);
%quality = RK4_multicontrol(tau_u, @dxdt, T, t0, x0, h, x_set, ro)
A = [-eye(12) + diag(ones(1,11), -1)];%; -eye(8)+ diag(ones(1,7), -1)];
A = [A; zeros(1,11), 1];
b = [zeros(12,1); t_end];
%b = ones(16,1);
% b = ones(1, 16);
res = fmincon(@(tau)rk4_simul_wrapper(x0, steps, tau, u, t_end, x_set, ro), tau,  A, b);
tau = res;
[~, x, t] = rk4_simul(x0, steps, tau, u, t_end, x_set, ro);
figure(1);
hold on; grid on;
plot(t, x(:,1), 'r');
plot(t, x(:,2));
title('SCARA arms positions')
legend('Position x1(t)', 'Position x2(t)');
hold off;
u1_end = [u1,u1,u1];
u2_end = [u2,u2,u2];
xlabel('Time [s]');
ylabel('Position [rad]')

figure(2); grid on;
iks = cos(x(1,:)) + cos(x(1,:) + x(2,:));
igrek = sin(x(1,:)) + sin(x(1,:) + x(2,:));
%plot(iks, igrek);
line([0 cos(x(end, 1))], [0 sin(x(end, 1))])
line([cos(x(end, 1)) cos(x(end, 1))+cos(x(end, 1)+x(end, 1))], [sin(x(end, 1)) sin(x(end, 1))+sin(x(end, 1)+x(end, 1))])
title('Position')
axis([-2 2 -2 2])

figure(3); grid on;
stairs(tau,u1_end,'r');
hold on;
stairs(tau,u2_end,'b');
axis([0,4,-0.25,1.25]);
title('Control signals');
xlabel('Time [s]');
ylabel('Control []');
legend('u1', 'u2');
