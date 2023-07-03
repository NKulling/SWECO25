
## Spatial characteristics
<img src="https://github.com/NKulling/SWECO25/blob/main/figs/ch.png" data-canonical-src="https://github.com/NKulling/SWECO25/blob/main/figs/ch.png" width="500"  />

| Parameter  | Value |
| ------------- | ------------- |
| GCS                         | CH1903+ / LV95 ( [EPSG:2056](https://epsg.io/2056)   )          |
| Extent                      | 2480000, 2840000, 1070000, 1300000     |
| Grid                        | [SWECO25 Grid](https://github.com/NKulling/SWECO25/blob/main/data/SWECO25-standardgrid.tif)      |
| Spatial resolution (meters) | 25, 25  (x, y)                         |



## Layer processing

Individual layers from selected datasets were processed following an eight-step standardization procedure:

1. rasterization of vector layers
2. reprojection to the CH1903+ / LV95 geographic reference system
3. resampling to a common spatial grid of 25-meter resolution
4. transformation of discrete data to continuous ones
5. computation of  distance statistics for linear features
6. computation of focal statistics (average value in a  circular moving window of 13 radii from 25m to 5km)
7. conversion of decimals to integer values for storage efficiency purposes
8. saving the final raster layers as GeoTiFF files

For more details on the [standardization procedure](https://github.com/NKulling/SWECO25/tree/main/layer_standardization_example) and [focal](https://github.com/NKulling/SWECO25/tree/main/focal_statistics_toolbox) or [distance](https://github.com/NKulling/SWECO25/tree/main/distance_toolbox) statistics computation see the R scripts and ArcGIS toolboxes.
