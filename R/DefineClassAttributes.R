#' @title Define Graphical Attributes
#' @description Define and stores  colors, pch and samplegroup identifiers
#' @param  x is a character vector containing the sample class names,
#'     as per the ClassType object.
#' @details The argument of the function is the object ClassType.
#'     The function defines and returns specific symbols and colours for each
#'     sample class, which are then used to produce graphical outputs.
#'     Sample classesare organised according to the sub-directries present in
#'     the MSfiles folder.
#' @export
#' @return returns a list of class identifiers (sample groups, color codes and
#'     numbers corresponding to pch symbols)
#' @examples {ClassType<-c('Mix', 'Treatment1')
#'     DefineClassAttributes(ClassType)
#'     }
DefineClassAttributes <- function(x) {
    ne <- 1
    envir = as.environment(ne)

    classSize <- vector()

    if (exists('pathToProject')) {
        for (i in seq_along(x)) {
            detfls <- length(list.files(path = (paste(pathToProject,
            "/MSfiles/",x[i], sep = "")), pattern = filetype))
            classSize <- c(classSize, detfls)
            assign("classSize", classSize, envir)
    }
    } else
        {
        for (i in seq_along(x)) {
        detfls <-3
        classSize <- c(classSize, detfls)
        assign("classSize", classSize, envir)
    }
    }

    SampleGroup <- vector()
    for (i in seq_along(classSize)) {
        sg <- rep(x[i], classSize[i])
        SampleGroup <- c(SampleGroup, sg)
        assign("SampleGroup", SampleGroup, envir)
    }
    cols <- rainbow(length(x))
    ClassCol <- vector()
    for (i in seq_along(classSize)) {
        sc <- rep(cols[i], classSize[i])
        ClassCol <- c(ClassCol, sc)
        assign("ClassCol", ClassCol, envir)
    }
    pchdef <- seq_len(25)
    symbol <- vector()
    for (i in seq_along(classSize)) {
        sym <- rep(pchdef[i], classSize[i])
        symbol <- c(symbol, sym)
        assign("symbol", symbol, envir)
    }
    fg <- list(SampleGroup, ClassCol, symbol)
    return(fg)
}
