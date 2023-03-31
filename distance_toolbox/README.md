## SWECO25 distance toolbox

[This toolbox](distance_SWECO25.tbx) computes distance layers based on polygons or linear features such as road or river networks. It outputs two distance raster layers, one computing the euclidean distance, the other the path distance (considering elevation gradients). 

The necessary inputs for this tool are:

1. A shapefile of the feature to compute the distance upon
2. An output folder
3. A digital terrain model (DTM) raster layer representing elevation


Below is the representation of the ArcGIS Pro Modelbuilder structure used in this toolbox 
