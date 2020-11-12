function s = calculate_percent_frozen(f)

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
s = apply_freeze_thresh(zddot);

end