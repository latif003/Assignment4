# Name: Nikoula, Latifah & Nikos
# Date: 8 January 2015

# clean the workspace
rm(list=ls())
ls()

# package
library (raster)
library(rgdal)

# make sure the data directory
getwd()

# list files
# LC8 corrsponds to a Landsat 8 image of 2014-04-19 while LT5 corresponds to Landsat 5 image of 1990-04-08
LC8 <- list.files ('data/LC81970242014109-SC20141230042441.tar', pattern = glob2rx('*.tif'), full.names = TRUE)
LT5 <- list.files ('data/LT51980241990098-SC20150107121947.tar', pattern = glob2rx('*.tif'), full.names = TRUE)

# calculate ndvi
ndvi1990 <- overlay(x=raster(LT5[6]), y=raster(LT5[7]), fun=ndviCalc)
ndvi2014 <- overlay(x=raster(LC8[5]), y=raster(LC8[6]), fun=ndviCalc)

# remove cloud cover
cloudfree1990 <- overlay(x=ndvi1990, y=raster(LT5[1]), fun=cloudMask)
cloudfree2014 <- overlay(x=ndvi2014, y=raster(LC8[1]), fun=cloudMask)

# specify the extent by using intersect
ext <- intersect(extent(cloudfree1990), extent(cloudfree2014))
cropLT5 <- crop(cloudfree1990, ext)
cropLC8 <- crop(cloudfree2014, ext)

# assess the ndvi value change from 1990 to 2014
diffndvi <- cropLC8 - cropLT5

# kml file
ndviCampus <- projectRaster(diffndvi, crs='+proj=longlat')
KML(x=ndviCampus, filename='wageningenNDVI.kml')

# plot some results
op <- par(mfrow=c(2, 2))
plot(ndvi1990, zlim= c(-0.2, 1), main= "NDVI of 1990")
plot(ndvi2014, zlim= c(-0.2, 1), main= "NDVI of 2014")
plot(cloudfree1990, zlim= c(-0.2, 1), main="NDVI of 1990 after remove clouds")
plot(cloudfree2014, zlim= c(-0.2, 1), main="NDVI of 2014 after remove clouds")

#plot the difference
plot(diff, zlim= c(-2, 2), main="NDVI changes from 1990 to 2014")