#create summary table as CSV for SSP126 erosivity rasters
library(stringr)
library(sf)
library(raster)
library(sp)
library(exactextractr)

setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/')
rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/', pattern = "[^xml|^aligned].tif$")

SSPlist <- c('ssp126', 'ssp585')
GCMlist <- c('MIROC6', 'MPI_ESM1_2_HR', 'MPI_ESM1_2_LR')
DSlist <- c('BCSD', 'KNN')

r_number <- length(rasterlist)

r_SSP <- character(length = r_number)
r_GCM <- character(length = r_number)
r_DS <- character(length = r_number)
r_year <- character(length = r_number)

r_mean <- double(length = r_number)
r_q5 <- double(length = r_number)
r_q95 <- double(length = r_number)

aoi <- 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/Chaglla_dam_watershed.shp'
Chaglla_shp <- st_read(aoi)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  #r_mean[i] <- cellStats(R, 'mean') #Use when not clipping, instead of using the next line
  r_mean[i] <- exact_extract(R, Chaglla_shp, 'mean')
  r_q5[i] <- quantile(R, 0.05)
  r_q95[i] <- quantile(R, 0.95)
  
  r_SSP[i] <- SSPlist[str_detect(rasterlist[i], SSPlist)]
  r_GCM[i] <- GCMlist[str_detect(rasterlist[i], GCMlist)]
  r_DS[i] <- DSlist[str_detect(rasterlist[i], DSlist)]
  r_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

df <- data.frame(r_SSP, r_GCM, r_DS, r_year, r_q5, r_mean, r_q95, row.names = NULL)

write.csv(df, 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/erosivityOutputs/R_summaryStatsClipped_SSP126.csv', row.names = F)

####################################################################################################
#create summary table as CSV for SSP585 erosivity rasters

setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/')
rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/', pattern = "[^xml|^aligned].tif$")

SSPlist <- c('ssp126', 'ssp585')
GCMlist <- c('MIROC6', 'MPI_ESM1_2_HR', 'MPI_ESM1_2_LR')
DSlist <- c('BCSD', 'KNN')

r_number <- length(rasterlist)

r_SSP <- character(length = r_number)
r_GCM <- character(length = r_number)
r_DS <- character(length = r_number)
r_year <- character(length = r_number)

r_mean <- double(length = r_number)
r_q5 <- double(length = r_number)
r_q95 <- double(length = r_number)

aoi <- 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/Chaglla_dam_watershed.shp'
Chaglla_shp <- st_read(aoi)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  #r_mean[i] <- cellStats(R, 'mean') #Use when not clipping in line immediately below
  r_mean[i] <- exact_extract(R, Chaglla_shp, 'mean')
  r_q5[i] <- quantile(R, 0.05)
  r_q95[i] <- quantile(R, 0.95)
  
  r_SSP[i] <- SSPlist[str_detect(rasterlist[i], SSPlist)]
  r_GCM[i] <- GCMlist[str_detect(rasterlist[i], GCMlist)]
  r_DS[i] <- DSlist[str_detect(rasterlist[i], DSlist)]
  r_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

df <- data.frame(r_SSP, r_GCM, r_DS, r_year, r_q5, r_mean, r_q95, row.names = NULL)

write.csv(df, 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/R_summaryStatsClipped_SSP585.csv', row.names = F)
