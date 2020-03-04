#' @title Prints EICs for XCMSnEXP objects.
#' @description prints pngs of the featuresfeature extracted ion chromatograms.
#' @param  x is a XCMSnEXP object ('xdata' in thw workflow).
#' @param y is a character vector containing the type of EICs to be printed,
#'     possible values are 'raw' and 'filled'.
#' @details The function is designed for XCMSnEXP objects and has to be used
#'     forbranch a' of the workflow.Pngs are stored in a dedicated subdirectory
#'     within the QC folder.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{featureChromatograms}}
#' @examples {ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     ClassType<-c('Mix', 'Treatment1')
#'     DefineClassAttributes(ClassType)
#'     data(xdata)
#'     dir.create("./QC")
#'     printEICs(xdata,'raw')
#' }
printEICs <- function(x, y) {
    ne <- 1
    envir = as.environment(ne)
    system.time(tmp <- featureChromatograms(x))
    assign("tmp", tmp, envir)

    dir.create(paste("./QC/EICs_", y, "/", sep = ""))

    getEICS <- for (i in seq_len(nrow(tmp))) {
        graphics.off()
        png(filename = paste("./QC/EICs_", y, "/", (rownames(tmp[i])), ".png",
            sep = ""), height = 768, width = 1024)
        plot(tmp[i], col = ClassCol, peakType = "none")
        legend("topright", box.lwd = 2, legend = c(xdata$sample_group),
            pch = symbol, col = ClassCol, xpd = FALSE)

    }

}
