#' @title create single Nist entries in .msp and .csv format from single scans
#' @description arrange sacn spectra in the NIST compatible spectra format
#' @param  x is a a spectralist object (spectra extracted by scans) y is the RefFeatScan object created using the nistEntry function
#' @export
#' @return  .msp and .csv Nist singles entries of pseudo-spectra
nistEntryFromScan<-function(x,y){
  ne <- 1
  envir = as.environment(ne)
  Numpeaks<-list()
  for (i in seq_along(x)){
    npeaks<-nrow(x[[i]])
    Numpeaks[[i]]<-npeaks
  }
  assign("Numpeaks", Numpeaks, envir)
  dir.create("./spectralist/")
  dir.create(paste("./spectralist/",deparse(substitute(x)), sep=""))
  spdir<-paste("./spectralist/",deparse(substitute(x)), sep="")
  for (i in 1:length(x)){
    dm<-t(data.frame(list(y[[i]], Numpeaks[[i]])))
    row.names(dm)<-c("NAME:","Num Peaks:")
    write.table(dm, paste(spdir,"/", y[[i]], ".csv",sep=""), col.names=FALSE, row.names=TRUE, quote=FALSE)
    fwrite(x[[i]],file=paste(spdir,"/", y[[i]], ".csv", sep=""),append=TRUE, sep=";")
  }


  for (i in 1:length(x)){
    dm<-t(data.frame(list(y[[i]], Numpeaks[[i]])))
    row.names(dm)<-c("NAME:","Num Peaks:")
    write.table(dm, paste(spdir,"/", y[[i]], (".msp"), sep=""),sep=" ", col.names=FALSE, row.names=TRUE, quote=FALSE)
    fwrite(x[[i]],file=paste(spdir,"/", y[[i]], (".msp"), sep=""),append=TRUE, sep=";")
  }
}
