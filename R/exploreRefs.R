#' @title Evaluation of Peak Detection
#' @description Define parameters and performs peak detection using the
#'     reference files selected via the funtion Project()
#' @details First, a GUI allows to define the settings of xcms functions
#'     findChromPeaks and groupChromPeaks which perform peak picking
#'     and grouping of molecular features.
#'     Secondly, data files are read using the xcms function readMSData.
#'     Lastly, peak picking and grouping is carried out.
#'     The output of the function is the XCMSnEXP object x_refs.
#' @export
#' @return Na
#' @seealso \code{\link[xcms]{findChromPeaks-centWave}}
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
#'         replacement ="", fixed = TRUE),sample_group = SampleGroup,
#'         stringsAsFactors = FALSE)
#'     ref_data <- readMSData(test, pdata = new("NAnnotatedDataFrame",
#'         pd), mode = "onDisk")
#'     expRefData(ref_data) # example run using expRefData (see vignettes)
#' }
exploreRefs <- function() {
    ne <- 1
    envir = as.environment(ne)

    dbw = dlgInput(message = "Enter the bandwidth to be used", default = 25,
        gui = .GUI)$res
    assign("defbw", as.numeric(dbw), envir)

    BSize = dlgInput(message = "Enter  the size of the overlapping slices
            in mz dimension[Binsize]",default = 0.1, gui = .GUI)$res
    assign("Binsize", as.numeric(BSize), envir)

    MF = dlgInput(message = "set the maximum number of peak groups to be
        identified in a single mz slice",
        default = 50, gui = .GUI)$res
    assign("MFeat", as.numeric(MF), envir)


    pd_ref <- data.frame(sample_name = sub(basename(QCReps),
        pattern = filetype,replacement = "", fixed = TRUE),
        sample_group = rep("QC", length(QCReps)),
        stringsAsFactors = FALSE)

    raw_refs <- readMSData(files = QCReps, pdata = new("NAnnotatedDataFrame",
        pd_ref), mode = "onDisk")

    cwp_ref <- CentWaveParam(peakwidth = c(pwMin, pwMax), snthresh = snThresh,
        prefilter = c(5, intThresh), mzCenterFun = "mean", integrate = integ,
        mzdiff = mzdifference, fitgauss = fitGauss, noise = intThresh,
        verboseColumns = FALSE,
        firstBaselineCheck = TRUE, ppm = mzErrPpmMin * 2)

    x_refs <- findChromPeaks(raw_refs, param = cwp_ref)


    pdp <- PeakDensityParam(sampleGroups = rep("QC", length(QCReps)),
        minSamples = 2, maxFeatures = MFeat, bw = defbw, minFraction = 0.3,
        binSize = Binsize)
    x_refs <- groupChromPeaks(x_refs, param = pdp)
    assign("x_refs", x_refs, envir)

}
