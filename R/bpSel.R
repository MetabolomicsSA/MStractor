#' @title Define Boxplot Matrix
#' @description the function allows the user to select wich calsses have to be included in the boxplot matrix
#' @param x is a "ClassType" object
#' @export
#' @return boxplots
bpSel<- function(x){
    ne <- 1
    envir = as.environment(ne)
    bpSelection= dlg_list(title = "define the name of the classes used for boxplots",ClassType, multiple=TRUE, gui=.GUI)$res
    assign("bpSelection", bpSelection, envir)
    return (paste("The selected classes are:", paste(bpSelection, collapse=',')))
}
