#' @title Prints EICs for xcmsSet objects
#' @description prints pngs of the feature extracted ion chromatograms.
#' @param  x is a xcmsSet object.
#' @param y is a character vector containing the type of EICs to be printed
#'     The possible values are 'raw' and 'corrected'.
#' @details The function is designed for xcmsSet objects and has to be used
#'     for branch b' of the workflow.Pngs are stored in a dedicated subdirectory
#'     withinthe QC folder.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{featureChromatograms}}
#' @examples { ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     ClassType<-c('Mix', 'Treatment1')
#'     DefineClassAttributes(ClassType)
#'     data(xSetRef)
#'     dir.create("./QC")
#'     printEICsXset(xSetRef,'raw')
#' }
printEICsXset <- function(x, y) {
    xset_grps <- x@groups
    eicRange <- 2 * mean(c(FWHMmin, FWHMmax))
    eics <- getEIC(x, mzrange = xset_grps, rtrange = eicRange,
        groupidx = seq_len(nrow(xset_grps)),rt = y)
    eg <- paste("./QC/EICs_", y, "/", sep = "")
    dir.create(eg)
    do.call(file.remove, list(list.files("eg", full.names = TRUE)))
    graphics.off()
    png(file.path(paste(eg, "%001d.png", sep = "")), height = 768,
        width = 1024)
    plot(eics, x)

}
