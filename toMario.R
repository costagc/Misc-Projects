#####carregar os pacotes necessarios#####
library(rgdal)
library(raster)
####abre o shape da IUCN####
poligonos <- readOGR(dsn='/Users/gabriel/Documents/Dados/Dados Distribuição/Distribuição IUCN/AMPHANURA',layer='Amphibians_Anura')

####cria vetor com o nome das especies#####
especies <- sort(unique(poligonos@data$BINOMIAL))

####Cria raster em branco para referencia####
r <- raster()
res(r) <- 3 #### Obs. tem que alterar para resolucao desejada

#### Rasterizar todos poligonos das especies e criar stack#########
x <- stack()
for (i in 1:length(especies)){
  mapa <- subset(poligonos, poligonos@data$BINOMIAL == especies[i])
  mapa.raster <- rasterize(mapa,r,field=1,background=NA)
  names(mapa.raster) <- especies[i]
  x <- stack(x,mapa.raster)
}
#####criar raster de riqueza#######
rich <- sum(x, na.rm=T)
plot(rich)

#####criar matriz siteXspp#####
pa <- as.data.frame(x)
xy <- xyFromCell(x[[1]],1:ncell(x[[1]]))
siteXspp <- cbind(xy,pa)









