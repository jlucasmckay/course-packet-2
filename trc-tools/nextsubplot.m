function i = nextsubplot(varargin)
% function subplotnum = nextsubplot(figure_handle)
% 
% function subplotnum = nextsubplot() is the same as nextsubplot(gcf)
% 
% J. Lucas McKay, Ph.D. 9 October 2012
% 
% Gives you a handle to the next subplot number on a figure. So, if you
% want a lot of subplots you can say
% 
% nrows = 4;
% ncols = 2;
% 
% figure
% 
% subplot(nrows,ncols,nextsubplot())
% ...plotting commands...

if nargin==1
    h = varargin{1};
else
    h = gcf;
end

if isempty(h);
    h = gcf;
end

existingsubplots = get(gcf,'children');
if isempty(existingsubplots)
    i = 1;
else
    i = length(existingsubplots)+1;
end

end