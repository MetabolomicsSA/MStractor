#' @title Print Overlaid TICs for XCMSnEXP objects.
#' @description prints overlaid TICs of the dataset.
#' @param  x is a xdata object
#' @param y is a character vector containing the type of TICs to be printed
#'     (possible values are 'raw' and 'corrected')
#' @details the graphical output is stored as .png in theQC folder.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{chromatogram-method}}
#' @examples {ClassType<-c('Mix', 'Treatment1')
#'     DefineClassAttributes(ClassType)
#'     dir.create('./QC')
#'     data(xdata)
#'     OverlaidTICs(xdata, 'raw')
#'     }
OverlaidTICs <- function(x, y) {
    graphics.off()
    png((paste("./QC/TICs_", y, ".png")), width = 1024, height = 768,
        units = "px")
    TICs <- chromatogram(x, mz = mz(x), rt = rtime(x), missing = 0,
        adjustedRtime = FALSE)
    plot(TICs, col = ClassCol, peakType = "none", main = (paste("TICs", y,
        sep = " ")))
    legend("topright", box.lwd = 2, legend = c(x$sample_group), pch = symbol,
        col = ClassCol, xpd = FALSE)
    dev.off()
}
