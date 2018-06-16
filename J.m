function J = J(T, x_end, x_set, ro, tau)
    J = T + 1/2.* ro * sum((x_set' - x_end).^2);
    disp(J)
    prev_t = 0;
    disp(tau)
    for t=tau
        if t < prev_t
            J = J + 10000000;
        end
        prev_t = t;
    end
    disp(J)
end
