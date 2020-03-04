#' @title Perform peak detection and grouping on the example dataset
#' @description to be used on the example dataset  available within pacakge
#' @param  x is an OnDisk XCMSnExp raw data-set
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
#'     ppgExData(raw_data)
#' }
ppgExData <- function(x) {
    ne <- 1
    envir = as.environment(ne)

    Defbw = dlgInput(message = "Enter the bandwidth to be used", default = 20,
        gui = .GUI)$res
    assign("defbw", as.numeric(Defbw), envir)

    BinSize = dlgInput(message = "Enter  the size of the overlapping slices
        in mz dimension",default = 0.1, gui = .GUI)$res
    assign("Binsize", as.numeric(BinSize), envir)

    MF = dlgInput(message = "set the maximum number of peak groups to be
        identified in a single mz slice", default = 50, gui = .GUI)$res
    assign("MFeat", as.numeric(MF), envir)

    cwp <- CentWaveParam(peakwidth = c(pwMin, pwMax), snthresh = snThresh,
        prefilter = c(3, intThresh), integrate = integ, fitgauss = FALSE,
        noise = 0, verboseColumns = FALSE, firstBaselineCheck = TRUE,
        ppm = mzErrPpmMin,mzCenterFun = "wMean")
    xdata <- findChromPeaks(x, param = cwp)
    classSize<-c(3,3,3)
    minfrac <- (min(classSize))/length(sampleNames(raw_data))
    assign("minfrac", minfrac, envir)
    pdp <- PeakDensityParam(sampleGroups = xdata$sample_group, minSamples = 2,
        maxFeatures = MFeat, bw = defbw, minFraction = 0.3, binSize = Binsize)
    xdata <- groupChromPeaks(xdata, param = pdp)

    assign("xdata", xdata, envir)

}
