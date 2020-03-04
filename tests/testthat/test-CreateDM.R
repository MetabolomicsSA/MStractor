test_that("CreateDM works", {
    data(xdata)
    dir.create("./QC")
    xdata <- groupChromPeaks(xdata,
        param = PeakDensityParam(sampleGroups = xdata$sample_group,
        minFraction = 0.3, bw = 20))
    xfilled <- fillChromPeaks(xdata, param =(FillChromPeaksParam(ppm = 50, expandMz = 0.5)))
    CreateDM(xfilled, 'into')
    expect_equal(nrow(FilledPeakMat),736)

})
