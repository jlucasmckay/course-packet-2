% testing_code.m

close all
clear all

% add the directory of helper functions to the path. note that addpath
% checks for duplicates before appending, so this is only done once per
% session.
addpath trc-tools

% add the directory of analysis methods to the path.
addpath analysis-tools

% make a change for plotting
set(groot, 'DefaultTextInterpreter', 'none')
set(groot, 'DefaultLegendInterpreter', 'none')
set(groot, 'DefaultAxesTickLabelInterpreter', 'none')
set(groot, 'DefaultFigureColor',[1 1 1])

% the next step here would be to loop over all of the individual trial
% *.trc files and calculate the outcome of interest. because those data are
% stored on the server, we will instead load a pre-calculated dataset of
% these scores to demonstrate the next step of inference.
load outcome_data

% have a peek at the data
peek(outcome_data)

% examine the unique levels of the task and meds variable
unique(outcome_data.task)
unique(outcome_data.meds)

% examine the unique levels of the subject factor
length(unique(outcome_data.patient))

% let's have a look at the data, stratified by meds state and by cognitive
% task.
f1 = figure;
nr = 2;
nc = 2;
h = gobjects(nr*nc,1);

i = 0;
for meds=["on" "off"]
    for task=["standard" "cognitive"]
        i = i+1;
        h(i) = subplot(nr,nc,i);
        histogram_sub_JLM(outcome_data.outcome(outcome_data.meds==meds&outcome_data.task==task));
        title(meds+" meds, "+task+" task");
        if i~=1
            legend off
        end
    end
end
linkaxes(h);

f2 = figure;
classifier_sub_JLM(outcome_data)
