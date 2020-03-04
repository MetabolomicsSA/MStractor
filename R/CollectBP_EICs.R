#' @title Print BP_EICs chromatograms
#' @description prints Base Peaks chromatograms (.png)  of the filtered
#'     features and stores them in a folder
#' @param  x is the subset data matrix ('BasePks') created via the FilterDM
#'     function
#' @param  y is a character vector ( 'corrected' for branch b and
#'     'filled' for branch a)
#' @export
#' @details CollectBP_EICs() prints the extracted ion chromatograms related to
#'     the base peak matrix in a .png format.The pngs files are duplicated into
#'     2 directories,named EICs_BasePeaks and EICs_BasePeaks_Curated.
#'     The former is used as data back-up, while the latter allows the user
#'     to perform a final curation on the EICs,
#'     by removing those that do not contain useful information
#'     (e.g. background noise)
#' @return runtime
#' @examples {  ChromParam()
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
#'     CollectBP_EICs(BasePks,'corrected')
#'     }
CollectBP_EICs <- function(x,y) {

    BP_EICs <- paste(sprintf("%03d", as.numeric(rownames(x))),
        "png", sep = ".")

    dir.create("./EICs_BasePeaks/")
    do.call(file.remove, list(list.files("./EICs_BasePeaks/",
        full.names = TRUE)))
    for (i in seq_along(BP_EICs)) {
        sourceF <- paste(paste("./QC/EICs_",y,'/',sep=""), BP_EICs[i], sep = "")
        destF <- paste("./EICs_BasePeaks/", BP_EICs[i], sep = "")
        file.copy(from = sourceF, to = destF, overwrite = FALSE)
    }

    dir.create("./EICs_BasePeaks_Curated/")
    do.call(file.remove, list(list.files("./EICs_BasePeaks_Curated/",
        full.names = TRUE)))
    for (i in seq_along(BP_EICs)) {
        sourceF <- paste(paste("./QC/EICs_",y,'/',sep=""), BP_EICs[i], sep = "")
        destF <- paste("./EICs_BasePeaks_Curated/", BP_EICs[i], sep = "")
        file.copy(from = sourceF, to = destF, overwrite = TRUE)
    }
    ne <- 1
    envir = as.environment(ne)
    runtimeEnd <- Sys.time()
    runtime <- runtimeEnd - runtimeStart
    assign("runtimeEnd", runtimeEnd, envir)
    return(runtime)
}
