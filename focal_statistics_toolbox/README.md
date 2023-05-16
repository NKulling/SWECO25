## SWECO25 Focal Statistics Toolbox

[The SWECO25 focal Statistics toolbox](focal_statistics_SWECO25.tbx) computes focal statistics for each raster layer within the input folder. It generates a set of 13 raster layers, each with focal statistics calculated using radii ranging from 25m to 5000m.

The toolbox requires the following inputs:

    A folder containing one or multiple raster layers.
    An output folder to store the results.

The **mean** value is calculated within circular areas with varying radii.

Below is the structure of the ArcGIS Pro Modelbuilder utilized for this process:

<img src="https://github.com/NKulling/SWECO25/blob/main/figs/focal_statistics_modelbuilder_SWECO25.JPG" width="600">



