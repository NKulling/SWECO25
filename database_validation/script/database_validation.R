library(terra)
library(ggplot2)

sweco<-"F:/SWECO25"
template<- rast("/SWECO25-standardgrid.tif")        # get template file with SWECO25 CRS, Extent, res
output<-"/results"
figures<-"/figures"

# Create an empty dataframe to store the information
info_df <- data.frame()

lfs<-list.files(sweco, recursive=T, pattern="\\.tif$", full.names=T)
raster_files<-lfs

# Loop through each raster file (5265 layers)

total_files <- length(raster_files)

i<-0

for (file in raster_files) {

  # Read the raster layer
  r <- rast(file)
  
  # Extract the required information
  
    # standard format
  
  crs <- crs(r)
  check_crs<-crs==crs(template)
  resolution <- res(r)
  check_res<-resolution==res(template)
  extent <- ext(r)
  check_ext<-extent==ext(template)
  
    # Folder structure and naming scheme
  
  layer_name <- basename(file)
  layer_name_supposed<-paste(names(r),".tif",sep="")
  name_integrity<-layer_name_supposed == layer_name
  
    # Data integrity
  
  mm<-minmax(r)
  min_value <- mm[1]
  max_value <- mm[2]
  na_count <- sum(is.na(values(r)))
  intg<- is.int(r)
  rang<- abs(max_value) + abs(min_value)

  # Create a data frame for the current raster layer's information
  layer_info <- data.frame(
    LayerName = layer_name,
    Check_crs = check_crs,
    Check_res = check_res,
    Check_ext = check_ext,
    Name_integrity = name_integrity,
    NA_Count = na_count,
    Value_range = rang,
    Integer = intg,
    File = file,
    CRS = crs,
    Resolution = paste(resolution[1], resolution[2]),
    Extent = paste(extent[1], extent[2], extent[3], extent[4]),
    Min_Value = min_value,
    Max_Value = max_value
  )
  
  # Append the layer_info to the info_df
  info_df <- rbind(info_df, layer_info)
  
  i<-i+1
  
  print(paste(i, " out of ", total_files ))
  
  gc()
}

saveRDS(info_df, paste(output, "info_df.rds", sep="/"))

#--- Check the data

if (all(info_df[["check_crs"]] == TRUE)) {          # Passed
         print("CRS check passed")
             } else {
         print("CRS check failed")
}
if (all(info_df[["check_res"]] == TRUE)) {          # Passed
         print("Resolution check passed")
             } else {
         print("Resolution check failed")
}
if (all(info_df[["check_ext"]] == TRUE)) {          # Passed
         print("Extent check passed")
             } else {
         print("Extent check failed")
}
if (all(info_df[["Name_integrity"]] == TRUE)) {     # Passed
         print("Name integrity and folder scheme check passed")
             } else {
         print("Name integrity and folder scheme check failed")
}
if (all(info_df[["Integer"]] == TRUE)) {            # Passed
         print("Integer check passed")
             } else {
         print("Integer check failed")
}

#--- Checking range values 


for(i in 1:nrow(info_df)){
    info_df$dataset[i]<- unlist(strsplit(info_df$LayerName[i], "_"))[1] # Extract dataset name
      }

# Define a color palette 

dataset_colors <- c(
  "bioclim" = "red",
  "lulc" = "blue",
  "vege" = "green",
  "edaph" = "orange",
  "geol" = "purple",
  "hydro" = "pink",
  "pop" = "cyan",
  "rs" = "magenta",
  "topo" = "gray",
  "trans" = "coral"
)

# Create a scatter plot to explore ranges per dataset
# Set the file name for the exported JPG


ggplot(info_df, aes(x = Value_range, y = dataset)) +
  geom_point(aes(color = dataset), shape = 16, size = 3, position = "jitter") +
  labs(x = "Range", y = "", title = "Range values comparison") +
  scale_color_manual(values = dataset_colors) +
  theme_bw()+
  guides(color = "none")

setwd(figures)
ggsave("scatterplot_range.jpg", plot=last_plot(), height= 5, width= 6)

        #The RS dataset stands out due to its remarkably wide range of values. 
        #The pop and hydro datasets also feature substantial values, which can 
        #be attributed to the inherent characteristics of the data.

range(info_df[info_df$dataset=="pop",]$Value_range)   # coherent with population data values
range(info_df[info_df$dataset=="hydro",]$Value_range) # coherent with distance to river data values
range(info_df[info_df$dataset=="trans",]$Value_range) # Same as with "hydro", distance to roads display coherent range of values


#--- Checking NA values

ggplot(info_df, aes(x = NA_Count, y = dataset)) +
  geom_point(aes(color = dataset), shape = 16, size = 3, position = "jitter") +
  labs(x = "NA count", y = "", title = "NA count comparison") +
  scale_color_manual(values = dataset_colors) +
  theme_bw()+
  guides(color = "none")

setwd(figures)
ggsave("scatterplot_NAcount.jpg", plot=last_plot(), height= 5, width= 6)
      
      #Datasets that stand out in terms of NA values count are RS and hydro, and trans to some extent. 
      #This result is coherent with the nature of hydro and trans layers (which are linear features only
      #representing road and river networks
      #this is not coherent for RS values, there is one cluster of RS data with abnormally high NA counts

#--- Further investigating RS values for range and NA count

rs_df<-info_df[info_df$dataset =="rs",]
for(i in 1:nrow(rs_df)){
  rs_df$index[i]<- unlist(strsplit(rs_df$LayerName[i], "_"))[4]# Extract dataset
  rs_df$year[i]<-  unlist(strsplit(rs_df$LayerName[i], "_"))[3]# Extract year
}

rs_colors <- c(
  "evi" = "red",
  "gci" = "blue",
  "lai" = "green",
  "ndvi" = "orange",
  "ndwi" = "purple"
)


#- Range check 

ggplot(rs_df, aes(x = Value_range, y = index)) +
  geom_point(aes(color = index), shape = 16, size = 3, position = "jitter") +
  labs(x = "Range value", y = "", title = "Range values comparison") +
  scale_color_manual(values = rs_colors) +
  theme_bw()+
  guides(color = "none")

setwd(figures)
ggsave("scatterplot_range_RS.jpg", plot=last_plot(), height= 5, width= 6)

  # We see the range abnormality is present only in evi, gci and lai datasets
  # the ndvi and ndwi indices show normal ranges 


#- NA values check 

# Flagging high NA count values
rs_df$outliers<-""
rs_df[which(rs_df$NA_Count>quantile(rs_df$NA_Count)[4]),]$outliers <- rs_df[which(rs_df$NA_Count>quantile(rs_df$NA_Count)[4]),]$year


ggplot(rs_df, aes(x = NA_Count, y = index)) +
  geom_point(aes(color = index), shape = 16, size = 3, position = "jitter") +
  geom_text(aes(x = NA_Count, y = index, label= outliers), position = "jitter")+
  labs(x = "NA count", y = "", title = "NA count comparison") +
  scale_color_manual(values = rs_colors) +
  theme_bw()+
  guides(color = "none")

setwd(figures)
ggsave("scatterplot_NAcount_RS.jpg", plot=last_plot(), height= 5, width= 6)

    # We observe mostly data with little to no NA value (full extent coverage),
    # but also data with normal amount of NA's, corresponding to a cropped Swiss mask
    # and finally datasets with remarkably high amount of NA values: some GCI and LAI layers,
    # from 2012 and 2016, respectively

