## SWECO25 Layer Standardization

This section offers an illustrative example of how the standardization of SWECO25 layers was carried out. Two distinct standardization pipelines are provided here, allowing for the standardization of raster layers in a manner consistent with SWECO25. One pipeline utilizes original raster data from the WGS84 CRS, while the other employs original raster data from the LV03 CRS.

The standardization workflow includes 4 main steps: 

1) Reproject the original layer to the CH1903+ Swiss CRS 
2) Resample to the SWECO25 grid 
3) Multiply float values by 100 and round them
4) Export as GeoTIFF

### Step 1: Clone the Repository

Clone the repository containing the dataset processing code to your local machine using the command line

```console
git clone https://github.com/NKulling/SWECO25.git
```

### Step 2: Set Up Local Variables

In the downloaded repository, open the R script `standardization_SWECO25_LV03.R` or `standardization_SWECO25_WGS84.R` (depending on source data GCS) and set the local variable:

```R
#-- Local variables
repo<-"C:/path_to_the_repo/SWECO25"  # Path to the cloned sweco25 repository
```

### Step 3: Run the Processing Script

In your R environment, execute the `standardization_SWECO25_LV03.R` or `standardization_SWECO25_WGS84.R` script. This script will perform the following processing steps for each input file (just 1 file in the example data):

1) Load the raster file.
2) Project the raster to Swiss GCS (LV95).
3) Re-sample the raster to the SWECO grid.
4) Multiply the raster values by 100 and round them.
5) Export the processed raster as a GeoTIFF file.

The processed file is in the `output_folder` directory
