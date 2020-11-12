function out = estimate_trc_spectrum(f)

7+3

d = read_trc(f);

% delta t, seconds
dt = d.Time(2)-d.Time(1);

% sample rate, Hz
fs = 1/dt;

marker_names = names(d);
markers = marker_names(contains(marker_names,analysis_markers()));
t = d.Time;
z = d{:,markers};

end