# Data Integrity Check and Resampling Effects Analysis

This repository contains the data integrity check and an analysis aimed at evaluating possible effects of resampling the values of source raster layers to the SWECO25 grid. 

# 1 ) Data Integrity Check 

The goal of this analysis was to ensure the consistency and quality of SWECO25 layers. The [R-code](https://github.com/NKulling/SWECO25/blob/main/database_validation/script/database_validation.R) and [data](https://github.com/NKulling/SWECO25/blob/main/database_validation/result_dataframe/info_df.rds) used to perform this check is available in this repository. 

## Code Overview

The provided R script performs the following tasks:

1. Loop through each raster file available in SWECO25.
   - Import the raster layer in R
   - Extract raster information needed for data check.
   - Store them in a dataframe.
2. Perform data check and visualizations:
   - Check CRS, resolution, extent, folder name, and data integrity (range, NA values count, values format).
   - Plot range values and NA counts.
   - Investigate datasets with suspicious range or NA count values.

## Data Check and Results

### CRS, Resolution, Extent, Naming Integrity Checks

All layers passed the CRS, resolution, extent, naming integrity and values format check successfully

### Range Values  and NA count Comparison

A first scatter plot was generated to compare the range values of the datasets. Datasets with extreme range values were identified and discussed. For instance, the"pop" and "hydro" datasets had large ranges that are justified by the nature of the data (i.e. "pop" displays population density per pixel and can thus reach high values, and "hydro" represents the distance in meters to different river classes, which can be consequent). On the other hand, the "rs" dataset had the largest range which is not justified by the normal range of remote sensing indices.
A second scatter plot was generated to display the number of NA  per dataset.  The "rs", "hydro", and "trans" datasets had a higher count of  NA values than the others. These high NA counts were considered valid for "hydro" and "trans" datasets, as these include layers that are calculated from linear features (road and river networks) with little ground coverage. 


| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_range.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NAcount.jpg) |
|:---:|:---:|


### Investigation of RS Dataset

Further investigation was done for the "rs" dataset, for which we explored both range values and NA counts. We observed that the abnormally high range were apparent in only the EVI, GCI and LAI layers, while the NDVI and NDWI layers exhibited the expected ranges.

In the "rs" dataset, most layers had little to no NA values (full extent coverage). Layers masked with a Swiss polygon had an higher -as expected- amout of NA's. Finally, we identified that GCI and LAI layers from 2012 and 2016, respectively, had a very high amount of NA values. Further investigation of these two layers highlighted that the mean GCI layer from 2012 (rs_sdc_2013_gci_mean.tif) was empty for most of Switzerland coverage, and that the standard deviation LAI layer from 2016 (rs_sdc_2016_lai_sd.tif) was, as well, empty for most of Switzerland coverage. 

| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_range_RS.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NA_count_RS.jpg) |
|:---:|:---:|

# 2) Resampling effects Analysis

We assessed the impact of spatial resampling on SWECO25 layers by comparing the values of 15'000 randomly extracted points from both the source and resampled layers. This analysis was conducted on 28 source layers. The [R code](https://github.com/NKulling/SWECO25/blob/main/database_validation/script/resampling_impact_analysis.R) and [data](https://github.com/NKulling/SWECO25/blob/main/database_validation/data/data.zip) used to perform the resampling effect analysis are available in this repository. 

## Code Overview

- Load the values of resampled and source rasters.
- Calculate the differences.
- Compute descriptive statistics: mean, median, standard deviation, and complete range.
- Compute Normalized root-mean-square deviation (NRMSD)- or coefficient of variation - to quantify resampling effects.
  
##  Results

This analysis revealed that the NRMSD of tested layers had a median value of 0.0058 (sd 0.0092) indicating very low difference between original and resampled values. 

|         |    Mean    |  Median   | Std. Deviation |      Range       |
|---------|------------|-----------|----------------|------------------|
| **NRMSD** |  0.0099    |  0.0058   |      0.0092    | 0.0036 - 0.0413 |



<img src="https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NRMSD.jpg" alt="Alt Text" width=500 height=400>

