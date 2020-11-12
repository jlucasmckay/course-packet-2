function make_equal_y(h)
% function make_equal_y(h)
% given a vector of axis handles h, loop through and set them to all have
% equal y

% turn into a column
h = h(:);

% preallocate memory
y = nan(length(h),2);

% loop through and get xlim
for i = 1:length(h)
    y(i,:) = h(i).YLim;
end

% find the min and max values
yl = [min(y(:,1)) max(y(:,2))];

% loop through and set
for i = 1:length(h)
    h(i).YLim = yl;
end

end

