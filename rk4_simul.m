function [ quality, x, t ] = rk4_simul(x0, steps, tau, u, t_end, x_set, ro)    
%     u1min = -0.1;
%     u1max = -u1min;
%     u2min = u1min;
%     u2max = u1max;
%     u1 = u1min;                    %warto�� pocz�tkowa sterowania 1
%     u2 = u2max;
%     
%     u1_idx = 1;
%     u2_idx = 1;
    
    new_x0 = x0;
    tau = [0, tau];
    
    x = [];
    t = [];
    
    for i=1:length(tau)-1
       T  = tau(i+1) - tau(i);
       n  = ceil(T*steps);
       dt = T/n;
       
       [x_temp, t_temp] = rk4(new_x0, u(:,i), T, dt);
       t_temp = t_temp + tau(i);
       
       x = [x; x_temp(2:end,:)];
       t = [t t_temp(2:end)];
       
       x0 = x(end,:)'
    end
    
%     while (u1_idx<=length(u1_sw_vec) || u2_idx<=length(u2_sw_vec))
%         %new endtime tf is determinated by quicked switch time from any arm
%         tf = u1_sw_vec(u1_idx)*(u1_sw_vec(u1_idx)<=u2_sw_vec(u2_idx)) + u2_sw_vec(u2_idx)*(u1_sw_vec(u1_idx)>u2_sw_vec(u2_idx));
%         T  = tf - t0; %duration of step
%         n  = ceil(T*steps); %number of steps
%         u = [u1*ones(n,1) u2*ones(n,1)];
%         
%         dt = T/n; %small step duration
%         [t_tmp, x_tmp] = rk4(x0,u,T,dt);
%         x_tmp();
%         t_tmp();
%         x = [x; x_tmp(2:end,:)];
%         if(~isempty(t) > 0)
%             t = [t, t_tmp(2:end) + t(end)];
%         else 
%             t = [t, t_tmp(2:end)];
%         end
%         
%         x0 = x(end,:)'
%         t0 = tf;
%                 
%         if(u1_sw_vec(u1_idx)<u2_sw_vec(u2_idx))
%             %u1 = -u1;
%             u1 = u1min*(u1 == u1max) + u1max*(u1 == u1min);
%             u1_idx = u1_idx + 1;
%         elseif(u1_sw_vec(u1_idx)>u2_sw_vec(u2_idx))
%             %u2 = -u2;
%             u2 = u2min*(u2 == u2max) + u2max*(u2 == u2min);
%             u2_idx = u2_idx + 1;
%         else
%             %u1 = -u1;
%            % u2 = -u2;
%             u1 = u1min*(u1 == u1max) + u1max*(u1 == u1min);
%             u2 = u2min*(u2 == u2max) + u2max*(u2 == u2min);
%             u1_idx = u1_idx + 1;
%             u2_idx = u2_idx + 1;
%         end
%         if(u1_idx > length(u1_sw_vec))
%             break;
%         end        
%     end
    x(end,:)
    quality = J(t(end), x(end,:), x_set, ro);
end
