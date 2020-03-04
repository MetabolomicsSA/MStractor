#' @title Load Data Set
#' @description Loads raw data files form the MsFiles directory and defines
#'     sample classes.
#' @details The function does not  require arguments and returns a complete
#'     list of the files loaded. It also starts recording the time necessary for
#'     data processing and creates the object ClassType which associates every
#'     datafile with the class of belonging.
#' @export
#' @return returns the the list of loaded raw data files.
LoadData <- function() {
    ne <- 1
    envir = as.environment(ne)
    register(bpstart(SnowParam(2)))

    CPUs<-'max'

    if (CPUs == "max") {
        CPUs <- detectCores(all.tests = TRUE, logical = TRUE)

    }

    # Load all the MS files
    if (exists('pathToProject')) {
    datapath <- paste(pathToProject, "MSfiles", sep = "/")
    ClassType <- dirs("./MSfiles//", full.names = FALSE)
    assign("ClassType", ClassType, envir)
    rawfiles <- dir(datapath, full.names = TRUE, pattern = (paste("\\",
        filetype, sep = "")), recursive = TRUE)
    assign("rawfiles", rawfiles, envir)
    files <- basename(list.files(path = "./MSfiles", recursive = TRUE,
        full.names = FALSE, pattern = paste("\\", filetype, sep = "")))
    assign("files", files, envir)
    return((cat("The following MS files have been loaded:\n", files,
                fill = FALSE, sep = "\n")))
    sn <- list()
    for (i in seq_along(files)) {
        divide <- strsplit(files[i], filetype)
        sn[[i]] <- divide
    }
    Files <- unlist(sn)
    }
    else{
    return(cat("No data defined"
        ))
    }
}
