# Name: Nikoula, Latifah & Nikos
# Date: 8 January 2015

# The function plots together the cloud free NDVI rasters. In addition, it plots
## the change of NDVI between the two years by using plot and ggplot2, respectively

plot_result <- function(x,y,z) {
  opar <- par(mfrow=c(1,2))
  plot(x, zlim= c(-0.2, 1), main= "Cloud free NDVI of 1990")
  plot(y, zlim= c(-0.2, 1), main= "Cloud free NDVI of 2014")
  par(opar)
  plot(z, zlim= c(-1.5, 1.5), main="NDVI changes from 1990 to 2014")
  
#convert the raster to points for plotting
map.p <- rasterToPoints(z)
  
#Make the points a dataframe for ggplot
df <- data.frame(map.p)

#Make appropriate column headings
colnames(df) <- c("Longitude", "Latitude", "Value")

#crate map with ggplot
ggplot(aes(x = Longitude, y = Latitude, fill = Value), data = df) + 
  geom_raster() + coord_equal() + 
  ggtitle("Normalized Difference Vegetation Index 2014/04/19 - 1990/04/08") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))+
  scale_fill_continuous(low="red", high="green", limits=c(-1.5,1.5)) +
  labs(fill = "NDVI")  +
  theme_bw()
}


