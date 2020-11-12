function h = plot_jitter(data,xname,yname,colorname,markername,jitterx,jittery)
% function h = plot_jitter(data,xname,yname,colorname,markername,jitterxamt,jitteryamt)
%
% expects a table "data" with columns specified by strings xname, yname, colorname, markername.
% colorname and markername can be supplied as []
% jitterxamt and jitteryamt are numerical values for jitter added to points.
% default is 0.2 for x and 0.0 for y.

if nargin<7||isempty(jittery)
    jittery=0;
end
if nargin<6||isempty(jitterx)
    jitterx=0.2;
end
if nargin<5||isempty(markername)
    m = ones(size(data,1),1);
else
    m = data{:,markername};
end
if nargin<4||isempty(colorname)
    c = ones(size(data,1),1);
else
    c = data{:,colorname};
end

x = data{:,xname};
y = data{:,yname};

nc = length(unique(c));
nm = length(unique(m));

% mmap only supported up to six
cmap = get(0, 'DefaultAxesColorOrder');
mmap = ["o" "+" "^" "v" "." "*"];

% preallocate space for object handles and legend entries
h = gobjects(nc*nm,1);
l = strings(nc*nm,1);

hold on
counter = 0;
mvals = unique(m);
cvals = unique(c);
for mi = 1:nm
    marker = mmap(mi);
    for ci = 1:nc
        color = cmap(ci,:);
        counter = counter+1;
        h(counter) = jitter_sub(x(c==cvals(ci)&m==mvals(mi)),y(c==cvals(ci)&m==mvals(mi)));
        add_legend_entry();
    end
end
legend(l);

    function add_legend_entry()
        if nm==1
            l(counter) = cvals(ci);
        elseif nc==1
            l(counter) = mvals(mi);
        else
            l(counter) = cvals(ci) + "; " + mvals(mi);
        end
    end

    function h = jitter_sub(x,y)
        if class(x)=="string"
            [xnum,xlab] = grp2idx(x);
            xt = unique(xnum);
        else
            xnum = x;
        end
        if class(y)=="string"
            [ynum,ylab] = grp2idx(y);
            yt = unique(ynum);
        else
            ynum = y;
        end
        xnum = xnum + [rand(size(xnum))-0.5]*jitterx;
        ynum = ynum + [rand(size(ynum))-0.5]*jittery;
        h = plot(xnum,ynum,'.','MarkerSize',5,'Marker',marker,'Color',color);
        if class(x)=="string"
            xticks(xt);
            xticklabels(xlab);
        end
        if class(y)=="string"
            yticks(yt);
            yticklabels(ylab);
        end
    end

end

