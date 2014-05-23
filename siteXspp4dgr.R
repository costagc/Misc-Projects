library(raster)
spp <- list.files('~/Documents/Dados/Dados Distribuição/Mammals Carlo Rescaled 1dgr',pattern='.grd')
labels <- gsub('.grd','',spp)

bio <- stack(list.files('~/Documents/Dados/Bioclimatic Variables/bioclim',pattern='.bil',full.names=T))
bio4dgr <- aggregate(bio,24)

all.sp <- stack()
for (i in 1:length(spp)){
  mapa <- raster(paste('~/Documents/Dados/Dados Distribuição/Mammals Carlo Rescaled 1dgr/',
                       spp[i],sep=''))
  mapa.4dgr <- aggregate(mapa,fact=4,fun='max')
  names(mapa.4dgr) <- labels[i]
  all.sp <- stack(all.sp,mapa.4dgr)
}

rich <- sum(all.sp, na.rm=T)
plot(rich)

bio.mol <- projectRaster(bio4dgr,all.sp)

sp.env <- stack(bio.mol,all.sp)

pa <- as.data.frame(sp.env)
xy <- xyFromCell(sp.env[[1]],1:ncell(sp.env[[1]]))
siteXspp <- cbind(xy,pa)
head(siteXspp[,1:21])
length(siteXspp)
siteXspp$rich <- rowSums(siteXspp[,22:length(siteXspp)])

siteXspp4dg <- subset(siteXspp, rich > 1)
source('/Users/gabriel/hubiC/Documents/Coisas do R/functions/DFtoRaster.R')

rich.clean <- DFtoRaster(siteXspp4dg,d=5162)
plot(rich.clean)

siteXspp4dg <- siteXspp4dg[,-5162]


write.csv(siteXspp4dg,'~/Documents/Dados/Dados Distribuição/Mammals SiteXSpp 4dgr/siteXsppXenv_4dgr.csv',row.names=F)




