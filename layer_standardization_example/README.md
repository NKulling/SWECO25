## SWECO25 Layer Standardization

[This R code](https://github.com/NKulling/SWECO25/blob/main/layer_standardization_example/standardization_SWECO25.R) provides an example on how SWECO25 layers were standardized.

The standardization workflow includes 4 main steps: 

1) Reproject the original layer to the CH1903+ Swiss CRS 
2) Resample to the SWECO25 grid 
3) Multiply float values by 100 and round them
4) Export as GeoTiff

To reproduce the example, Make sure you have the following software and libraries installed:
- R programming language
- `terra` package
and follow these steps :

Step 1: Clone the Repository

Clone the repository containing the dataset processing code to your local machine:

'''
git clone https://github.com/your-username/your-repo.git
'''
