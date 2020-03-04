#' @title Create Summary Data Matrix
#' @description filter the feature data matrix by retaining only the most
#'     intense feature for each group.
#' @param  x is a peak list form a xsAnnotate object
#' @param y a xset object
#' @export
#' @return a tab separated file is stored within the working directory
#' @seealso \code{\link[xcms]{XCMSnExp-class}}
#' @examples {data(xSetRef)
#'     data(PksAnDF)
#'     FilterDM(PksAnDF, xSetRef)
#' }
FilterDM <- function(x, y) {
    ne <- 1
    envir = as.environment(ne)
    pcgroups <- table(x$pcgroup)
    min_ions <- 2
    PksAnFilt <- droplevels (x[x$pcgroup %in% names(pcgroups)
        [pcgroups >= min_ions],
        , drop = FALSE])


    sNames <- sampnames(y)

    matchsel <- list()
    for (i in seq_along(sNames)) {
        categories <- which(grepl(sNames[i], colnames(PksAnFilt)))
        matchsel[[i]] <- categories
    }
    selection <- unlist(matchsel)
    assign("selection", selection, envir)


    RespMed <- apply(PksAnFilt[selection], 1, median, na.rm = TRUE)
    PksAnFilt <- cbind(PksAnFilt, RespMed)

    BasePks <- PksAnFilt[RespMed == ave(RespMed, PksAnFilt$pcgroup,
        FUN = function(RespMed) max(RespMed)),]

    assign("BasePks", BasePks, envir)
    write.table(BasePks[with(BasePks, order(rt, mz)), ], file = paste("Pks_BPs",
        "tsv", sep = "."), sep = "\t", col.names = NA, row.names = TRUE)

}
