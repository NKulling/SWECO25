#-- Loading libraries

if(!"terra" %in% installed.packages()) install.packages("terra")
library(terra)

#-- Local variables

outfold<-"C:/..."                                                       #Output folder
sweco.grid<-rast("C:/.../SWECO25-standardgrid.tif")                     #Loading standard grid
files<-list.files("C:/.../folder", full.names=TRUE, pattern= "\\.tif$") #Folder containing files we want reprocessed


#-- Reprocessing loop over each files

for(i in 1:length(files)){
  
  # -- Loading raster
  
  a<-  rast(files[i])
  
  #-- Projecting to Swiss GCS (LV95)
    
  a95<- terra::project(a,"epsg:2056",threads=TRUE) 
    
  #-- Re-sampling to SWECO grid
    
  a95r<-resample(a95,sweco.grid,threads=TRUE)
    
  #-- multiplying by 100 and rounding
    
  a95r1<-round(a95r*100)
  
  #-- Name
  
  name.out<-paste0(names(a),".tif")
  outpath<- paste(outfold,name.out,sep="/")
    
  #-- Export
    
  writeRaster(a95r1,outpath, datatype=  "INT4S", overwrite=TRUE, gdal=c("COMPRESS=DEFLATE", "TFW=YES"))
  
  print(paste0(name.out, " exported. Process done at ", round(i*100/length(files),1),"%"))
    
  gc()
    
  }
  




