#' @title Retention Time Alignment on XCMSnEXP objects
#' @description Function based on the xcms  'adjustRtime' function.
#' @param x is a XCMSnEXP object
#' @param y is a character vector defining the correction method
#'     (default is loess)
#' @details Retention time correction parameters are entered via GUI.
#'     The retention time alignment method currently supported is loess
#'     (see xcms manual).
#'     A graphical output showing the retetion time deviation is saved
#'     in the QC folder.
#' @export
#' @return xdata, the aligned XCMSnEXP object
#' @seealso \code{\link[xcms]{retcor.peakgroups-methods}}
#' @examples {ClassType<-c('Mix', 'Treatment1')
#' DefineClassAttributes(ClassType)
#' data(xdata)
#' RTalign(xdata,'loess')
#' }
RTalign <- function(x, y) {
    ne <- 1
    envir = as.environment(ne)
    Family = dlgInput(message = "Enter the family type (gaussian or symmetric)",
        default = "gaussian", gui = .GUI)$res
    assign("Family", Family, envir)
    Span = dlgInput(message = "Enter the span value", default = "0.6",
        gui = .GUI)$res
    assign("Span", Span, envir)
    Extra = dlgInput(message = "Enter number of extra peaks to allow in
        retention time correction correction groups",
        default = "0", gui = .GUI)$res
    assign("Extra", Extra, envir)

    xdata <- adjustRtime(x, param = PeakGroupsParam(minFraction = 0.3,
        smooth = y,extraPeaks = as.numeric(Extra), span = as.numeric(Span),
        family = Family))
    png(filename = paste("./QC/rtAlign", y, ".png"), width = 1280,
        height = 1024)
    plotAdjustedRtime(xdata, col = ClassCol, adjustedRtime = TRUE,
        peakGroupsCol = "#e4e7ec",peakGroupsPch = ".", peakGroupsLty = 1,
        cex = 10)
    legend("topright", box.lwd = 2, legend = c(xdata$sample_group),
        pch = symbol,col = ClassCol, xpd = FALSE)
    dev.off()
    assign("xdata", xdata, envir)
    return(xdata)
}

