function t = read_trc_header(f)
% function t = read_trc_header(f)
% 
% returns the text in the first line of a .trc file
fid = fopen(f);
t = fgetl(fid);
fclose(fid);
end