#' @title Chromatographic Parameters Definition,
#' @description Define and save chromatographic parameters via GUI.
#' @details ChromParam() allows the user to input the
#'     chromatographic parametersrelated to the data set to be
#'     processed and that will be stored and used in
#'     the later stages of the framework.
#'     The values to be entered are the retention time range
#'     of the data set (rt start and rt end), the maximum
#'     retention time drift observed and the
#'     minimum and maximum fullwidth at half maximun (FWHM min and max).
#' @export
#' @return returns a list of input chromatographic parameters
#' @seealso \code{\link[svDialogs]{dlg_input}}getwd
#' @examples {ChromParam()
#' }
ChromParam <- function() {
    ne <- 1
    envir = as.environment(ne)

    runtimeStart <- Sys.time()
    runtimeStart
    assign("runtimeStart", runtimeStart, envir)

    rtstart = dlgInput(message = "Enter a value for rt
                start in seconds [rtStart]",default = 1, gui = .GUI)$res
    rtend = dlgInput(message = "Enter a value for rt end in seconds [rtEnd]",
        default = "max", gui = .GUI)$res
    if (rtend != "max") {
        rtEnd <- as.numeric(rtend)
    } else {
        mzErrPpmMin <- rtend
    }
    fwhmmin = dlgInput(message = "Enter the FWHM of the narrowest
                peak in seconds[FWHMmin]", default = 10, gui = .GUI)$res
    fwhmmax = dlgInput(message = "Enter the FWHM of the broadest
                peak in seconds [FWHMmax]",default = 90, gui = .GUI)$res
    rtdev = dlgInput(message = "Enter the max observed difference in
                retention time in seconds [rtDelta]",
                default = 32, gui = .GUI)$res
    assign("rtStart", as.numeric(rtstart), envir)
    assign("rtEnd", rtend, ne)
    assign("FWHMmin", as.numeric(fwhmmin), envir)
    assign("FWHMmax", as.numeric(fwhmmax), envir)
    assign("rtDelta", as.numeric(rtdev), envir)
    inputparam <- list(rtStart, rtEnd, FWHMmin, FWHMmax, rtDelta)
    return(inputparam)
}
