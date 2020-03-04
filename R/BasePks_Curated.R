#' @title Print BP_EICs chromatograms after curation
#' @description generates a table containing the data of curated peaks.
#' @param  x is the subset data matrix ('BasePks')
#' @export
#' @details BasePks_Curated() generates an updated data matrix (BasePksCur)
#'     with the discarded features removed.
#'     The final matrix is saved in a tsv file named PksBPs_Curated? which is
#'     saved within the working directory.
#' @return Na
#' @examples {ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     data(xSetRef)
#'     dir.create("./QC")
#'     RTalign_xset(xSetRef,'loess')
#'     xsAlign <- group(xsAlign, method= "nearest", mzVsRTbalance= 10,
#'         mzCheck= mzErrAbs,rtCheck= rtDelta, kNN=10)
#'     xsFilled <- fillPeaks(xsAlign, method="chrom", expand.mz=0.5 )
#'     printEICsXset(xSetRef,'corrected')
#'     minfrac<-0.3
#'     ne <- 1
#'     envir = as.environment(ne)
#'     assign("minfrac", minfrac, envir)
#'     autoCamera(xsFilled)
#'     FilterDM(PksAn, xSetRef)
#'     runtimeStart <- Sys.time()
#'     CollectBP_EICs(BasePks)
#'     BasePks_Curated(BasePks)
#'     }
BasePks_Curated <- function(x) {
    ne <- 1
    envir = as.environment(ne)
    files <- dir("./EICs_BasePeaks_Curated/")
    pks <- basename(file_path_sans_ext(dir("./EICs_BasePeaks_Curated/")))


    BasePksCur <- x[sprintf("%03d", as.numeric(rownames(x))) %in% pks, ]
    write.table(BasePksCur[with(BasePksCur, order(rt, mz)), ],
                file = paste("PksBPsCurated",
                "tsv", sep = "."), sep = "\t", col.names = NA,
                row.names = TRUE)

    assign("BasePksCur", BasePksCur, envir)


}
