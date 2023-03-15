#Rainfall erosivity rasters creation from precipitation rasters in NetCDF for SOUTH AMERICA using formula from Riquetti et al. 2020 https://doi.org/10.1016/j.scitotenv.2020.138315
#DEM, latitutde, and longitude rasters are additional required inputs

require(ncdf4)
require(raster)
library(lubridate)
library(sf)

setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/')

## Input: a netCDF file
file.nc <- 'PISCOpd.nc'

## Import netCDF
r.rain <- brick(file.nc)

DEM <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/DEM_aligned.tif')

r.rain_EPSG32718 <- projectRaster(from = r.rain, to = DEM, method = "bilinear")

rawdate <- getZ(r.rain)
years <- year(as.Date(rawdate, origin = "1981-01-01")) #extract YEARs b/c rawdate is formatted as an ARRAY of Julian Day values starting on 01Jan1981, not DATES like the other netCDFs

i <- unique(years)

# write annual precip rasters - PISCO

for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain_EPSG32718, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE

  writeRaster(yearly_p,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/annualPrecip_Chaglla_PISCO/p_mm_PISCO_', i, sep='') # units: mm
              , format = 'GTiff'
              , overwrite = T)

}

# write (annual) erosivity rasters - PISCO

lat <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/lat_aligned.tif')
lon <- raster('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/lon_aligned.tif')

aoi <- 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/Chaglla_dam_watershed.shp'
Chaglla_shp <- st_read(aoi)

for (i in unique(years)){
  
  yearly_p <- stackApply(r.rain_EPSG32718, years==i, fun = sum)
  yearly_p <- yearly_p$index_TRUE
  lat_aligned <- resample(lat, yearly_p, method = 'bilinear')
  lon_aligned <- resample(lon, yearly_p, method = 'bilinear')
  DEM_aligned <- resample(DEM, yearly_p, method = 'bilinear')
  
  logErosivity <- (0.2753)+(0.02266*lon_aligned)+((-0.00017067)*lon_aligned*lat_aligned)+(0.657733*log(yearly_p))+(0.000000060497*DEM_aligned*yearly_p)
  Erosivity <- 10**logErosivity
  
  writeRaster(Erosivity,
              filename = paste('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/erosivityOutputs/R_PISCO_', i, sep='') # units: MJ*mm / ha*hr*yr
              , format = 'GTiff'
              , overwrite = T)
  
}

