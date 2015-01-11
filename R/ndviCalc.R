# Name: Nikoula, Latifah & Nikos
# Date: 8 January 2015

# calculate the value of NDVI and return a RasterLayer. The function supports only Landsat 5 and 8.

ndviCalc <- function(x, sensor) { 
  # @param sensor Character. Sensor can be either "TM"or "LC" for Landsat 5 and Landsat 8, respectively.
  if(sensor == "TM") { 
    ndvi <- (raster(x[7]) - raster(x[6])) / (raster(x[7]) + raster(x[6])) 
  } else if (sensor == "LC") { 
    ndvi <- (raster(x[6]) - raster(x[5])) / (raster(x[6]) +raster(x[5]) )
  } 
  
  else {
    stop('The sensor is neither TM nor LC; this type is not supported.')
  }
  return(ndvi)
} 