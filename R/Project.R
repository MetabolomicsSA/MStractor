#' @title Define MStractor Project
#' @description Define the working directory, reference file and QC replicates
#'     for preliminary evaluation of peak picking
#' @details The function does not require arguments. Its execution opens a GUI
#'     allowing the selection of the working directory
#'     and 2 reference files chosen
#'     from one of the folders within the MSfiles directory (e.g.: two Mix
#'     replicates in the example dataset).
#'     The function also creates a QC folder
#'     where graphical outputs to evaluate the progress
#'     of the workflow are stored.
#' @export
#' @return returns a list containing the working directory and reference file
#'     paths.
#' @seealso \code{\link[base]{getwd}}
#' @examples \dontrun{Project()
#' }
Project <- function() {
    ne <- 1
    envir = as.environment(ne)
    pathtoproject = choose.dir(default = "", caption = "Select working
        directory")
    qcReps <- choose.files(default = "", caption = "Select  QC replicates
        (minimum of 2)",multi = TRUE)
    cpus <- "max"
    assign("pathToProject", pathtoproject, envir)
    assign("CPUs", cpus, envir)
    assign("QCReps", qcReps, envir)
    ws <- list(pathToProject, qcReps)
    # Set the projects working directory
    if (is.na('pathToProject')) {
        return(cat("Working directory not found"))
    }else{
        setwd(pathToProject)
        dir.create("./QC")
        cat("Working directory set to:\n", getwd())
        return(ws)
    }
}
