#' @title Converts new xcmsnExp into xcmsset
#' @description XCMSnExp data are converted to xcmsset using the function
#'     available in the xcms package.
#' @param  x is a XCMSnExp object to be converted
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{xcmsSet-class}}
xsetConvert <- function(x) {
    ne <- 1
    envir = as.environment(ne)
    xset <- as(x, "xcmsSet")
    xset$class <- factor((x$sample_group))
    spn <- x@phenoData$sample_name
    assign("spn", spn, envir)
    assign("xset", xset, envir)
}
