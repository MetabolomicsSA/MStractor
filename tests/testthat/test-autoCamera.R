test_that("autoCamera works", {
  ChromParam()
  MassSpecParam()
  PeakPickingParam()
  data(xSetRef)
  dir.create("./QC")
  RTalign_xset(xSetRef,'loess')
  xsAlign <- group(xsAlign, method= "nearest", mzVsRTbalance= 10,
      mzCheck= mzErrAbs,rtCheck= rtDelta, kNN=10)
  xsFilled <- fillPeaks(xsAlign, method="chrom", expand.mz=0.5 )
      printEICsXset(xSetRef,'corrected')
  minfrac<-0.3
  ne <- 1
  envir = as.environment(ne)
  assign("minfrac", minfrac, envir)
  autoCamera(xsFilled)
  expect_equal(length(PksAn),18)
  })

