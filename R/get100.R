#' @title Get 100 features
#' @description Prints a .png showing 100 features across the RT range
#'     of the reference files.
#' @param  x is a XCMSnExp object (for the reference file replicates)
#'     after peak picking and grouping are performed.
#' @details The graphical output is stored in the QC folder created in
#'     the previous steps of the workflow.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{chromatogram-method}}
#' @examples {ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     SampleGroup<-c("Mix", "Mix")
#'     symbol<-c(1,1)
#'     ClassCol<-c("#FF0000FF", "#FF0000FF")
#'     path<-system.file("extdata",package = "MStractor")
#'     files <- dir(path, pattern = ".mzXML", full.names = TRUE)
#'     test<-files[1:2]
#'     pd <- data.frame(sample_name = sub(basename(test), pattern = filetype,
#'         replacement ="", fixed = TRUE),
#'         sample_group = SampleGroup, stringsAsFactors = FALSE)
#'     ref_data <- readMSData(test,
#'         pdata = new("NAnnotatedDataFrame", pd), mode = "onDisk")
#'     expRefData(ref_data)
#'     dir.create('./QC')
#'     get100(x_refs)
#'     }
get100 <- function(x) {
    ne <- 1
    envir = as.environment(ne)
    tmp <- featureChromatograms(x)
    gc()
    type = "reference_100"
    tbp = round(seq(from = 1, to = nrow(tmp), by = (nrow(tmp)/100)))
    printreference <- function(x) {
        graphics.off()
        png(filename = paste("./QC/EICs_", type, ".png", sep = ""),
            height = 1024,width = 1024)
        par(mar = c(1, 1, 1, 1))
        par(mfrow = c(10, 10))
        for (i in seq_along(tbp)) {
            plot(tmp[tbp[i]], col = "red", peakType = "none")
        }
        dev.off()
    }
    pl1<-printreference(x_refs)
    assign("pl1", pl1, envir)

    par(mar = c(5.1, 4.1, 4.1, 2.1))
    dev.off()
}
