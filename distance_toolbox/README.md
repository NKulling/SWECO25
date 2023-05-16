## SWECO25 distance toolbox

[SWECO25 Distance Calculation Toolbox](distance_SWECO25.tbx) calculates distance layers based on polygons or linear features, such as road or river networks. It generates two distance raster layers: one computing the Euclidean distance and the other considering elevation gradients to calculate path distance.

The required inputs for this toolbox are:

1) A shapefile of the feature to compute the distance upon.
2) An output folder to store the results.
3) A digital terrain model (DTM) raster layer representing elevation.

Below is the representation of the ArcGIS Pro Modelbuilder structure used in this toolbox:

![](https://github.com/NKulling/SWECO25/blob/main/figs/distance_modelbuilder_SWECO25.JPG)

