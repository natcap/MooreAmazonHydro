# calculate sed_export sum for all of Chaglla

library(raster)
library(stringr)
library(exactextractr)
library(sf)
library(ggplot2)

# PISCO precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/annualPrecip_Chaglla_PISCO')

#2015 PISCO precip
aoi <- 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/Chaglla_dam_watershed.shp'
Chaglla_shp <- st_read(aoi)

p2015 <- raster('p_mm_PISCO_2015.tif')
p_mean_2015 <- exact_extract(p2015, Chaglla_shp, 'mean')
p_mean_2015
# 962.1685

# 1981-2020 PISCO precip
rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/annualPrecip_Chaglla_PISCO/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean)
# 962.3665 mm

df <- data.frame(p_year, p_mean, row.names = NULL)

ggplot(df, aes(x = p_year, y = p_mean)) +
  geom_point() +
  xlab("year") +
  ylab("annual precipitation (mm)") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# MIROC6 KNN SSP126
# 2015
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MIROC6_KNN_SSP126/')

Pmodel2015 <- raster('p_mm_MIROC6_KNN_ssp126_2015.tif')
p_mean_model2015 <- exact_extract(Pmodel2015, Chaglla_shp, 'mean')
p_mean_model2015
# 1,080.094

# 2015-2100 precip
rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MIROC6_KNN_SSP126/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MIROC6_KNN_SSP126 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MIROC6_KNN_SSP126[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MIROC6_KNN_SSP126)
# 983.0553 mm

p_year <- (1981:2100)
length(p_mean) <- length(p_year)

p_mean_MIROC6_KNN_SSP126_NAs <- c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, p_mean_MIROC6_KNN_SSP126)

df <- data.frame(p_year, p_mean, p_mean_MIROC6_KNN_SSP126_NAs, row.names = NULL)

ggplot(df, aes(x=p_year, y=p_mean)) + geom_line()

ggplot(df, aes(x=p_year, y=p_mean_MIROC6_KNN_SSP126_NAs)) + geom_line()

#ggplot(df, aes(x = p_year) +
#  geom_line(aes(y = df$p_mean)) +
#  geom_line(aes(y = df$p_mean_MIROC6_KNN_SSP126_NAs)) +
#  xlab("year") + ylab("annual precipitation (mm)") +
#  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)))

# MIROC6 BCSD SSP126
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MIROC6_BCSD_SSP126/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MIROC6_BCSD_SSP126/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MIROC6_BCSD_SSP126 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MIROC6_BCSD_SSP126[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MIROC6_BCSD_SSP126)
# 947.8622 mm

df <- data.frame(p_year, p_mean_MIROC6_BCSD_SSP126, row.names = NULL)

# MPI-ESM-HR KNN SSP126
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_KNN_SSP126/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_KNN_SSP126/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_HR_KNN_SSP126 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_HR_KNN_SSP126[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_HR_KNN_SSP126)
# 982.614 mm

df <- data.frame(p_year, p_mean_MPI_ESM_HR_KNN_SSP126, row.names = NULL)

# MPI-ESM-HR BCSD SSP126
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_BCSD_SSP126/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_BCSD_SSP126/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_HR_BCSD_SSP126 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_HR_BCSD_SSP126[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_HR_BCSD_SSP126)
# 947.861 mm

df <- data.frame(p_year, p_mean_MPI_ESM_HR_BCSD_SSP126, row.names = NULL)

# MPI-ESM-LR KNN SSP126
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_KNN_SSP126/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_KNN_SSP126/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_LR_KNN_SSP126 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_LR_KNN_SSP126[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_LR_KNN_SSP126)
# 972.3249 mm

df <- data.frame(p_year, p_mean_MPI_ESM_LR_KNN_SSP126, row.names = NULL)

# MPI-ESM-LR BCSD SSP126
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_BCSD_SSP126/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp126/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_BCSD_SSP126/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_LR_BCSD_SSP126 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_LR_BCSD_SSP126[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_LR_BCSD_SSP126)
# 947.8644 mm

df <- data.frame(p_year, p_mean_MPI_ESM_LR_BCSD_SSP126, row.names = NULL)

################################################################################
#SSP585
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MIROC6_KNN_SSP585/')

# MIROC6 KNN SSP585
# 2015-2100 precip
rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MIROC6_KNN_SSP585/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MIROC6_KNN_SSP585 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MIROC6_KNN_SSP585[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MIROC6_KNN_SSP585)
# 975.1818 mm

p_year <- (1981:2100)
length(p_mean) <- length(p_year)

p_mean_MIROC6_KNN_SSP585_NAs <- c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, p_mean_MIROC6_KNN_SSP585)

df <- data.frame(p_year, p_mean, p_mean_MIROC6_KNN_SSP585_NAs, row.names = NULL)

ggplot(df, aes(x=p_year, y=p_mean)) + geom_line()

ggplot(df, aes(x=p_year, y=p_mean_MIROC6_KNN_SSP585_NAs)) + geom_line()

# MIROC6 BCSD SSP585
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MIROC6_BCSD_SSP585/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MIROC6_BCSD_SSP585/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MIROC6_BCSD_SSP585 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MIROC6_BCSD_SSP585[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MIROC6_BCSD_SSP585)
# 947.8622 mm

df <- data.frame(p_year, p_mean_MIROC6_BCSD_SSP585, row.names = NULL)

# MPI-ESM-HR KNN SSP585
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_KNN_SSP585/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_KNN_SSP585/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_HR_KNN_SSP585 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_HR_KNN_SSP585[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_HR_KNN_SSP585)
# 958.0288 mm

df <- data.frame(p_year, p_mean_MPI_ESM_HR_KNN_SSP585, row.names = NULL)

# MPI-ESM-HR BCSD SSP585
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_BCSD_SSP585/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_HR_BCSD_SSP585/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_HR_BCSD_SSP585 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_HR_BCSD_SSP585[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_HR_BCSD_SSP585)
# 947.8612 mm

df <- data.frame(p_year, p_mean_MPI_ESM_HR_BCSD_SSP585, row.names = NULL)

# MPI-ESM-LR KNN SSP585
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_KNN_SSP585/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_KNN_SSP585/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_LR_KNN_SSP585 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_LR_KNN_SSP585[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_LR_KNN_SSP585)
# 986.185 mm

df <- data.frame(p_year, p_mean_MPI_ESM_LR_KNN_SSP126, row.names = NULL)

# MPI-ESM-LR BCSD SSP585
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_BCSD_SSP585/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/annualPrecip_Chaglla_MPI_ESM1_2_LR_BCSD_SSP585/', pattern = ".tif$")

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_LR_BCSD_SSP585 <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_LR_BCSD_SSP585[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_LR_BCSD_SSP585)
# 947.8634 mm

df <- data.frame(p_year, p_mean_MPI_ESM_LR_BCSD_SSP126, row.names = NULL)

################################################################################
################################################################################
# MPI-ESM-HR KNN historical
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_HR_KNN_historical/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_HR_KNN_historical/', pattern = ".tif$")
rasterlist

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_HR_KNN_historical <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_HR_KNN_historical[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_HR_KNN_historical)
# 972.2226 mm

df <- data.frame(p_year, p_mean_MPI_ESM_HR_KNN_historical, row.names = NULL)

##########################################################
# MPI-ESM-HR BCSD historical
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_HR_BCSD_historical/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_HR_BCSD_historical/', pattern = ".tif$")
rasterlist

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_HR_BCSD_historical <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_HR_BCSD_historical[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_HR_BCSD_historical)
# 950.764 mm

df <- data.frame(p_year, p_mean_MPI_ESM_HR_BCSD_historical, row.names = NULL)

##########################################################
# MPI-ESM-LR KNN historical
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_LR_KNN_historical/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_LR_KNN_historical/', pattern = ".tif$")
rasterlist

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_LR_KNN_historical <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_LR_KNN_historical[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_LR_KNN_historical)
# 984.2049 mm

df <- data.frame(p_year, p_mean_MPI_ESM_LR_KNN_historical, row.names = NULL)

##########################################################
# MPI-ESM-LR BCSD historical
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_LR_BCSD_historical/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MPI_LR_BCSD_historical/', pattern = ".tif$")
rasterlist

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MPI_ESM_LR_BCSD_historical <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MPI_ESM_LR_BCSD_historical[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MPI_ESM_LR_BCSD_historical)
# 950.7679 mm

df <- data.frame(p_year, p_mean_MPI_ESM_LR_BCSD_historical, row.names = NULL)

##########################################################
# MIROC6 BCSD historical
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MIROC6_BCSD_historical/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MIROC6_BCSD_historical/', pattern = ".tif$")
rasterlist

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MIROC6_BCSD_historical <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MIROC6_BCSD_historical[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MIROC6_BCSD_historical)
# 950.768 mm

df <- data.frame(p_year, p_mean_MIROC6_BCSD_historical, row.names = NULL)

##########################################################
# MIROC6 KNN historical
# 2015-2100 precip
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MIROC6_KNN_historical/')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/historical/pr/annualPrecip_Chaglla_MIROC6_KNN_historical/', pattern = ".tif$")
rasterlist

p_number <- length(rasterlist)
p_year <- character(length = p_number)
p_mean_MIROC6_KNN_historical <- double(length = p_number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  p_mean_MIROC6_KNN_historical[i] <- exact_extract(R, Chaglla_shp, 'mean')
  p_year[i] <- substr(rasterlist[i], nchar(rasterlist[i]) - 7, nchar(rasterlist[i]) - 4)
  
}

mean(p_mean_MIROC6_KNN_historical)
# 985.943 mm

df <- data.frame(p_year, p_mean_MIROC6_KNN_historical, row.names = NULL)

##########################################################
# PISCO erosivity
setwd('G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/erosivityOutputs')

rasterlist <- list.files(path = 'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Observation data(PISTCO)/PISCO - Climate Data/Daily Precipitation (Inestable)/erosivityOutputs', pattern = ".tif$")

number <- length(rasterlist)
erosivityPISCO <- double(length = number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  erosivityPISCO[i] <- exact_extract(R, Chaglla_shp, 'mean')
  
}

mean(erosivityPISCO)
# 1,528.665
#compared to mean of 2,252 for (n = 1,032) forecasts


# PISCO sediment export
setwd('C:/Users/jgldstn/Documents/MooreAmazonHydro/PISCO')

rasterlist <- list.files(path = 'C:/Users/jgldstn/Documents/MooreAmazonHydro/PISCO/', pattern = "^sed_export_Kb_3_0_IC0_0_1_SDRmax_1_0_")

number <- length(rasterlist)
sedExportPISCO <- double(length = number)

for (i in 1:length(rasterlist)) { #for each raster in rasterlist
  R <- raster(rasterlist[i])
  sedExportPISCO[i] <- cellStats(R, 'sum')
  
}

mean(sedExportPISCO)
# 7,073,641 annual tons

