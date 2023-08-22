# Data Integrity Check 

This repository contains code to perform a data integrity check / technical validation on each layer of the SWECO25 database using the `terra` package in R. The goal of this analysis is to ensure the consistency and quality of the data layers.

## Code Overview

The provided R script performs the following tasks:

1. Loop through each raster file in the specified directory.
   - Read the raster layer using
   - Extract required information such as CRS, resolution, extent, and more.
   - Perform checks on CRS, resolution, extent, folder structure, and data integrity.
   - Store the information in the `info_df` dataframe.
2. Perform data checks and visualizations:
   - Check CRS, resolution, extent, folder naming integrity, and data integrity.
   - Visualize range values and NA counts per dataset.
   - Further investigate specific dataset for range and NA counts.

## Data Checks and Results

### CRS, Resolution, Extent, and Naming Integrity Checks

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
