## SWECO25 Focal statistics toolbox

[This toolbox](focal_statistics_SWECO25.tbx) automatically computes focal statistics on each raster layer from the input folder, with an output of 13 raster layers with 13 focal statistics radius ranging from 25m to 5000m. The necessary inputs for this tool are 

1. a folder containing one or several raster layers
2. an output folder

The **mean**  value is calculated on a circle with varying radius. 

Below is the representation of the ArcGIS Pro Modelbuilder structure used for this process 

![](https://github.com/NKulling/SWECO25_datapaper/blob/f1a863ca029518be477f19a75ebd704b1f38b58e/modelbuilder_focal_sweco.JPG)



