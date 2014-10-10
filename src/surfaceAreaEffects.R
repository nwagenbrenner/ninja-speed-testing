library(raster)
library(ggplot2)

r<-raster('/home/natalie/ninja_speed_test/salmonriver_dem.tif') #utm
#r<-raster('/home/natalie/ninja_speed_test/salmonriver_dem_latlong.tif') #latlong

rr<-r
#sa for r = 65118624
values(rr) <- values(r) * 0.9 # sa = 63282835
values(rr) <- values(r) * 0.7 # sa = 60008757
values(rr) <- values(r) * 0.5 # sa = 57364109
values(rr) <- values(r) * 0.3 # sa = 55482219
values(rr) <- values(r) * 0.1 # sa = 54495563
values(rr) <- values(r) * 0.0 # sa = 
values(rr) <- 1500.0 #sa = 54369671

writeRaster(rr, filename='salmonriver_dem_0.0.tif', format='GTiff')

rr.matrix<-as.matrix(rr)

cellx <- res(rr)[1]
celly <- res(rr)[2]
sa<-surfaceArea(rr.matrix, cellx, celly)


r.matrix<-as.matrix(r)

cellx <- res(r)[1]
celly <- res(r)[2]
sa<-surfaceArea(r.matrix, cellx, celly)

#==================================================================
#  read in windninja output
#==================================================================
r.spd<-raster('salmonriver_dem_220_5_54m_vel.asc')
r.spd0.9<-raster('salmonriver_dem_0.9_220_5_54m_vel.asc')
r.spd0.7<-raster('salmonriver_dem_0.7_220_5_54m_vel.asc')
r.spd0.5<-raster('salmonriver_dem_0.5_220_5_54m_vel.asc')
r.spd0.3<-raster('salmonriver_dem_0.3_220_5_54m_vel.asc')
r.spd0.1<-raster('salmonriver_dem_0.1_220_5_54m_vel.asc')
r.spd0.0<-raster('salmonriver_dem_0.0_220_5_54m_vel.asc')

r.spd<-raster('salmonriver_dem_220_5_08-13-2010_0700_54m_vel.asc')
r.spd0.9<-raster('salmonriver_dem_0.9_220_5_08-13-2010_0700_54m_vel.asc')
r.spd0.7<-raster('salmonriver_dem_0.7_220_5_08-13-2010_0700_54m_vel.asc')
r.spd0.5<-raster('salmonriver_dem_0.5_220_5_08-13-2010_0700_54m_vel.asc')
r.spd0.3<-raster('salmonriver_dem_0.3_220_5_08-13-2010_0700_54m_vel.asc')
r.spd0.1<-raster('salmonriver_dem_0.1_220_5_08-13-2010_0700_54m_vel.asc')
r.spd0.0<-raster('salmonriver_dem_0.0_220_5_08-13-2010_0700_54m_vel.asc')

spd.mean<-c(mean(values(r.spd)), mean(values(r.spd0.9)), mean(values(r.spd0.7)), mean(values(r.spd0.5)), mean(values(r.spd0.3)), mean(values(r.spd0.1)), mean(values(r.spd0.0)))
surface.area<-c(65118624, 63282835, 60008757, 57364109, 55482219, 54495563, 54369671)

spd.sa<-as.data.frame(cbind(spd.mean, surface.area))

surface.area.km <- spd.sa$surface.area*1E-6
spd.sa<-cbind(spd.sa, surface.area.km)

p<-ggplot(spd.sa, aes(x=surface.area.km, y=spd.mean)) +
        geom_point(shape=19, size=1.5, alpha = 1) +
        xlab("Surface Area (km^2)") + ylab("Mean Predicted Speed (m/s)") +
        theme_bw() +
        ggtitle("diurnal off")

   



