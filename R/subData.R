# Name: Nikoula, Latifah & Nikos
# Date: 8 January 2015

# The function modifies the extent of two raster objects then it performs a substraction. to assess the change in NDVI over time

ndviTrend <- function (x, y) {
  # @param x & y raster object
  
  ext <- intersect(extent(x), extent(y))
  cropx <- crop(x, ext)
  cropy <- crop(y, ext)
  # substraction of the two raster objects
  diffndvi <- cropy - cropx
  return(diffndvi)
}