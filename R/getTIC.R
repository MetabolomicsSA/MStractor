#' @title get TIC of a single analysis
#' @description function to get a singleTIc
#' @param  file is a file of the analytical set, rtcor defines whether the
#'     rt correction was performed.
#' @param rtcor defines whether the rt correction was performed
#' @export
#' @return Na
#' @examples {ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     data(testX)
#'     expRefData(testDataSet)}
getTIC <- function(file, rtcor = NULL) {
    object <- xcmsRaw(file)
    cbind(if (is.null(rtcor))
        object@scantime else rtcor, rawEIC(object,
        mzrange = range(object@env$mz))$intensity)
}
