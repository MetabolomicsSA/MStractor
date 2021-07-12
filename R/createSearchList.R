#' @title create search list
#' @param x is a string. Accepted values are "spectralist"for mscan extracted spectra or "curSpectraSet" for pseudospectra extracted data
#' @description arrange single NIST entries in alist of unknown entries to be searched in the NIST
#' @export
#' @return  list of entries to identified in .txt format
createSearchList<-function(x){
    speccsv<-list()
    allspec<-list.files(paste("./spectralist/",x,'/', sep=""))
    for(i in 1:length(allspec)){
        spc<-read.csv(paste("./spectralist/",x,'/', allspec[[i]], sep=''),header=FALSE)
        speccsv[[i]]<-spc
    }

    write.table(speccsv[[1]], paste("./spectralist/" ,x,'/',"listofunknown.txt", sep=""),
                sep=" ", col.names=FALSE, row.names=FALSE, quote=FALSE)

    for (i in 2:length(speccsv)){
        fwrite(speccsv[[i]], file=paste("./spectralist/" ,x,'/',"listofunknown.txt", sep=""), append=TRUE, eol="\r\n")
    }
    for (i in 2:length(speccsv)){
        fwrite(speccsv[[i]], file=paste("./spectralist/" ,x,'/',"listofunknown.msp", sep=""), append=TRUE, eol="\r\n")
    }
}
