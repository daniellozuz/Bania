function result = f(x, u)

%% parametry
I = [1, 1];
m = [10, 0];
d = [1, 1];
xc = [0.5, 0.5];
yc = [0, 0];
s = [0.1, 0.1];
ff = [0.01, 0.01];

u_min = -1;
if (any(u < u_min))
    display('Some elements of control lower than -1');
end
u_max = 1;
if (any(u > u_max))
    display('Some elements of control greater than 1');
end

%x0 = [0.35 ; 1.6062; 0; 0];
%x_end = [1.7 ; 0];

% Rownania
B = m(2)*d(1)*(xc(2)*cos(x(2))-yc(2)*sin(x(2)));
M = [ I(1)+I(2)+m(2)*d(1).^2+2*B, B;
    B, I(2)];
M_odw = (1/(M(1,1)*M(2,2)-M(1,2).^2))*[M(2,2) -M(1,2); -M(1,2) M(1,1)];

kt = 0.1;
T1 = s(1)*tanh(kt*x(3)) + ff(1) * x(3);
T2 = s(2)*tanh(kt*x(4)) + ff(2) * x(4);

V1 = B * (2*x(3)*x(4)+x(4)^2);
V2 = -B * x(3)^2;

%% x' = f(0) + u1*g1(x) + u2*g2(x)

f0x = [x(3);
    x(4);
    -M_odw(1, 1)*(V1+T1)-M_odw(1, 2)*(V2+T2);
    -M_odw(1, 2)*(V1+T1)-M_odw(2, 2)*(V2+T2)];

g1 = [0;0; M_odw(1, 1); M_odw(1, 2)];
g2 = [0;0;M_odw(1,2); M_odw(2,2)];

result = f0x + u(1)*g1 + u(2)*g2;
result = result';
end