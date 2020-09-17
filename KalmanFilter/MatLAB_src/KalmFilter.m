function [out, err] = KalmFilter(x)

    dT = 0.1;                   % time step f = 10 Hz
    v0_x = 0;
    v0_y = 0;
    
    param_syst = [x(1,1), x(1,2), v0_x, v0_y];   % начальные условия
        
    err_izm = [0, 0];
     
    F = [1, 0, dT, 0; 0, 1, 0, dT; 0, 0, 1, 0; 0, 0, 0, 1];
    H = [1, 0, 0, 0; 0, 1, 0, 0];
    rms_XY = 1*10^-3;
    rms_V = rms_XY/dT;
    R = eye(2)*rms_XY;
    Q = [rms_XY^2, 0, rms_XY*rms_V, 0; 0, rms_XY^2, 0, rms_XY*rms_V; 0, 0, rms_V^2, 0; 0, 0, 0, rms_V^2];
    P = {eye(4)*100};
    
    dim = size(x);
    for (i=2:dim(1))
        param_syst = [param_syst; (F*param_syst(i-1,:)')'];
        P{i} = F*P{i-1}*F'+Q;
        
        z = [x(i,1), x(i,2)];
        err_izm = [err_izm; z - (H*param_syst(i,:)')'];
        S = H*P{i-1}*H'+R;
        K = P{i-1}*H'*S^-1;
%         K = P_x{i-1}*H'*R^-1;
        param_syst(i,:) = param_syst(i-1,:)+(K*err_izm(i,:)')';
        P{i} = (eye(4)-K*H)*P{i-1};
        
    end
    out = [param_syst(:,1),param_syst(:,2), x(:,3)];
    err = [err_izm(:,1),err_izm(:,2)];
end