#' @title Prints overlaid TICs for xcmsSet Objects
#' @description function to print a .png file with the overlaid TIcs
#' @param  xcmsSet is a xcmsSet object (either aligned or not )
#' @param rt is a vector defining the type of TICs ('raw' or ' corrected')
#' @param pngName defines the data file name
#' @param files a list of files to print the TICs for
#' @details the graphical output is stored as .png in theQC folder.
#' @export
#' @return Na
#' @examples {ClassType<-c('Mix', 'Treatment1')
#'     DefineClassAttributes(ClassType)
#'     data(xdata)
#'     xsetConvert(xdata)
#'     sampnames(xset)<-spn
#'     dir.create('./QC')
#'     getTICs(xcmsSet= xset, pngName= "./QC/TICs_raw.png", rt= "raw")
#' }
getTICs <- function( xcmsSet=NULL, files=NULL, pngName="TICs.png",
    rt = c("raw", "corrected")) {
    if (is.null(xcmsSet)) {
        filepattern <- c("[Cc][Dd][Ff]", "[Nn][Cc]", "([Mm][Zz])?[Xx][Mm][Ll]",
            "[Mm][Zz][Dd][Aa][Tt][Aa]", "[Mm][Zz][Mm][Ll]")
        filepattern <- paste(paste("\\.", filepattern, "$", sep = ""),
        collapse = "|")
        if (is.null(files))
            files <- getwd()
        info <- file.info(files)
        listed <- list.files(files[info$isdir], pattern = filepattern,
            recursive = TRUE, full.names = TRUE)
        files <- c(files[!info$isdir], listed)
    } else {
        files <- filepaths(xcmsSet)
    }

    N <- length(files)
    TIC <- vector("list", N)

    for (i in seq_len(N)) {
        cat(files[i], "\n")
        if (!is.null(xcmsSet) && rt == "corrected")
            rtcor <- xcmsSet@rt$corrected[[i]] else rtcor <- NULL
        TIC[[i]] <- getTIC(files[i], rtcor = rtcor)
    }

    graphics.off()
    png(pngName, height = 768, width = 1024)
    # cols <- rainbow(N)
    cols <- as.integer(sampclass(xcmsSet)) + 1
    lty = seq_len(N)
    pch = seq_len(N)
    xlim = range(vapply(TIC, function(x) range(x[, 1]),numeric(2)))
    ylim = range(vapply(TIC, function(x) range(x[, 2]),numeric(2)))
    plot(0, 0, type = "n", xlim = xlim, ylim = ylim,
        main = "Total Ion Chromatograms",
        xlab = "Retention Time (s)", ylab = "TIC")
    for (i in seq_len(N)) {
        tic <- TIC[[i]]
        points(tic[, 1], tic[, 2], col = cols[i], pch = pch[i], type = "l")
    }
    legend("topright", paste(basename(files)), col = cols, lty = lty,
        pch = pch)
    dev.off()

    invisible(TIC)
}
