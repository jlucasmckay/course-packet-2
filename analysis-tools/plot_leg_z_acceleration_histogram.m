function h = plot_leg_z_acceleration_histogram(f)

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

zdot = sgolayderiv(z,t);
zddot = abs(sgolayderiv(zdot,t));
percent_frozen = calculate_percent_frozen(d);

h = gobjects(size(z,2),1);
for i = 1:size(z,2)
    h(i) = histogram(zddot(:,i));
    hold on
    h(i).Normalization = 'probability';
end

legend(markers);
xlabel("d2 Z/ dt2, mm/s2");
title("% Frozen: "+percent_frozen);

end