#' @title Define Peak Picking Parameters
#' @description Define and stores peak picking param forthe centWave
#'     algorithmvia GUI.
#' @details The function uses GUIs to define xcms peak picking parameters
#'     usingthe centwave algorithm. These include:
#'     minimum and maximum peakwidth,
#'     minimum and maximum m/z error (in ppm),
#'     values for the integration threshold
#'     (set at 5000) and signal to noise threshold,
#'     the integration method to be used (1 or 2 as defined by the xcms manual)
#'     and whether the pick picking should fit the gaussian curve.
#'     The default value for minimum and maximum m/z error and
#'     signal to noise (S/N) threshold is none and correspond, respectively,
#'     to 3.03 and 50 ppm and 1000 for S/N value. Detailed information about
#'     the mentioned parameters can be
#'     found in the xcms documentation:
#'     https://www.bioconductor.org/packages/release/bioc/manuals/xcms/
#' @export
#' @return returns a list input prarmeters
#' @seealso \code{\link[xcms]{findChromPeaks-centWave}}
#' @examples {MassSpecParam()
#'     PeakPickingParam()
#' }
PeakPickingParam <- function() {
    ne <- 1
    envir = as.environment(ne)
    pwmin <- dlgInput(message = "Enter a value for minimum peakwidth in
        seconds [pwMin]", default = 10, gui = .GUI)$res
    assign("pwMin", as.numeric(pwmin), envir)
    pwmax <- dlgInput(message = "Enter a value for maximum peakwidth in
        seconds [pwMax]",default = 20, gui = .GUI)$res
    assign("pwMax", as.numeric(pwmax), envir)
    mzdifference <- dlgInput(message = "minimum difference in m/z for peaks with overlapping retention times [mzdiff]", default = 0.01, gui = .GUI)$res
    assign("mzdifference", as.numeric(mzdifference), envir)
    mzEPMin <- dlgInput(message = "Enter a value for the minimum mz error in
        ppm [mzErrPpmMin]",default = "none", gui = .GUI)$res
    if (mzEPMin != "none") {
        mzErrPpmMin <- as.numeric(mzEPMin)
    } else {
        mzErrPpmMin <- mzErrAbs/2/mzEnd * 1e+06
    }
    assign("mzErrPpmMin", mzErrPpmMin, envir)
    mzEPMax <- dlgInput(message = "Enter a value for the maximum mz error in
        ppm [mzErrPpmMax]", default = "none", gui = .GUI)$res
    if (mzEPMax != "none") {
        mzErrPpmMax <- as.numeric(mzEPMax)
    } else {
        mzErrPpmMax <- mzErrAbs/2/mzStart * 1e+06
    }
    assign("mzErrPpmMax", mzErrPpmMax, envir)
    IntT <- dlgInput(message = "Enter integration threshold [intThresh]",
        default = 2000, gui = .GUI)$res
    assign("intThresh", as.numeric(IntT), envir)
    SNT <- dlgInput(message = "Enter signal to noise threshold [snThresh]",
        default = "none", gui = .GUI)$res
    fitG <- dlgInput(message = "Fit Gauss?[fitGauss]", default = FALSE,
        gui = .GUI)$res
    assign("fitGauss", as.logical(fitG), envir)
    integ <- dlgInput(message = "Define xcms integration method [integ]",
        default = 1, gui = .GUI)$res
    assign("integ", as.numeric(integ), envir)
    if (SNT != "none") {
        snThresh <- as.numeric(SNT)
    } else {
        snThresh <- 200/sens
    }
    assign("snThresh", snThresh, envir)
    mzErrPpmMean <- mean(c(mzErrPpmMin, mzErrPpmMax))
    assign("mzErrPpmMean", mzErrPpmMean, envir)
    assign("mzdifference", as.numeric(mzdifference), envir)
    pPparam <- data.frame(pwmin, pwmax, mzErrPpmMin,
        mzErrPpmMax,mzErrPpmMean, mzdifference, fitGauss, integ, snThresh)
    write.csv(pPparam, "peakPickParam.csv")
    return(pPparam)
}
