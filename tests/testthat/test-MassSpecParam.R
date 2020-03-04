test_that("MassSpecParam works",{
  MassSpecParam()
  expect_true(is(c(mzStart,mzEnd,mzErrAbs,mzMax,EICsMax, sens), "numeric"))
  expect_true(is(c(mzPol,filetype), 'character'))
  expect_equal(c(mzStart,mzEnd,mzErrAbs,mzMax,EICsMax, sens), c(100,1650,0.01,3,30,0.2))
  expect_equal(c(mzPol,filetype), c('negative', '.mzXML'))
})
