## SWECO25 layer standardization

This R code gives an example of the process and parameters used to reprocess the layers from the SWECO25 database. 
The workflow of the standardization is in 4 steps: 

1) Reproject the original layer to Swiss CRS 
2) Resample to the SWECO25 grid 
3) Multiply float values by 100 and round it
4) Export as GeoTiff
