function make_equal_xy(h)
% function make_equal_xy(h)
% given a vector of axis handles h, loop through and set them to all have
% equal xy

% turn into a column
h = h(:);

% preallocate memory for x, y limits
[x,y] = deal(nan(length(h),2));

% loop through and get xlim, ylim
for i = 1:length(h)
    x(i,:) = h(i).XLim;
    y(i,:) = h(i).YLim;
end

% find the min and max values
xl = [min(x(:,1)) max(x(:,2))];
yl = [min(y(:,1)) max(y(:,2))];

% loop through and set
for i = 1:length(h)
    h(i).XLim = xl;
    h(i).YLim = yl;
end

end

