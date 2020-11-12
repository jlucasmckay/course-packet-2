#!python3
# McKay, 2020 11 10

# imports
import requests, zipfile, io, json, numpy
import matplotlib.pyplot as pyplot
import matplotlib.image as mpimage
import seaborn as seaborn
import pandas as pd

# set a default figure style
seaborn.set_style("whitegrid")

# for those with matlab interference
def size(array_object):
    return array_object.shape

# set figure dpi and other features - this depends on the camera used but is hardcoded here.
dpi = 150
frame_height = 480
frame_width = 640

# download a zip file from an internet address and extract it to the supplied directory.
def extract_zip_to_file(zip_url, data_dir):
	# load copy of data into memory
	r = requests.get(zip_url, allow_redirects=True)
    
	# create a zip file of the file like object io.BytesIO(r.content) 
	z = zipfile.ZipFile(io.BytesIO(r.content))

	# extract files to disk - note that this does not check for overwrites.
	z.extractall(data_dir)

# download the default zip file. you must be within the Emory VPN to access this file.
def import_default():
	zip_url = "https://jlucasmckay.bmi.emory.edu/local/datasets/course-packet-2/offmed-TUG-standard-11.zip"
	data_dir = "./data/json"
	extract_zip_to_file(zip_url,data_dir)
	
# subfunction for return_keypoints
def extract_keypoints_from_json_people(json_people):
    # create a holder for the keypoints for each person in this frame
    person_id = []
    pose_keypoints_2d = []
    for i in range(0,len(json_people)):
        person_id.append(json_people[i]["person_id"])
        pose_keypoints_2d.append(json_people[i]["pose_keypoints_2d"])
    # return a dict
    return {'person_id': person_id, 'pose_keypoints_2d': pose_keypoints_2d}

# extract keypoints for the last person identified from filename
def return_keypoints(file_name):
    
    # extract keypoints as a vector
    json_temp = json.load(open(file_name))['people']
    
    # extract the keypoints of the last person entered
    keypoints = numpy.array(extract_keypoints_from_json_people(json_temp)["pose_keypoints_2d"][-1]).astype('float')
    
    # set missing points (imputed as 0) to nan so that they are not plotted
    keypoints[keypoints==0] = numpy.nan
    
    return keypoints

# extract keypoints and return as a nice dataframe assuming the body25 structure
def return_body25(file_name):
    
    # load keypoints
    keypoints = return_keypoints(file_name)
    
    # reshape to 25 X 3; the coordinates are x, y, confidence in estimate
    kin = keypoints.reshape((-1,3))
        
    # create and return a dataframe
    return pd.DataFrame({'keypoint': ["Nose", "Neck", "RShoulder", "RElbow", "RWrist", "LShoulder", "LElbow", "LWrist", "MidHip", "RHip", "RKnee", "RAnkle", "LHip", "LKnee", "LAnkle", "REye", "LEye", "REar", "LEar", "LBigToe", "LSmallToe", "LHeel", "RBigToe", "RSmallToe", "RHeel"], 'x': kin[:,0], 'y': kin[:,0]})
    
    
# plot keypoints of one person, subfunction of plot_keypoints
def plot_body(keypoints):
    
    fig = pyplot.figure(dpi = dpi)

    # create a axis, which for some reason (inheritance?) is called a subplot
    ax = fig.subplots()
    ax.set(xlim=[0, frame_width], ylim=[frame_height, 0], xlabel='X', ylabel='Y')
    
    ## ADD PLOTTING CODE HERE
    
    return fig

# plot keypoints for a person
def plot_keypoints(file_name):
    
    # extract keypoints as a vector
    json_temp = json.load(open(file_name))['people']
    
    # extract the keypoints of the last entry
    keypoints = numpy.array(extract_keypoints_from_json_people(json_temp)["pose_keypoints_2d"][-1]).astype('float')
    
    # set missing points (imputed as 0) to nan so that they are not plotted
    keypoints[keypoints==0] = numpy.nan
    
    return plot_body(keypoints)






	

