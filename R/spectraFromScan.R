#' @title spectra From Scan
#' @param x is a RefFeat object obtained from storeRefFeat function
#' @description the function extract spectra from scans based on pseudospectra calculated in xcms
#'         by giving an input file, scans corresponding to pseudo spectra are extracted and arranged in a list
#' @export
#' @return spectralist
spectraFromScan <- function(x) {
  ne <- 1
  envir = as.environment(ne)
  spF <- choose.files(default =paste0(getwd(), "/*.*") , caption = "Select 1 file to       extract spectra from",multi = FALSE)
  assign("spF", spF, envir)
  psf <- list(spF)
  rawSpF<- xcmsRaw(spF, profstep= 0.1, profmethod='bin', includeMSn= FALSE, mslevel= NULL,scanrange= NULL)

  spectraSet<-list()
  for (i in seq_along(xs_an@pspectra)){
    specgroups<-PksAn[c(xs_an@pspectra[[i]]),]
    spectraSet[[i]]<-specgroups
  }
  lSP<-vector()
  for(i in seq_along(spectraSet)){
    LoneSpectra<-(nrow(spectraSet[[i]]))==1
    lSP<-c(lSP, LoneSpectra)
    lonespec<-which(lSP==TRUE)
  }
  curSpectraSet<-spectraSet[-c(lonespec)]
  spectralist<-list()
  for(i in seq_along(curSpectraSet)){
    rtRange<-c(min(curSpectraSet[[i]][,5]),max(curSpectraSet[[i]][,6]))
    scans<-which(rawSpF@scantime>=min(curSpectraSet[[i]][,5])    &  rawSpF@scantime<=max(curSpectraSet[[i]][,6]))
    if(length(scans)> 1){
      scans<-scans
    }else{
      scans<-NULL
    }
    tfg<-data.frame(getSpec(rawSpF, mzrange=c(mzStart, mzEnd), rtrange=rtRange, scanrange= scans))
    spectralist[[i]]<-tfg
    spectralist[[i]][is.na(spectralist[[i]])]<-0
  }
  eS<-which(lapply(spectralist, function(y) {nrow(y) == 0})==TRUE)
  eS2<-which(lapply(RefFeatScan, function(z) {is_empty(z)})==TRUE)
  assign("eS", eS, envir)
  assign("eS2", eS2, envir)
  if(length(eS)==0){
    spectralist<-spectralist
    RefFeatScan<-x
  }else{
    spectralist<-spectralist[-c(eS)]
    RefFeatScan<-x[-c(eS)]
  }
  if(length(eS2)==0){
    spectralist<-spectralist
    RefFeatScan<-RefFeatScan
  }else{
    spectralist<-spectralist[-c(eS2)]
    RefFeatScan<-RefFeatScan[-c(eS2)]
  }


  assign("RefFeatScan", RefFeatScan, envir)
  assign("spectralist", spectralist, envir)
  return(spectralist)
}
