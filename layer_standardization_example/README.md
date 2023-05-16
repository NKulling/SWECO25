## SWECO25 Layer Standardization

This section provides an example of how the standardization of SWECO25 layers was performed. It includes two separate standardization pipelines that ensure consistency with SWECO25. [One pipeline](https://github.com/NKulling/SWECO25/blob/main/layer_standardization_example/standardization_SWECO25_WGS84.R) utilizes original raster data from the WGS84 CRS, while [the other](https://github.com/NKulling/SWECO25/blob/main/layer_standardization_example/standardization_SWECO25_LV03.R) employs original raster data from the LV03 CRS.

The standardization workflow consists of four main steps:

1) Reproject the original layer to the CH1903+ Swiss CRS 
2) Resample to the SWECO25 grid 
3) Multiply float values by 100 and round them
4) Export the standardized layer as a GeoTIFF.

### Step 1: Clone the Repository

Clone the repository containing the dataset processing code to your local machine using the command line

```console
git clone https://github.com/NKulling/SWECO25.git
```

### Step 2: Set Up Local Variables

Open the R script `standardization_SWECO25_LV03.R` or `standardization_SWECO25_WGS84.R` (depending on the source data GCS) within the downloaded repository. Set the following local variable:

```R
#-- Local variables
repo<-"C:/path_to_the_repo/SWECO25"  # Path to the cloned sweco25 repository
```

### Step 3: Run the Processing Script

Execute the `standardization_SWECO25_LV03.R` or `standardization_SWECO25_WGS84.R` script within your R environment. This script will carry out the following processing steps for each input file (in the provided example data, there is only one file per pipeline):

1) Load the raster file.
2) Project the raster to Swiss GCS (LV95).
3) Re-sample the raster to the SWECO grid.
4) Multiply the raster values by 100 and round them.
5) Export the processed raster as a GeoTIFF file.

The processed file is in the `output_folder` directory
