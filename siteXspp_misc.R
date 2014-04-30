one.dgr <- read.csv('~/Dropbox/Mammal Data/siteXsppXenv_1dgr.csv')
two.dgr <- read.csv('~/Dropbox/Mammal Data/siteXsppXenv_2dgr.csv')

trait <- read.table('~/Dropbox/Mammal Data/imputedmammals28apr14.txt',h=T)
head(trait)

sub.one.dgr <- subset(one.dgr, select=colnames(one.dgr) %in% trait$IUCN.binomial)
sub.fin <- cbind(one.dgr[,1:21],sub.one.dgr)
head(sub.fin[,1:22])



sub.2.dgr <- subset(two.dgr, select=colnames(two.dgr) %in% trait$IUCN.binomial)
sub.fin2 <- cbind(two.dgr[,1:21],sub.2.dgr)



write.csv(sub.fin2,'~/Dropbox/Mammal Data/siteXsppXenv_sub_2dgr.csv',row.names=F)
