# Name: Nikoula, Latifah & Nikos
# Date: 8 January 2015

# The Function is a replacement function taking into consideration two input parameters.  
## Complete details are provided in http://code.google.com/p/fmask/. 

cloudMask <- function(x, y){
  # @param x RasterLayer.
  # @param y cloud mask. 
   x[y != 0] <- NA
  # replace the x value in which the y value not equal to 0 to NA 
  return(x)
}
