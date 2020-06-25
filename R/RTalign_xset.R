#' @title Retention Time Alignment on xcmsSet objects
#' @description Function based on the xcms  'retcor'.
#' @param  x is a xcmsSet object y is a character vector defining the
#'     correction method (default is loess)
#' @param y is a character vector defining the correction method
#'     (default is loess)
#' @export
#' @details Retention time correction parameters are entered via GUI.
#'     The retention time alignment method currently supported is loess.
#'     (see xcms manual).
#'     A graphical output showing the retetion time deviation is saved in
#'     the QC folder.
#' @return xsAlign, the aligned xcmsSet onbject
#' @seealso \code{\link[xcms]{retcor.peakgroups-methods}}
#' @examples {data(xSetRef)
#'     dir.create('./QC')
#'     RTalign_xset(xSetRef,'loess')
#' }
RTalign_xset <- function(x, y) {
    ne <- 1
    envir = as.environment(ne)
    Family = dlgInput(message = "Enter the family type
                    ('gaussian' or 'symmetric')",
        default = "gaussian", gui = .GUI)$res
    assign("Family", Family, envir)
    Plottype = dlgInput(message = "Enter the plot type
        ('none', 'deviation'
        or 'mdevden')",default = "deviation", gui = .GUI)$res
    assign("Plottype", Plottype, envir)
    PMissing = dlgInput(message = "Enter the number of missing samples
        [PMissing] to
        allow in retention time correction groups",
        default = 3, gui = .GUI)$res
    assign("PMissing", PMissing, envir)
    Span = dlgInput(message = "Enter the span value [Span]", default = "0.6",
        gui = .GUI)$res
    assign("Span", Span, envir)
    Extra = dlgInput(message = "Enter number of extra peaks [Extra] to allow in
        retention time correction correction groups", default = "0",
        gui = .GUI)$res
    assign("Extra", Extra, envir)
    png(filename = paste("./QC/rtAlign", y, ".png"), width = 1280,
        height = 1024)
    xsAlign <- retcor(x, method = y, missing = as.numeric(PMissing),
        extra = as.numeric(Extra),
        span = as.numeric(Span), family = Family, plottype = Plottype)
    dev.off()
    assign("xsAlign", xsAlign, envir)
    return(xsAlign)
}

