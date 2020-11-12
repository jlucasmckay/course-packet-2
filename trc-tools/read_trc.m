function data = read_trc(varargin)
% function data = read_trc(varargin)

p = inputParser;
p.addOptional('fileName', "sample.trc", @(x) validateattributes(x,["string", "char"],"scalartext"))
p.addOptional('nMarkers', 60, @(x) validateattributes(x,"numeric","integer"));
p.CaseSensitive = false;
p.parse(varargin{:});

% if default was specified, direct to sample file
fileName = regexprep(p.Results.fileName,"^default$","sample.trc");

% specify number of markers
nMarkers = p.Results.nMarkers;

% load raw data - specify that the variable names are located on line 4 of
% the data file.
opts = detectImportOptions(fileName,'FileType','text');
opts.VariableNamesLine = 4;
% specify that the data are numeric - if there are missing data at the
% start of the recording matlab may cast as char.
opts.VariableTypes = repmat({'double'},1,length(opts.VariableTypes));
data = readtable(fileName,opts);

frameTime = data(:,1:2);
markers = data(:,3:end);

% there is an X, Y, Z specified for each marker coordinate. if there are
% fewer than nMarkers recorded, take the minimum.
nColumns = min(nMarkers*3,ncol(markers));

markers = markers(:,1:nColumns);

% you can say "peek(markers)" to have a look at this without overwhelming the terminal

% the markers are arranged in X/Y/Z order, but only the X coordinates are
% named. there are placeholder names for the other coordinates.
xnames = names(markers(1,1:3:end)) + "_X";
ynames = names(markers(1,1:3:end)) + "_Y";
znames = names(markers(1,1:3:end)) + "_Z";

markers.Properties.VariableNames = asColumn([xnames ynames znames]');

frameTime.Properties.VariableNames = strrep(names(frameTime),"_","");

data = [frameTime markers];

% add some useful metadata as "custom properties" to the table
data = addprop(data, ...
    ["frameMin", "frameMax", "timeMinSec", "timeMaxSec", "deltaTSec", "sampleRateHz"],...
    ["table", "table", "table", "table", "table", "table"]);

data.Properties.CustomProperties.frameMin = min(data.Frame);
data.Properties.CustomProperties.frameMax = max(data.Frame);
data.Properties.CustomProperties.timeMinSec = min(data.Time);
data.Properties.CustomProperties.timeMaxSec = max(data.Time);
data.Properties.CustomProperties.deltaTSec = (data.Time(2)-data.Time(1));
data.Properties.CustomProperties.sampleRateHz = 1/(data.Time(2)-data.Time(1));

end


