#Rainfall erosivity rasters creation from precipitation rasters in NetCDF for SOUTH AMERICA using formula from Riquetti et al. 2020 https://doi.org/10.1016/j.scitotenv.2020.138315
#DEM, latitutde, and longitude rasters are additional required inputs

#2 downscaling techniques:
#KNN: K-Nearest Neighbor; K = subset of days (similar to the feature day) and
#BCSD: Bias-Correction Spatial Disaggregation

#3 GCMs:
#MIROc6, MPI ESM 1-2 HR (high resolution), and MPI ESM 1-2 LR (low resolution)

#2 SSPs (Shared Socioeconomic Pathways):
#SSP126 and SSP585

require(ncdf4)
require(raster)
library(lubridate)

setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/')

## Import a netCDF file
# MIROC6 KNN SSP126
file.nc <- 'pr_day_MIROC6_KNN_ssp126_20150101-21001231.nc' #KNN: K-Nearest Neighbor; K = subset of days (similar to the feature day)

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

DEM <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/DEM_aligned.tif')

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MIROC6_KNN_SSP126/p_mm_MIROC6_KNN_ssp126_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
lat <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/lat_aligned.tif')
lon <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/lon_aligned.tif')

for (i in unique(years)){

  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity

  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_MIROC6_KNN_ssp126_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

#########################################################################################
############################################################################
## import NetCDF file
#MIROC6 BCSD SSP126
file.nc <- 'pr_day_MIROC6_Bcsdprecipitation_ssp126_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MIROC6_BCSD_SSP126/p_mm_MIROC6_BCSD_ssp126_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_MIROC6_BCSD_ssp126_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

############################################################
## import NetCDF file
#MPI ESM1-2 HR KNN SSP126
file.nc <- 'pr_day_MPI-ESM1-2-HR_KNN_ssp126_20150101-21001231.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_KNN_SSP126/p_mm_MPI_ESM1_2_HR_KNN_SSP126_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_MPI_ESM1_2_HR_KNN_ssp126_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

####################################################################
## import NetCDF file
#MPI ESM1-2 HR BCSD SSP126
file.nc <- 'pr_day_MPI-ESM1-2-HR_Bcsdprecipitation_ssp126_20150101-21001231.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_BCSD_SSP126/p_mm_MPI_ESM1_2_HR_BCSD_SSP126_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_MPI_ESM1_2_HR_BCSD_ssp126_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

####################################################################
## import NetCDF file
#MPI ESM1-2 LR KNN SSP126
file.nc <- 'pr_day_MPI-ESM1-2-LR_KNN_ssp126_20150101-21001231.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_KNN_SSP126/p_mm_MPI_ESM1_2_LR_KNN_SSP126_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_MPI_ESM1_2_LR_KNN_ssp126_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

####################################################################
## import NetCDF file
#MPI ESM1-2 LR BCSD SSP126
file.nc <- 'pr_day_MPI-ESM1-2-LR_Bcsdprecipitation_ssp126_20150101-21001231.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_BCSD_SSP126/p_mm_MPI_ESM1_2_LR_BCSD_SSP126_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_MPI_ESM1_2_LR_BCSD_ssp126_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

#######################################################################################
#######################################################################################
#switch to SSP 585

setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/')
getwd()

## Import a netCDF file
#MIROC6 BCSD SSP585
file.nc <- 'pr_day_MIROC6_Bcsdprecipitation_ssp585_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

DEM <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/DEM_aligned.tif')

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MIROC6_BCSD_SSP585/p_mm_MIROC6_BCSD_ssp585_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_MIROC6_BCSD_ssp585_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###########################################################################################
## Import a netCDF file
#MIROC6 KNN SSP585
file.nc <- 'pr_day_MIROC6_KNN_ssp585_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MIROC6_KNN_SSP585/p_mm_MIROC6_KNN_ssp585_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_MIROC6_KNN_ssp585_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###########################################################################################
## Import a netCDF file
#MPI ESM1-2 HR BCSD SSP585
file.nc <- 'pr_day_MPI-ESM1-2-HR_Bcsdprecipitation_ssp585_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_BCSD_SSP585/p_mm_MPI_HR_BCSD_ssp585_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_MPI_ESM1_2_HR_BCSD_ssp585_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###########################################################################################
## Import a netCDF file
#MPI ESM1-2 HR KNN SSP585
file.nc <- 'pr_day_MPI-ESM1-2-HR_KNN_ssp585_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_KNN_SSP585/p_mm_MPI_HR_KNN_ssp585_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_MPI_ESM1_2_HR_KNN_ssp585_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###########################################################################################
## Import a netCDF file
#MPI ESM1-2 LR BCSD SSP585
file.nc <- 'pr_day_MPI-ESM1-2-LR_Bcsdprecipitation_ssp585_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_BCSD_SSP585/p_mm_MPI_LR_BCSD_ssp585_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_MPI_ESM1_2_LR_BCSD_ssp585_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###########################################################################################
## Import a netCDF file
#MPI ESM1-2 LR KNN SSP585
file.nc <- 'pr_day_MPI-ESM1-2-LR_KNN_ssp585_20150101-21001231.nc' #BCSD: Bias-Correction Spatial Disaggregation

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_KNN_SSP585/p_mm_MPI_LR_KNN_ssp585_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_MPI_ESM1_2_LR_KNN_ssp585_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###########################################################################################
###########################################################################################
# Historical (backcasts)
## Import a NetCDF file
#MIROC6 BCSD historical

setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/')

file.nc <- 'annual_precip_MIROC6_BCSD_historical.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MIROC6_BCSD_historical/p_mm_MIROC6_BCSD_historical_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/erosivityOutputs/R_MIROC6_BCSD_historical_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###################################################################################
#MIROC6 KNN historical

file.nc <- 'annual_precip_MIROC6_KNN_historical.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MIROC6_KNN_historical/p_mm_MIROC6_KNN_historical_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/erosivityOutputs/R_MIROC6_KNN_historical_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###################################################################################
#MPI HR KNN historical

file.nc <- 'annual_precip_MPI_HR_KNN_historical.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_HR_KNN_historical/p_mm_MPI_HR_KNN_historical_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/erosivityOutputs/R_MPI_HR_KNN_historical_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###################################################################################
#MPI HR BCSD historical

file.nc <- 'annual_precip_MPI_HR_BCSD_historical.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_HR_BCSD_historical/p_mm_MPI_HR_BCSD_historical_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/erosivityOutputs/R_MPI_HR_BCSD_historical_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###################################################################################
#MPI LR BCSD historical

file.nc <- 'annual_precip_MPI_LR_BCSD_historical.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_LR_BCSD_historical/p_mm_MPI_LR_BCSD_historical_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/erosivityOutputs/R_MPI_LR_BCSD_historical_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

###################################################################################
#MPI LR KNN historical

file.nc <- 'annual_precip_MPI_LR_KNN_historical.nc'

r.rain <- brick(file.nc)

rawdate <- getZ(r.rain)
years <- as.numeric(format(rawdate, format = '%Y'))

i <- unique(years)

# write annual precip rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  writeRaster(yearly_p_32718,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_LR_KNN_historical/p_mm_MPI_LR_KNN_historical_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)
  
}

# write (annual) erosivity rasters
for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  
  yearly_p_32718 <- projectRaster(from = yearly_p, to = DEM, method = "bilinear")
  
  logErosivity <- (0.2753)+(0.02266*lon)+((-0.00017067)*lon*lat)+(0.657733*log(yearly_p_32718))+(0.000000060497*DEM*yearly_p_32718)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/erosivityOutputs/R_MPI_LR_KNN_historical_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}








