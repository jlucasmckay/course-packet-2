function make_equal_x(h)
% function make_equal_x(h)
% given a vector of axis handles h, loop through and set them to all have
% equal x

% turn into a column
h = h(:);

% preallocate memory for x, y limits
x = nan(length(h),2);

% loop through and get xlim
for i = 1:length(h)
    x(i,:) = h(i).XLim;
end

% find the min and max values
xl = [min(x(:,1)) max(x(:,2))];

% loop through and set
for i = 1:length(h)
    h(i).XLim = xl;
end

end

