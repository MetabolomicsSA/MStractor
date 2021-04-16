#' @title Mass Spectrometry Parameter Definition.
#' @description Define and store Mass Spec parameters and file type via GUI.
#' @details The Parameters are the acquisition mode(negative as default);
#'     the mass range to be considered (mz start and mz end);
#'     the number of expected charges (default value set at 3);
#'     the filetype (default set to mzXML);
#'     the maximum number of chromatographic peaks expected for a single EIC;
#'     the sensitivity.
#' @export
#' @return returns a list of input mass spectrometry parameters
#' @seealso \code{\link[xcms]{findChromPeaks-centWave}}
#' @examples {MassSpecParam()}
MassSpecParam <- function() {
    ne <- 1
    envir = as.environment(ne)
    mzpol <- dlgInput(message = "Enter polarity [mzPol]",
        default = "negative", gui = .GUI)$res
    mzstart <- dlgInput(message = "Enter a value for mz region
        start [mzStart]", default = 100, gui = .GUI)$res
    mzend <- dlgInput(message = "Enter a value for mz region end [mzEnd]",
        default = 1650, gui = .GUI)$res
    mzerrabs <- dlgInput(message = "Max m/z delta expected for the same
        feature across all samples [mzErrAbs]",
        default = 0.01, gui = .GUI)$res
    mzmax <- dlgInput(message = "Max number of expected charges[mzMax]",
        default = 3, gui = .GUI)$res
    eicssmax <- dlgInput(message = "Max number of chrom. peaks expected
        for a single EIC [EICsMax]", default = 30, gui = .GUI)$res
    sensmin <- dlgInput(message = "sensitivity [sens]", default = 0.7,
        gui = .GUI)$res
    filetype <- dlgInput(message = "define file type [filetype]",
        default = ".mzXML",gui = .GUI)$res
    assign("mzPol", mzpol, envir)
    assign("mzStart", as.numeric(mzstart), envir)
    assign("mzEnd", as.numeric(mzend), envir)
    assign("mzErrAbs", as.numeric(mzerrabs), envir)
    assign("mzMax", as.numeric(mzmax), envir)
    assign("EICsMax", as.numeric(eicssmax), envir)
    assign("sens", as.numeric(sensmin), envir)
    assign("filetype", filetype, envir)
    msparam <- data.frame(mzPol, mzStart, mzEnd, mzErrAbs, mzMax, EICsMax, sens,
        filetype)
    write.csv(msparam, "MassSpecParam.csv")
    return(msparam)
}
