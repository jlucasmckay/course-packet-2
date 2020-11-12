function h = plot_leg_z(f)
% given a .trc file f, makes a plot of the markers specified in analysis_markers()

% allow to pass the pre-loaded file
if class(f)=="table"
    d = f;
else
    d = read_trc(f);
end

marker_names = names(d);
markers = marker_names(contains(marker_names,analysis_markers()));
t = d.Time;
z = d{:,markers};
h = plot(t,z);
legend(markers);
xlabel("Time, s");
ylabel("Z, mm");
end