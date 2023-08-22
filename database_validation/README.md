# Data Integrity Check and Resampling Impact Analysis

This repository encompasses a comprehensive data integrity check and a subsequent analysis to evaluate the impact of resampling on the values of raster layers in the SWECO25 database. 

# 1 ) Data Integrity Check 

This repository contains the R [code](https://github.com/NKulling/SWECO25/blob/main/database_validation/script/database_validation.R) to perform a data integrity check / technical validation on each layer of the SWECO25 database. The goal of this analysis is to ensure the consistency and quality of the data layers.

## Code Overview

The provided R script performs the following tasks:

1. Loop through each raster file in the specified directory.
   - Read the raster layer 
   - Extract required information to perform data check.
   - Store the information in the [`info_df`](https://github.com/NKulling/SWECO25/blob/main/database_validation/result_dataframe/info_df.rds) dataframe.
2. Perform data checks and visualizations:
   - Check CRS, resolution, extent, folder naming integrity, and data integrity (range, NA values count, values format).
   - Visualize range values and NA counts per dataset.
   - Further investigate specific dataset for range and NA counts.

## Data Checks and Results

### CRS, Resolution, Extent, Naming Integrity Checks

All data passed the CRS, resolution, extent, naming integrity and values format check successfully

### Range Values  and NA count Comparison

a first scatter plot is generated to compare the range of values for different datasets. Datasets with extreme range values are identified and discussed. For instance, the "rs" dataset stands out due to its wide range of values, while the "pop" and "hydro" datasets have large values that are justified by the nature of the data. 
A second scatter plot visualizes the NA count for different datasets.  The "rs" and "hydro" datasets have higher NA counts. The "trans" dataset also shows some variation in NA counts. These high NA counts are legitimate for "hydro" and "trans" datasets, as they represent linear features (road and river networks) with little ground coverage. 


| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_range.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NAcount.jpg) |
|:---:|:---:|


### Further Investigation of RS Dataset

We then perform a further investigation on the "rs" dataset, exploring both range values and NA counts. We observe that the range abnormality is present only in evi, gci and lai datasets, while the ndvi and ndwi indices show normal ranges 

In the "rs" dataset, we observe mostly data with little to no NA value (full extent coverage), but also data with normal amount of NA's, corresponding to a cropped Swiss mask.  Finally a fraction of the data show remarkably high amount of NA values: GCI and LAI layers,from 2012 and 2016, respectively

| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_range_RS.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NAcount_RS.jpg) |
|:---:|:---:|

# 2) Resampling Impact Analysis

To assess the impact of resampling on raster layer values, we extracted 15'000 points on the original and resampled layers to compare the impact of resampling on the raster values. This analysis was concluded on 28 original layers from the SWECO25 database (not performed on focal statistics or distance layers). 

The [R code](https://github.com/NKulling/SWECO25/blob/main/database_validation/script/resampling_impact_analysis.R) and [data](https://github.com/NKulling/SWECO25/blob/main/database_validation/data/data.zip) used to perform the resampling impact analysis are available in this repository. 

## Code Overview

- Load and analyze resampled and original raster data.
- Calculate deltas between original and resampled values.
- Compute descriptive statistics including mean, median, standard deviation, and complete range.
- Compute Normalized RMSD (NRMSD) to quantify resampling impact.
- Calculate the R-squared value to assess the correlation between original and resampled values.
  
##  Results


|         |    Mean    |  Median   | Std. Deviation |      Range       |
|---------|------------|-----------|----------------|------------------|
| **NRMSD** |  0.0099    |  0.0058   |      0.0092    | 0.0036 - 0.0413 |
| **R squared** |  0.9651    |  0.9897   |      0.0432    | 0.8552 - 0.9995 |


The analysis reveals that the NRMSD values across layers have a median value of 0.0058, indicating a low resampling impact. The R-squared values, with a median of 0.9897, suggest strong correlation between original and resampled values. The lowest R-squared scores are obtained by "rs" layers which were already "flagged" in the data integrity analysis as having an abnormally high range, thus introducing noise in the calculations. 

| ![Alt Text 1](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_NRMSD.jpg) | ![Alt Text 2](https://github.com/NKulling/SWECO25/blob/main/database_validation/figures/scatterplot_RSq.jpg) |
|:---:|:---:|

