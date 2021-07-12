#' @title heatMap
#' @description the function  saves interactive heatmap with HCA
#'              based on the Normalized Matrix data.
#' @param x is a Normalized Matrixobject
#' @description creates heatmaps.
#' @export
heatMap <- function(x){
id<-x[,1]
NM2<-x[,4:ncol(x)]
rownames(NM2)<-id
dir.create('./QC/HeatMap')
heatmaply(percentize(NM2), show_dendrogram= c(FALSE,TRUE),fontsize_row = 9, fontsize_col = 9,
          file = "./QC/HeatMap/heatmap_Normalized_Matrix.html")
}
