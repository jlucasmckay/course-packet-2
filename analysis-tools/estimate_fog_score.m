function s = estimate_fog_score(f)

if class(f)=="table"
    d = f;
else
    d = read_trc(f);
end

marker_names = names(d);
markers = marker_names(contains(marker_names,analysis_markers()));
t = d.Time;
z = d{:,markers};

s = nan;
end