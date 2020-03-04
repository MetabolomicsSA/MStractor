#' @title Descriptive Stats Calcualtion
#' @description Calculate descriptive stats (Average, St.Dev and CV%) for each
#'     sample class.
#' @param  x is the ClassType vector generatedby running the LoadData()
#'     function
#' @param y  is the xcmsSet
#' @export
#' @return outputs stored in separate tsv files for each class.
#' @examples {data(xSetRef)
#'     data(BasePksCur)
#'     MedianNormalize( BasePksCur,xSetRef)
#'     ClassType<-c('Mix', 'Treatment1')
#'     ne <- 1
#'     envir = as.environment(ne)
#'     assign("ClassType", ClassType, envir)
#'     StatsByClass(ClassType, xSetRef)
#'     }
StatsByClass <- function(x,y) {
    ne <- 1
    envir = as.environment(ne)
    sn <- list()

    Files <- sampnames(y)
    set <- rep(list(vector()), length(x))
    for (i in seq_along(x)) {
        categories <- which(grepl(x[i], Files))
        set[[i]] <- categories
    }
    assign("set", set, envir)
    options(scipen = 999)  # disables scientific notation

    descriptive_stats <- rep(list(matrix()), length(x))

    for (i in seq_along(set)) {
        selection <- data.matrix(subset((NormalizedMatrix),
            select = Files[set[[i]]]))
        definers<-data.matrix(NormalizedMatrix[,seq_len(3)])
        strpnt<-merge(definers, selection, by = "row.names")
        strpnt<-strpnt[,-c(1)]
        stdev <- as.matrix(apply(strpnt[4:ncol(strpnt)], 1, sd))
        colnames(stdev) <- paste("St.Dev.", x[i])
        average <- as.matrix(apply(strpnt[4:ncol(strpnt)], 1, mean))
        colnames(average) <- paste("Average", x[i])
        cv <- as.matrix((stdev/average) * 100)
        colnames(cv) <- paste("CV%", x[i])
        statsb <- data.matrix(merge(strpnt,cbind(average, stdev, cv),
            by='row.names'))
        statsb<-statsb[,-c(1)]
        statsb<-data.frame(statsb)
        descriptive_stats[[i]] <- statsb
    }

    assign("descriptive_stats", descriptive_stats, envir)

    for (i in seq_along(descriptive_stats)) {
        write.table(descriptive_stats[[i]], paste("./",
            "Descriptive_Stats_func",
            ClassType[i], (".tsv")), sep = " \t", row.names = TRUE)
    }

}

