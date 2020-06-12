test_that("PeakPicking Param works",{
  MassSpecParam()
  PeakPickingParam()
  expect_true(is(c(pwMin, pwMax, mzErrPpmMin, mzErrPpmMax,
                   mzErrPpmMean,intThresh,snThresh,integ), "numeric"))
  expect_equal(c(pwMin, pwMax,  mzErrPpmMax,
                 intThresh,integ), c(10,20,50,2000,1))
  expect_equal(fitGauss, FALSE)
})
