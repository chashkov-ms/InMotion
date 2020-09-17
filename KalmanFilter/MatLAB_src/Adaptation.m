function out = Adaptation(x)

dT = 1;
x_in = x(:,1);
y_in = x(:,2);

r_out = [0];
alpha_out = [0];

v_out = [0];
a_out = [0];
omega_out = [0];
epsilon_out = [0];

dR = [0];
dAlpha = [0];
newX = [0];
newY = [0];

Radius = [0];


learnCoeffR = 2.5;
learnCoeffAlpha = 1.4;
learnCoeffV = 2.5;
learnCoeffA = 2.5;
learnCoeffOmega = 1.4;
learnCoeffEps = 1.4;

learnCoeffCoord = 2;

dim = size(x);
for (i=2:dim(1))
    deltaX = x_in(i)-newX(i-1);
    deltaY = y_in(i)-newY(i-1);
    r_out(i) = r_out(i-1) + (sqrt(deltaX^2+deltaY^2)-r_out(i-1))/learnCoeffR;
    
    ang = angle(deltaX+1i*deltaY);
    deltaAngle = ang-alpha_out(i-1);
    if(abs(deltaAngle) > 2.5)
        ang = ang-sign(deltaAngle)*2*pi();
    end
    deltaAngle = ang-alpha_out(i-1);
    alpha_out(i) = alpha_out(i-1) + deltaAngle/learnCoeffAlpha;
    
    newV = (r_out(i)-r_out(i-1))/dT;
    v_out(i) = v_out(i-1)+ (newV - v_out(i-1))/learnCoeffV;
    
    newA = (v_out(i)-v_out(i-1))/dT;
    a_out(i) = a_out(i-1)+ (newA - a_out(i-1))/learnCoeffA;
    
    newOmega = (alpha_out(i)-alpha_out(i-1))/dT;
    omega_out(i) = omega_out(i-1)+ (newOmega - omega_out(i-1))/learnCoeffOmega;
    
    newEps = (omega_out(i)-omega_out(i-1))/dT;
    epsilon_out(i) = epsilon_out(i-1)+ (newEps - epsilon_out(i-1))/learnCoeffEps;
    
    dR(i) = dR(i-1) + v_out(i)*dT + a_out(i)*dT*dT/2;
    dAlpha(i) = dAlpha(i-1)+ omega_out(i)*dT+epsilon_out(i)*dT*dT/2;
    newX(i) = newX(i-1)+ dR(i)*cos(dAlpha(i))/learnCoeffCoord;
    newY(i) = newY(i-1)+ dR(i)*sin(dAlpha(i))/learnCoeffCoord;
    
end

%out = [newX', newY'];

out = [newX', newY', x(:,3), x(:,4)];

end
