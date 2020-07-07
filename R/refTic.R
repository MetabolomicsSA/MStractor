#' @title TIC of the reference files.
#' @description Prints a .png file showing the TIC of the reference files.
#' @param  x is the xrefs XCMSnExp object.
#' @details The graphical output is stored in the QC folder.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{chromatogram-method}}
#' @examples {  ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     SampleGroup<-c("Mix", "Mix")
#'     symbol<-c(1,1)
#'     ClassCol<-c("#FF0000FF", "#FF0000FF")
#'     path<-system.file("extdata",package = "MStractor")
#'     files <- dir(path, pattern = ".mzXML", full.names = TRUE)
#'     test<-files[1:2]
#'     pd <- data.frame(sample_name = sub(basename(test), pattern = filetype,
#'         replacement ="", fixed = TRUE),sample_group = SampleGroup,
#'         stringsAsFactors = FALSE)
#'     ref_data <- readMSData(test, pdata = new("NAnnotatedDataFrame",
#'         pd), mode = "onDisk")
#'     expRefData(ref_data)
#'     dir.create("./QC")
#'     }
refTic <- function(x) {
    ne <- 1
    envir = as.environment(ne)
    gc()
    graphics.off()
    png("./QC/Ref_TIC.png", width = 1024, height = 768, units = "px")
    pl<-plot(chromatogram(x, mz = mz(x), rt = rtime(x), missing = 0,
        adjustedRtime = FALSE),
        main = "TIC Raw file", peakType = "none")
    assign("pl", pl, envir)
    dev.off()
    }
