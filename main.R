# Name: Nikoula, Latifah & Nikos
# Date: 8 January 2015

#  A complete pre-processing chain for a bi-temporal comparison of two NDVI images of Wageningen, 

rm(list=ls()) # clear the workspace

# load libraries
library (raster)
library(rgdal)
library(ggplot2)

getwd()# make sure the data directory

# call the functions
source('R/cloudMask.R')
source('R/ndviCalc.R')
source('R/plot_result.R')
source('R/subData.R')

#import data
# LC8 corresponds to a Landsat 8 image of 2014-04-19 while LT5 corresponds to Landsat 5 image of 1990-04-08
LC8 <- list.files ('data/LC81970242014109-SC20141230042441/', pattern = glob2rx('*.tif'), full.names = TRUE)
LT5 <- list.files ('data/LT51980241990098-SC20150107121947/', pattern = glob2rx('*.tif'), full.names = TRUE)

# calculate ndvi
ndvi1990 <- ndviCalc(LT5,"TM")
ndvi2014 <- ndviCalc(LC8,"LC")
ndvi2014 <- ndviCalc(LC8,"Hyperion")

# Applying a cloud mask
cf1990 <- overlay(x=ndvi1990, y=raster(LT5[1]), fun=cloudMask)
cf2014 <- overlay(x=ndvi2014, y=raster(LC8[1]), fun=cloudMask)

#calculate the change between two years
change <-ndviTrend(cf1990,cf2014)

#plot some results
plot_result(cf1990,cf2014, change)

# kml file
ndviCampus <- projectRaster(change, crs='+proj=longlat')
KML(x=ndviCampus, filename='wageningenNDVI.kml')
****************************************************