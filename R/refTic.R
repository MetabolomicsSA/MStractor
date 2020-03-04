#' @title TIC of the reference files.
#' @description Prints a .png file showing the TIC of the reference files.
#' @param  x is the xrefs XCMSnExp object.
#' @details The graphical output is stored in the QC folder.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{chromatogram-method}}
#' @examples {  ChromParam()
#'    MassSpecParam()
#'    PeakPickingParam()
#'    data(testX)
#'    expRefData(testDataSet)
#'    dir.create('./QC')
#'    refTic(x_refs)
#'    }
refTic <- function(x) {
    ne <- 1
    envir = as.environment(ne)
    gc()
    graphics.off()
    png("./QC/Ref_TIC.png", width = 1024, height = 768, units = "px")
    pl<-plot(chromatogram(x, mz = mz(x), rt = rtime(x), missing = 0,
        adjustedRtime = FALSE),
        main = "TIC Raw file", peakType = "none")
    assign("pl", pl, envir)
    }
