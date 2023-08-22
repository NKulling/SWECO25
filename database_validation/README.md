# Data Integrity Check using Terra Package

This repository contains code to perform a data integrity check on each layer of the database using the `terra` package in R. The goal of this analysis is to ensure the consistency and quality of the data layers.

## Code Overview

The provided R script performs the following tasks:

1. Load necessary libraries and define file paths.
2. Initialize an empty dataframe (`info_df`) to store layer information.
3. Loop through each raster file in the specified directory.
   - Read the raster layer using `terra::rast`.
   - Extract required information such as CRS, resolution, extent, and more.
   - Perform checks on CRS, resolution, extent, folder structure, and data integrity.
   - Store the information in the `info_df` dataframe.
4. Save the `info_df` dataframe as an RDS file.
5. Perform data checks and visualizations:
   - Check CRS, resolution, extent, folder naming integrity, and data integrity.
   - Visualize range values and NA counts per dataset.
   - Further investigate specific dataset (e.g., "rs") for range and NA counts.

## Data Checks and Results

### CRS, Resolution, Extent, and Naming Integrity Checks

The script performs checks on CRS, resolution, extent, and naming integrity for each layer. If all checks pass, a message indicating success is printed.

### Range Values Comparison

A scatter plot is generated to compare the range of values for different datasets. Datasets with extreme range values are identified and discussed. For instance, the "RS" dataset stands out due to its wide range of values, while the "pop" and "hydro" datasets have large values that are justified by the nature of the data.

### NA Count Comparison

Another scatter plot visualizes the NA count for different datasets. Datasets with notable NA counts are highlighted and explained. For example, the "RS" and "hydro" datasets have higher NA counts, which aligns with their data characteristics. The "trans" dataset also shows some variation in NA counts.

### Further Investigation of RS Dataset

The script performs further investigation on the "rs" dataset, exploring both range values and NA counts. Subsets of the dataset are categorized and visualized using different colors for different indices. Abnormalities in range values and NA counts are discussed for specific indices and years.

## Conclusion

The data integrity check using the `terra` package and the subsequent analyses provide insights into the consistency, quality, and characteristics of the dataset. The code and visualizations aid in identifying anomalies and ensuring the reliability of the data layers for further analysis.

<!-- Include plots here -->
