# Sat-Sight-View
**A simulation of the Yale bright star catalog. Stars are position acording to their galactic longitude and latitude.**
http://tdc-www.harvard.edu/catalogs/bsc5.readme

Used to capture simi-relistic data of the night sky for trainning a satilite star tracker

## Bright Star Catalog
The Bright Star Catalogue (BSC) is widely used as a source of basic astronomical and astrophysical data for stars brighter than magnitude 6.5.

The  BSC  contains  9110 objects, of which 9096 are stars (14 objects catalogued in the original compilation of 1908 are novae or extragalactic objects that have been retained to preserve the numbering, but most of their data are omitted)

### Database adjustments
The 14 non-star objects in the database were removed
The 4 stars with negative Vmag were given a value of 0.01

Original dataset: http://tdc-www.harvard.edu/catalogs/bsc5.html

## Usage
The project can be downloaded as a zip and imported through the Godot Engin project manager.

Hold the Right Mouse button to translate the camera orientation

Press: `F2` to take a screenshot. Screenshots will be saved
with a date and time of the format: YYYY-MM-DD-HHMMSS followed by the euler angles
that the image was caputred at with the format: [x,y]

Press: `F3` to bring up the debug overlay to view FPS and preformance

Press: `F4` to cycle through the sky overlays
