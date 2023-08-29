# Data integrity check and effects of resampling operations

This repository contains the R code and sample data used for the data integrity check and an analysis aimed at evaluating possible effects of resampling the values of the source raster layers to the SWECO25 grid. 

# 1 ) Data Integrity check 

The goal of this analysis was to ensure the consistency and quality of SWECO25 layers. We provided the [R-code](https://github.com/NKulling/SWECO25/blob/main/database_validation/script/database_validation.R) and sample [data](https://github.com/NKulling/SWECO25/blob/main/database_validation/result_dataframe/info_df.rds).

## Code overview

The R script performs the following tasks:

1. Loop through each SWECO25 file:
   - Import raster layer in R
   - Extract raster information
   - Store information in dataframe
2. Perform data check and plots:
   - Check CRS, resolution, extent, folder name, and data integrity (range, count of NA values, values format)
   - Plot range values and NA counts
   - Investigate datasets with suspicious range or NA count

## Data check and results

### CRS, resolution, extent, naming convention, values format

All layers passed the CRS, resolution, extent, naming convention and values format check successfully

### Range values and NA counts plots

A plot was generated to compare the range values of the datasets. Datasets with extreme range values were identified and discussed. For instance, the"pop" and "hydro" datasets had large ranges that were justified by the nature of the data (i.e. "pop" displays population density per pixel and can thus reach very high values, and "hydro" displays the distance in meters to different river classes, which can be also high). On the other hand, the "rs" dataset had the largest range, which could not be justified by the expected range of remote sensing indices.
A second plot was generated to display the number of NA per dataset.  The "rs", "hydro", and "trans" datasets had a higher count of NA values. These high NA counts were considered valid for "hydro" and "trans" datasets, as these include layers that are calculated from linear features (road and river networks) with little ground coverage.


| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_range.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NAcount.jpg) |
|:---:|:---:|


### Investigation of the "rs" Dataset

Further investigation was done for the "rs" dataset, for which we explored both range values and NA counts. We observed that the unexpected high ranges were apparent in only the EVI, GCI and LAI layers, while the NDVI and NDWI layers had expected ranges.

In the "rs" dataset, most layers had little or no NA values (full extent coverage). Layers masked with a Swiss polygon had an higher -as expected- amount of NAs. Finally, we identified that GCI and LAI layers from 2012 and 2016, respectively, had a very high amount of NAs. Further investigation of these two layers showed that the mean GCI layer from 2012 (rs_sdc_2012_gci_mean.tif) had no values for most of Switzerland, and that the standard deviation LAI layer from 2016 (rs_sdc_2016_lai_sd.tif) was also almost empty. 

| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_range_RS.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NA_count_RS.jpg) |
|:---:|:---:|

# 2) Resampling effects

We assessed the impact of spatial resampling on SWECO25 layers by comparing the values of 15'000 randomly points extracted from the source and resampled layers. This analysis was conducted for 28 source layers. The [R code](https://github.com/NKulling/SWECO25/blob/main/database_validation/script/resampling_impact_analysis.R) and [data](https://github.com/NKulling/SWECO25/blob/main/database_validation/data/data.zip) used to perform this analysis are available in this repository.

## Code overview

- Load resampled and source rasters
- Calculate differences at sampling points
- Compute Normalized root-mean-square deviation (NRMSD)- or coefficient of variation - to quantify resampling effects for continuous data
- Compute Dice's coefficient to quantify resampling effects for discrete data
  
##  Results

This analysis revealed that the NRMSD of tested layers had a median value of 0.0066 (sd 0.0348 ), and the Dice's coefficient of tested layers had a median value of 0.9905 (sd 0.073), indicating very low difference between original and resampled values. 
The layers that displayed the most prominent disparities between the source and SWECO25 layers ("topo_alti3d_aspect_mean" and "wsl_habitat_group") were those subjected to upscaling processing in SWECO25. This upscaling transitioned from an approximately 2-meter resolution to 25 meters, thereby providing a reasonable explanation for the potential deviations in values at randomly sampled points.

|                    |   Mean   |  Median  | Std. Deviation |       Range       | Nb. layers |     Data type      |
|--------------------|----------|----------|----------------|-------------------|------------|-------------------|
| **NRMSD**          |  0.0190  |  0.0066  |     0.0348     | 0.0010 - 0.1810   |      32      |        Continuous           |
| **Dice's coefficient** | 0.9412 | 0.9905   |     0.073      | 0.8234 - 1.0000   |     7      |           Discrete        |



| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NRMSD.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_Dice.jpg) |
|:---:|:---:|



