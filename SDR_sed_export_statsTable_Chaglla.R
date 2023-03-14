#create summary table as CSV for SDR sed_export rasters
library(raster)
library(stringr)

setwd('G:/Shared drives/Moore Amazon Hydro/3_model_outputs_postprocessing/LU_scenarios_SDR_sedExport_results_Chaglla/baseline/')
rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/3_model_outputs_postprocessing/LU_scenarios_SDR_sedExport_results_Chaglla/baseline/', pattern = ".tif$")
rasterlist

SSPlist <-  c('ssp126', 'ssp585')
GCMlist <- c('MIROC6', 'MPI_ESM1_2_HR', 'MPI_ESM1_2_LR')
#GCMlist <- c('MIROC6', 'MPI_HR', 'MPI_LR')
DSlist <- c('BCSD', 'KNN')

r_number <- length(rasterlist)

r_SSP <- character(length = r_number)
r_GCM <- character(length = r_number)
r_DS <- character(length = r_number)
r_year <- character(length = r_number)

r_sum <- double(length = r_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  r_sum[i] <- cellStats(R, 'sum')
  
  r_SSP[i] <- SSPlist[str_detect(rasterlist[i], SSPlist)]
  
  r_GCM[i] <- GCMlist[str_detect(rasterlist[i], GCMlist)]
  r_DS[i] <- DSlist[str_detect(rasterlist[i], DSlist)]
  r_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(r_sum)

df <- data.frame(r_SSP, r_GCM, r_DS, r_year, r_sum, row.names = NULL)
#df <- data.frame(r_GCM, r_DS, r_year, r_sum, row.names = NULL)

write.csv(df, 'G:/Shared drives/Moore Amazon Hydro/3_model_outputs_postprocessing/LU_scenarios_SDR_sedExport_results_Chaglla/baseline/baseline_sedExport_SUM_Chaglla.csv', row.names = F)
