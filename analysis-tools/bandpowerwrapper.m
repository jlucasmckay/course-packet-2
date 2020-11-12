function output = bandpowerwrapper(x,Fs,Frange,Nsamp)

if nargin<4
    Nsamp = 100;
end

if nargin<3
    Frange = [];
end

[prop,output] = deal(nan(size(x)));

% calculate the power in the frequency band of interest as a proportion of the
% total power
for i = 1:(length(x)-(Nsamp-1))
    inds = i:(i+Nsamp-1);
    xdata = x(inds);
    ptot = bandpower(xdata,Fs,[0 Fs/2]);
    pband = bandpower(xdata,Fs,Frange);
    prop(i) = pband/ptot;
end

% smooth with Savitsky-Golay
frameLen = Nsamp;
% ensure frame length is odd
if ~mod(frameLen,2)
    frameLen = frameLen+1;
end

% frameLen is ~250
[~,g] = sgolay(5,frameLen);
dt = 1/Fs;
p = 0;
output = conv(prop, factorial(p)/(-dt)^p * g(:,p+1), 'same');

end