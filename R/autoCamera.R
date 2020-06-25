#' @title Spectra reconstruction using  CAMERA
#' @description uses CAMERA functions to process data. A GUI is used to enter
#'     CAMERA parameters
#' @param  x is a xcms Filled object
#' @export
#' @details Spectra reconstruction is done using the function autoCAMERA()
#'     that includes the 3 CAMERA functions groupFWHM(), findIsotopes() and
#'     groupCorr().
#'     A GUI allows the input of the function parameters.
#'     Consult CAMERA manual for more information;
#'     (https://www.bioconductor.org/packages/release/bioc/manuals/CAMERA)
#' @return PksAn
#' @seealso \code{\link[CAMERA]{groupCorr}}
#' @seealso \code{\link[CAMERA]{findIsotopes}}
#' @seealso \code{\link[CAMERA]{xsAnnotate}}
#' @seealso \code{\link[CAMERA]{groupFWHM}}
#' @examples {ChromParam()
#'     MassSpecParam()
#'     PeakPickingParam()
#'     data(xSetRef)
#'     dir.create("./QC")
#'     RTalign_xset(xSetRef,'loess')
#'     xsAlign <- group(xsAlign, method= "nearest", mzVsRTbalance= 10,
#'         mzCheck= mzErrAbs,rtCheck= rtDelta, kNN=10)
#'     xsFilled <- fillPeaks(xsAlign, method="chrom", expand.mz=0.5 )
#'     minfrac<-0.3
#'     ne <- 1
#'     envir = as.environment(ne)
#'     assign("minfrac", minfrac, envir)
#'     autoCamera(xsFilled)
#'     }
autoCamera <- function(x) {
    ne <- 1
    envir = as.environment(ne)
    sigmainput = dlgInput(message = "Enter sigma value [Sigma]",
                    default = 6, gui = .GUI)$res
    assign("Sigma", as.numeric(sigmainput), envir)
    Pfwhm = dlgInput(message = "Enter the percentage of FWHM [perfwhm]",
                    default = 1, gui = .GUI)$res
    assign("Perfwhm", as.numeric(Pfwhm), envir)
    Ival = dlgInput(message = "Enter the desired intensity value [Intval]",
                    default = "maxo",gui = .GUI)$res
    assign("Intval", Ival, envir)
    mIso = dlgInput(message = "Enter maximum number of expected
                    isotopes [maxIso]",
        default = "4", gui = .GUI)$res
    assign("maxIso", as.numeric(mIso), envir)

    pperr = dlgInput(message = "Enter the general ppm error", default = 20.03,
        gui = .GUI)$res
    assign("ppmerror", as.numeric(pperr), envir)
    Corrthresh = dlgInput(message = "Enter the group correlation
            threshold for EIC [cor_eic_th]",default = 0.7, gui = .GUI)$res
    assign("corrthresh", as.numeric(Corrthresh), envir)
    Corrthreshacs = dlgInput(message = "Enter the intensity correlation
            threshold across samples [cor_exp_th]",
            default = 0.7, gui = .GUI)$res
    assign("corexpth", as.numeric(Corrthreshacs), envir)
    pValue = dlgInput(message = "Enter the p value threshold
                    for correlation significance",
        default = 0.1, gui = .GUI)$res
    assign("pvalue", as.numeric(pValue), envir)
    xs_an <- xsAnnotate(x, polarity = mzPol)
    xs_an <- groupFWHM(xs_an, sigma = Sigma,
                perfwhm = Perfwhm, intval = Intval)
    xs_an <- findIsotopes(xs_an, maxcharge = mzMax,
                maxiso = maxIso, ppm = ppmerror,
        mzabs = mzErrAbs, intval = "maxo", minfrac = minfrac, filter = TRUE)
    xs_an <- groupCorr(xs_an, cor_eic_th = corrthresh,
                pval = pvalue, graphMethod = "hcs",calcIso = TRUE,
                calcCiS = TRUE, calcCaS = TRUE, cor_exp_th = corexpth)
    PksAn <- getPeaklist(xs_an, intval = "maxo")
    write.table(PksAn, file = paste("./QC/Pks_An", "tsv", sep = "."),
                sep = "\t",col.names = NA, row.names = TRUE)
    assign("PksAn", PksAn, envir)
    return = PksAn
}

