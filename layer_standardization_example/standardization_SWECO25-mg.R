#-- Loading libraries
pks=c("devtools", "rgdal", "raster", "sf")
pks_ins<-pks[which(!pks %in% installed.packages())]
if(length(pks_ins)>0) install.packages(pks_ins)
lapply(pks, library, character.only=TRUE)
if(!"gdalUtilities" %in% installed.packages()) install_github("JoshOBrien/gdalUtilities")
library(gdalUtilities)

#-- Local variables

repo<-"C:/.../SWECO25"   # Path to the cloned sweco25 repository
outfold<-paste(repo,"output_folder",sep="/")    
dir.create(outfold)

sweco.grid<-raster(paste(repo,"data/SWECO25-standardgrid.tif",sep="/"))   #Loading standard grid
files<-list.files(paste(repo,"data/LV03data",sep="/"), full.names=TRUE, pattern= "\\.tif$") #Folder containing files we want reprocessed

#-- Reprocessing loop over each files

for(i in 1:length(files)){
  
  # -- Loading raster
  
  a<-files[i]
  
  ## To allow rgdal to use the best available reprojection pipeline, download the
  ## grid shift file https://cdn.proj.org/ch_swisstopo_CHENyx06a.tif and place
  ## it in your $R_LIB/rgdal/proj directory.
  ## Retrieve best available resampling pipeline
  pipelines <- sf_proj_pipelines("EPSG:21781", "EPSG:2056")
  pipeline_1 <- pipelines$definition[1]
  if(nchar(pipeline_1)==1) pipeline_1 <- pipelines$definition[2]
 
  ## Retrieve resampling parameters
  ext <- c(bbox(extent(sweco.grid)))
  res <- c(raster::res(sweco.grid))
  pro <- raster::projection((sweco.grid))
  
  #-- Resampling to SWECO grid
  a95r <-  raster(gdalwarp(a,   tempfile(fileext='.tif'),
                                t_srs=pro, 
                                tr=res, 
                                r="bilinear",te=ext,
                                ct=pipeline_1,
                                multi=TRUE)) 
  

  #-- multiplying by 100 and rounding
    
  a95r1<-round(a95r*100)
  
  #-- Name
  
  name.out<-paste0(basename(a))
  outpath<- paste(outfold,name.out,sep="/")
    
  #-- Export
    
  raster::writeRaster(a95r1, outpath, datatype="INT4S", overwrite=TRUE, wopt=list(gdal=c("COMPRESS=DEFLATE", "TFW=YES"), datatype='INT4S'))
                
  print(paste0(name.out, " exported. Process done at ", round(i*100/length(files),1),"%"))
    
  gc()
    
  }
  




