function h = plot_leg_z_acceleration(f)
% function h = plot_leg_z_acceleration(f)
% function h = plot_leg_z_acceleration(d)
% given a .trc file f (or a pre-loaded file d), makes a plot of the acceleration of markers specified in analysis_markers()

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
zddot = sgolayderiv(zdot,t);
    
h = plot(t,zddot);

legend(markers);
xlabel("Time, s");
ylabel("d2 Z/ dt2, mm/s2");

end