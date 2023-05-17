## SWECO25 Layer Standardization

This section provides an example for SWECO25 layers standardization. Two standardization pipelines are available: [[1]](https://github.com/NKulling/SWECO25/blob/main/layer_standardization_example/standardization_SWECO25_WGS84.R) using input data provided under a WGS84 CRS, and [2](https://github.com/NKulling/SWECO25/blob/main/layer_standardization_example/standardization_SWECO25_LV03.R) using input data provided under a LV03 CRS.

The standardization workflow follows four main steps:

1) Reproject the original layer to the CH1903+ Swiss CRS 
2) Resample to the SWECO25 grid 
3) Multiply float values by 100 and round them
4) Export the standardized layer as a GeoTIFF.

### Step 1: Clone the Repository

Clone the repository containing the dataset processing code to your local machine using the command line

```console
git clone https://github.com/NKulling/SWECO25.git
```

### Step 2: Define Local Variables

Open the R script `standardization_SWECO25_LV03.R` or `standardization_SWECO25_WGS84.R` (depending on the input CRS) and define the following local variable:

```R
#-- Local variables
repo<-"C:/path_to_the_repo/SWECO25"  # Path to the cloned sweco25 repository
```

### Step 3: Run the Standardization Script

Run `standardization_SWECO25_LV03.R` or `standardization_SWECO25_WGS84.R` in R. This script will carry out the following steps for each input file (in the provided example data, there is only one file per pipeline):

1) Load the raster file.
2) Project the raster to Swiss GCS (LV95).
3) Re-sample the raster to the SWECO grid.
4) Multiply the raster values by 100 and round them.
5) Export the processed raster as a GeoTIFF file.

The processed file is in the `output_folder` directory
