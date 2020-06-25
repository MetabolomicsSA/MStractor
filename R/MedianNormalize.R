#' @title Matrix Median Normalisation
#' @description Generate a table containing the bormalised data.
#' @param  x is the BasePksCur matrix
#' @param  y is the xcmsSet
#' @export
#' @return A normalised datamatrix (NormalizedMatrix) as .csv.
#' @examples {data(xSetRef)
#'     data(BasePksCur)
#'     MedianNormalize(BasePksCur,xSetRef)
#' }
MedianNormalize <- function(x,y) {
    ne <- 1
    envir = as.environment(ne)
    Files <- sampnames(y)
    colnum <- ncol(x)
    BasePksCur$id <- rownames(BasePksCur)
    idcolnum <- ncol(BasePksCur)

    BasePksCur <- BasePksCur[c(idcolnum,seq_len(colnum))]

    BasePksCur <- BasePksCur[with(BasePksCur, order(rt, mz)), ]
    BasePksCur$rt <- BasePksCur$rt/60
    AIN <- BasePksCur[, c(1, 2, 5)]
    write.table(AIN, file = paste("AIN", "tsv", sep = "."), sep = "\t",
        col.names = TRUE, row.names = FALSE)

    sub1 <- colnames(BasePksCur)
    replicates <- which(sub1 %in% Files)
    BasePksCurSel <- subset(BasePksCur, select = replicates)
    SimpMatrix <- merge(AIN, BasePksCurSel, by = "row.names")
    SimpMatrix[, 1] <- NULL

    Median <- apply(BasePksCurSel, 2, FUN = median, na.rm = TRUE)
    norm <- sweep(BasePksCurSel, 2, Median, `/`)
    NormalizedMatrix <- merge(AIN, norm, by = "row.names")
    NormalizedMatrix[, 1] <- NULL
    t <- format(round(NormalizedMatrix[, 2:ncol(NormalizedMatrix)], 4),
        nsmall = 4)
    t<-data.matrix(t)
    NormalizedMatrix[, 2:ncol(NormalizedMatrix)] <- t
    NormalizedMatrix[, 3] <- as.numeric(NormalizedMatrix[, 3])
    NormalizedMatrix[, 2] <- as.numeric(NormalizedMatrix[, 2])
    assign("NormalizedMatrix", NormalizedMatrix, envir)
    write.table(NormalizedMatrix[with(NormalizedMatrix, order(rt, mz)), ],
        file = paste("NormalizedMatrix", "tsv", sep = "."), sep = "\t",
        col.names = NA, row.names = TRUE)

}
