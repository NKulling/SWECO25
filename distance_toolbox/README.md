## SWECO25 distance toolbox

[SWECO25 Distance Calculation Toolbox](distance_SWECO25.tbx) calculates distance layers based on polygons or linear features, such as road or river networks. It generates two distance raster layers: one for the Euclidean distance and one for the path distance (considering elevation gradients).

The required inputs for this toolbox are:

1) A shapefile of the features from which to compute distances
2) An output folder where the results are stored
3) A digital terrain model (DTM) raster layer

Below is the ArcGIS Pro Modelbuilder structure for this toolbox:

![](https://github.com/NKulling/SWECO25/blob/main/figs/distance_modelbuilder_SWECO25.JPG)

