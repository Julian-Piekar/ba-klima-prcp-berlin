################################################################################
# This function reads CER-Data (see www.klima.tu-berlin.de/CER) from a single 
# netCDF-file and returns a matrix (array)
# Input:
# ncfpath     = full netCDF-file path of CER-data nc (char)
# variable    = name of the variable default="t2" (char)
# sub         = temporal subset, default = FALSE (logi) means all
#               must be a vector of two indexes (e.g. c(4,10) 
#               for monthly data April to October)  
# aggr        = aggregation (List) default: aggr <- list(FALSE,"mean")
#               meaning no aggregation as default (simply reads the data)
# 
# output:
# aggregated array (x,y) over z (mean) containing the result 

# Dependencies:
# ncdf4
# 
# Example:
# read data and aggregate third dimension
# berlin_t2_2018nc  <- read_CER(fpath1, aggr = list(TRUE,"mean"))
# ToDo:
# add more aggregation methods to aggr
#
# author: Marco Otto 10.2021
################################################################################
require(ncdf4)
read_CER <- function(ncfpath, 
                     variable = "prcp",
                     sub = FALSE, 
                     aggr = list(FALSE,"mean")){
  ncin  <-  nc_open(filename = ncfpath)
  ncvar <-  ncvar_get(ncin,variable)
  nc_close(ncin)
  
  # subset third dimension if sub = TRUE (temporal subset)
  if (length(sub) == 2){
    ncvar <- ncvar[,,sub[1]:sub[2]]
  }
  # compute spatial mean over the third dimension if aggr = list(TRUE,"mean")
  if (aggr[[1]] & aggr[[2]] == "mean"){
    ncvar_spm <- apply(ncvar, c(1,2),mean, na.rm=TRUE)
  }
  return(ncvar_spm)
}

################################################################################
# This function takes care of the projection of CER-Data
# and reproject WRF Lambert Conformal to geographic CRS (lat/lon WGS84)
#
# Input:
# ncdata      = CER-data nc data object from read_CER()
# ncdir       = directory of all CER-nc files (char)
# concKtCgeg  = convert to Kelvin if TRUE default FALSE

# Output:
#  reprojected terra-object

# needs package terra and RColorBrewer (for colour ramp plotting)
# ToDo:
#
# author: Marco Otto 11.2021
################################################################################

require(terra) # newer than raster
require(RColorBrewer) # map colour ramp
proj_CER <- function(ncdata,ncdir, 
                     concKtCgeg=FALSE){
  
  # read nc-file first nc-file in directory for global attributes
  # due to changing global attributes in current CER-products
  fpath_2001 <- list.files(ncdir, full.names = T)[1]
  ncin  <-  nc_open(filename = fpath_2001)
  # need to define custom CRS (WRF LCC has no standard EPSG) - see global attributes 
  wrf_crs <- paste0("+proj=lcc ",
                  "+lat_1=40 +lat_2=60 +lat_0=51.00000381 +lon_0=14 ",
                  "+x_0=0 +y_0=0 +a=6370000.0 +b=6370000.0 ",
                  "+ellps=sphere +datum=WGS84 +units=m +no_defs")
  
  # prepare an empty container as terra-raster object with the dims from CER-Input
  # from 2001 global attribute (formate changes after 2016)
  terravar <- rast(ncols = ncatt_get(ncin,0)$GRID_NX,
                   nrows = ncatt_get(ncin,0)$GRID_NY,
                   xmin  = ncatt_get(ncin,0)$GRID_X00,
                   xmax  = ncatt_get(ncin,0)$GRID_X00 + ncatt_get(ncin,0)$GRID_NX * ncatt_get(ncin,0)$GRID_DX,
                   ymax  = ncatt_get(ncin,0)$GRID_Y01,
                   ymin  = ncatt_get(ncin,0)$GRID_Y00)
  nc_close(ncin)
  # transpose matrix ->t() does not work for some reasons with terra-objects
  values(terravar) <- t(ncdata)
  terra_tf <- flip(terravar, direction="vertical")# and flip terra object
  # convert to Kelvin if TRUE
  if (concKtCgeg){
    terra_tf <- terra_tf-273.15
    } 
  # set CRS WRF LCC
  crs(terra_tf) <- wrf_crs
  #reproject to geographic CRS
  terra_tf_reproj <- project(terra_tf, "+proj=longlat +datum=WGS84")
  return(terra_tf_reproj)
}
