function h = plot_leg_z_histogram(f)
% given a .trc file f, makes a plot of the markers specified in analysis_markers()
if class(f)=="table"
    d = f;
else
    d = read_trc(f);
end

marker_names = names(d);
markers = marker_names(contains(marker_names,analysis_markers()));
t = d.Time;
z = d{:,markers};
h = gobjects(size(z,2),1);
for i = 1:size(z,2)
    h(i) = histogram(z(:,i));
    hold on
    h(i).Normalization = 'probability';
end
legend(markers);
xlabel("Z, mm");
end