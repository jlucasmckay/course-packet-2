function xdot = sgolayderiv(x,t,order,framelen)
% function xdot = sgolayderiv(x,t,order,framelen)
% function xdot = sgolayderiv(x,t)
% 
% smoothing derivative implemented from example in header of sgolay.m

if nargin<4
    framelen=25;
end
if nargin<3
    order=5;
end

[~,g] = sgolay(order,framelen);
xdot = zeros(size(x));
dt = t(2)-t(1);
p = 1;
for i = 1:size(xdot,2)
    xdot(:,i) = conv(x(:,i), factorial(p)/(-dt)^p * g(:,p+1), 'same');
end

% zero out one framelen on each end of the signal
xdot(1:framelen,:) = 0;
xdot((end-framelen):end,:) = 0;
    
end
