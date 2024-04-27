# Sat-Sight-View
**A simulation of the Yale bright star catalog. Stars are position according to their galactic 
longitude and latitude.**

Used to capture simi-realistic data of the night sky for training a satellite star tracker

## [Bright Star Catalog](http://tdc-www.harvard.edu/catalogs/bsc5.readme)
The Bright Star Catalogue (BSC) is widely used as a source of basic astronomical and astrophysical 
data for stars brighter than magnitude 6.5.

The  BSC  contains  9110 objects, of which 9096 are stars 
(14 objects catalogued in the original compilation of 1908 are novae or extragalactic objects 
that have been retained to preserve the numbering, but most of their data are omitted)

### Database adjustments
The 14 non-star objects in the database were removed
The 4 stars with negative Vmag were given a value of 0.01

Original dataset: [Link](http://tdc-www.harvard.edu/catalogs/bsc5.html)

## Data

The `./data` directory contains two `.csv` files: `star_pos.csv` and `camera_pos.csv` and a
calculations excel file. 
- The star position file contains the x,y,z vectors for the 9096 star objects. These vectors are
calculated based on the galactic longitudes and latitudes from the dataset. They can be recalculated
using the calculations file.
- The camera position file contains the delta lambda and phi angles the camera should shift between
each capture point. It is not the cords themselves.
- The calculation file allows you to recalculate these values if you use a different dataset or 
want to change the number of captures. 

## Usage
The project can be downloaded as a zip and imported through the Godot Engin project manager.

Hold the Right Mouse button to translate the camera orientation

Press: `F2` to take a screenshot. Screenshots will be saved
with their galactic coordinates that the image was captured 
at with the format: `[Lat (phi),Lon (lambda)]`

Press: `F3` will toggle movement with `WSAD`

Press: `F4` to cycle through the sky overlays. There is a Celestial Grid and Constellation Figures
overlay in addition to the blank background. 

Press: `F5` to begin the capturing the scene from the given camera positions

Press: `F6` to stop the capture

### The capture process

When you begin the capture scan a script will:
	1. Add the lambda and phi values from the row in the csv to the camera rotation
	2. Take a screenshot
	3. Repeat

Screenshots can be found in `C:\Users\[username]\AppData\Roaming\Godot\app_userdata\[project name]\screenshots`

### Data processing

The `extract_labels` notebook can loop through a directory of images, 
extract the location data from the name and construct a label csv.
