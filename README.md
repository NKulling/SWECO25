## SWECO25 [![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https://zenodo.org/communities/sweco25/?page=1&size=20&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

<a href="https://"><img src="https://img.shields.io/static/v1?label=Dataset&message=Open+Access&color=%23ADFF2F" alt="Dataset - Open Access"></a>

SWECO25 is Swiss-wide raster database at 25-meter resolution for ecological research in Switzerland gathering 5,265 layers from 10 main environmental categories. SWECO25 layers were standardized to a common spatial grid covering all of Switzerland, so they all share the same spatial resolution, extent, and geographic coordinate system. SWECO25 includes both the standardized source data and newly calculated layers, such as those obtained by computing focal or distance statistics. The SWECO25 database is openly available on Zenodo and is intended to be improved, updated, and extended at regular intervals.

[![Download ](https://custom-icon-badges.herokuapp.com/badge/-DOWNLOAD%20SWECO25-blue?style=for-the-badge&logo=download&logoColor=white "Go to SWECO25 Zenodo repository")](https://zenodo.org/communities/sweco25/?page=1&size=20)

## Spatial characteristics
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

