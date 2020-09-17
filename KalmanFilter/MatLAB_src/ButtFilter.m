function out = ButtFilter(x)

x_in = x(:,1);
y_in = x(:,2);
x_out = [x_in(1)];
y_out = [y_in(1)];
Coeff_c = 2.1;

dim = size(x);
for (i=2:dim(1))
    x_out(i) = x_out(i-1)+(x_in(i)-x_out(i-1))/Coeff_c;
    y_out(i) = y_out(i-1)+(y_in(i)-y_out(i-1))/Coeff_c;
end

x_out_2 = [x_out(1)];
y_out_2 = [y_out(1)];
for (i=2:dim(1))
    x_out_2(i) = x_out_2(i-1)+(x_out(i)-x_out_2(i-1))/Coeff_c;
    y_out_2(i) = y_out_2(i-1)+(y_out(i)-y_out_2(i-1))/Coeff_c;
end

out = [x_out_2', y_out_2', x(:,3), x(:,4)];
end
