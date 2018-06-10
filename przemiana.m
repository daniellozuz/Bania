
% Wczesniejsze rzeczy
B = m(2)*d(1)*(xc(2)*cos(x(2))-yc(2)*sin(x(2)));
M = [ I(1)+I(2)+m(2)*d(1).^2+2*B, B;
    B, I(2)];
M_odw = (1/(M(1,1)*M(2,2)-M(1,2).^2))*[M(2,2) -M(1,2); -M(1,2) M(1,1)];

% Nowe rzeczy
T1 = s1*tanh(kt*x(3)) + f1 * x(3);
T2 = s2*tanh(kt*x(4)) + f2 * x(4);

V1 = Bx2 * (2*x(3)*x(4)+x(4)^2);
V2 = -Bx2 * x(3)^2;

result = [x(3);
    x(4);
    -M_odw(1, 1)*(V1+T1)-M_odw(1, 2)*(V2+T2);
    -M_odw(1, 2)*(V1+T1)-M_odw(2, 2)*(V2+T2)];
