#' @title storeRefFeat
#' @description the function stores the feature names
#' @export
#' @return RefFeat
storeRefFeat<-function(){
  ne <- 1
  envir = as.environment(ne)
  spectrafile = dlgInput(message = "Enter the name of the file to get the spectra from",default = "file", gui = .GUI)$res
  assign("spectrafile", spectrafile, envir)
  col_sps<-colnames(PksAn)
  sps_sel<-which(col_sps %in% spectrafile)
  test<-xs_an@pspectra
  spectraRaw<-list()
  for (i in seq_along(test)){
    specDf<-PksAn[c(xs_an@pspectra[[i]]),c(1,sps_sel)]
    colnames(specDf)<-c("mz","Intensity")
    spectraRaw[[i]]<-specDf
    }
  assign("spectraRaw", spectraRaw, envir)
  lSP<-vector()
  for(i in seq_along(spectraRaw)){
    LoneSpectra<-(nrow(spectraRaw[[i]]))==1
    lSP<-c(lSP, LoneSpectra)
    lonespec<-which(lSP==TRUE)
    }
  curSpectraScan<-spectraRaw[-c(lonespec)]
  assign("curSpectraScan", curSpectraScan, envir)

  RefFeat<-list()
    for (i in seq_along(curSpectraScan)){
    refFeat<-rownames(curSpectraScan[[i]][which.max(curSpectraScan[[i]][,2]),])
    RefFeat[[i]]<-refFeat
    }
assign("RefFeat", RefFeat, envir)
RefFeat
}
