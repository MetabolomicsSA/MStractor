#' @title Boxplot
#' @description the function returns and saves Boxplots for every feature
#'              present in the data frame arraging them by sample class.
#' @param x is a data frame containing data  and descriptive stats fore each
#'        class. It can be pre or post Tms and blank filtering.
#'        The data frame structure has to be teh same of the "NormalizedMatrix" object.
#'        y is a "bpSelection" object", i.e. a charter vector containing the sample classes
#'        z is a character vector of length defining the type of algorithm to be used, either "exclusive",
#'        "inclusive" or "linear". for more info
#'        https://plotly.com/r/box-plots/#choosing-the-algorithm-for-computing-quartiles
#' @description Define and subtract features above a given cv.
#' @details The user defines the classes to be taken into account for CV filtering.If a feature has
#'          a CV value above 25% in all the classes considered, the feature is removed from the data matrix.
#' @export
#' @return boxplots
Boxplot <- function(x,y){
    col<-colnames(x)
    featurelabels<-as.numeric(x[,1])
    sg<-unique(y)
    sgr<-vector()
        for (i in seq_along(sg)){
            sgmod<-paste(sg[i],"_", sep="")
            sgr<-c(sgr,sgmod)
            }
    clsl_str<-list()
        for (i in seq_along(sgr)){
            vtr<-which(grepl(sgr[i],col)==TRUE)
            clsl_str[[i]]<-vtr
            }
    bpDms<-list()
        for (i in seq_along(clsl_str)){
            bpdm<-x[,clsl_str[[i]]]
            bpDms[[i]]<-bpdm
            }
    feat<-list()
    dex<-list()
        for (i in seq_along(bpDms)){
            for(j in 1:nrow(bpDms[[i]])){
                features<-as.numeric(bpDms[[i]][j,])
                dex[[j]]<-features
            }
            feat[[i]]<-dex
            }
    fbc<-list()
    boxLsDm<-list()
        for(j in seq_along(feat[[1]])){
            for (i in seq_along(feat)){
            fby<-feat[[i]][[j]]
            fbc[[i]]<-fby
            boxLsDm[[j]]<-fbc
            }
          }

    boxPlots<-list()
        for(i in seq_along(boxLsDm)){
             fig<-plot_ly(type= "box")
             for(j in seq_along(boxLsDm[[1]])){
                 fig<-add_trace(fig, y=boxLsDm[[i]][[j]], quartilemethod=z, name=y[[j]])
                 boxPlots[[i]]<-fig
             }
        }
    dir.create("./QC/Boxplots")
        for(i in seq_along(boxPlots)){
          htmlwidgets::saveWidget(boxPlots[[i]],  file= paste('./QC/Boxplots/','Feature',featurelabels[i],'boxplot.html',sep=""))
            }
}

