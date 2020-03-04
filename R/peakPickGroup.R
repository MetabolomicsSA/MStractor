#' @title Dataset Peak Detection and Grouping
#' @description Define peak picking parameters via GUI and performs peak
#'     detection and grouping on the entire dataset.
#' @details Automatically creates a XCMSnEXP dataset containing all the
#'     datafiles.The function performs the same steps described for
#'     exploreRefs(),with the only difference that the processing is applied to
#'     the whole dataset.
#'     It is important that the input parameters used in this
#'     step match the onesdefined for the reference files.
#'     After performing peak picking on each datafile,
#'     peaks are matched across all samples and grouped using the xcms
#'     functions findChromPeaks and groupChromPeaks.
#'     Results are stored in the XCMSnEXP object xdata.
#' @export
#' @return Na
#' @examples {ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     ClassType<-c('Mix', 'Treatment1')
#'     DefineClassAttributes(ClassType)
#'     path<-system.file("extdata",package = "MStractor")
#'     files <- dir(path, pattern = ".mzXML", full.names = TRUE)
#'     pd <- data.frame(sample_name = sub(basename(files), pattern = filetype,
#'         replacement = "", fixed = TRUE), sample_group = SampleGroup,
#'         stringsAsFactors = FALSE)
#'     raw_data <- readMSData(files =files, pdata = new("NAnnotatedDataFrame",
#'         pd), mode = "onDisk")
#'     ppgExData(raw_data) # example run using ppgExData (see vignettes)
#'     }
peakPickGroup <- function() {
    ne <- 1
    envir = as.environment(ne)

    Defbw = dlgInput(message = "Enter the bandwidth to be used [defbw]",
        default = 20, gui = .GUI)$res
    assign("defbw", as.numeric(Defbw), envir)

    BinSize = dlgInput(message = "Enter  the size of the overlapping slices in
        mz dimension [Binsize]", default = 0.1, gui = .GUI)$res
    assign("Binsize", as.numeric(BinSize), envir)

    MF = dlgInput(message = "set the maximum number of peak groups to be
        identified in a single mz slice [Mfeat]",default = 50, gui = .GUI)$res
    assign("MFeat", as.numeric(MF), envir)


    pd <- data.frame(sample_name = sub(basename(rawfiles), pattern = filetype,
        replacement = "", fixed = TRUE), sample_group = SampleGroup,
        stringsAsFactors = FALSE)
    raw_data <- readMSData(files = rawfiles, pdata = new("NAnnotatedDataFrame",
        pd), mode = "onDisk")
    cwp <- CentWaveParam(peakwidth = c(pwMin, pwMax), snthresh = snThresh,
        prefilter = c(3, intThresh), integrate = integ, fitgauss = FALSE,
        noise = 0, verboseColumns = FALSE, firstBaselineCheck = TRUE,
        ppm = mzErrPpmMin,
        mzCenterFun = "wMean")
    xdata <- findChromPeaks(raw_data, param = cwp)
    minfrac <- (min(classSize))/length(rawfiles)
    assign("minfrac", minfrac, envir)
    pdp <- PeakDensityParam(sampleGroups = xdata$sample_group, minSamples = 2,
        maxFeatures = MFeat, bw = defbw, minFraction = 0.3, binSize = Binsize)
    xdata <- groupChromPeaks(xdata, param = pdp)

    assign("xdata", xdata, envir)

}
