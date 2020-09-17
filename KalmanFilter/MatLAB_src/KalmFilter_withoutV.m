function [out, err] = KalmFilter_withoutV(x)
      
    param_syst_x = [x(1,1)];   % начальные условия
    param_syst_y = [x(1,2)];   % начальные условия
    
    err_izm_x = [0];
    err_izm_y = [0];
 
    F = [1];
    H = [1];
    rms = 1*10^-2;
    Q = eye(1)*rms^2;
    R = eye(1)*rms^2;
    P_x = {eye(1)*2};
    P_y = {eye(1)*2};
    
    dim = size(x);
    for (i=2:dim(1))
        param_syst_x = [param_syst_x; (F*param_syst_x(i-1,:)')'];
        P_x{i} = F*P_x{i-1}*F'+Q;
        param_syst_y = [param_syst_y; (F*param_syst_y(i-1,:)')'];
        P_y{i}= F*P_y{i-1}*F'+Q;
        
        z_x = [x(i,1)];
        err_izm_x = [err_izm_x; z_x - (H*param_syst_x(i,:)')'];
        S = H*P_x{i-1}*H'+R;
        K = P_x{i-1}*H'*S^-1;
%         K = P_x{i-1}*H'*R^-1;
        param_syst_x(i,:) = param_syst_x(i-1,:)+(K*err_izm_x(i,:)')';
        P_x{i} = (eye(1)-K*H)*P_x{i-1};
        
        z_y = [x(i,2)];
        err_izm_y = [err_izm_y; z_y - (H*param_syst_y(i,:)')'];
        S = H*P_y{i-1}*H'-R;
        K = P_y{i-1}*H'*S^-1;
%         K = P_x{i-1}*H'*R^-1;
        param_syst_y(i,:) = param_syst_y(i-1,:)+(K*err_izm_y(i,:)')';
        P_y{i} = (eye(1)-K*H)*P_y{i-1};
    end
    out = [param_syst_x(:,1),param_syst_y(:,1), x(:,3)];
    err = [err_izm_x(:,1),err_izm_y(:,1)];
    %y = [param_syst_x(:,1),x(:,2), x(:,3)];
end