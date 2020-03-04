test_that("ChromParam works",{
  ChromParam()
  expect_true(is(c(rtStart,FWHMmin,FWHMmax,rtDelta), "numeric"))
  expect_true(is(rtEnd, 'character'))
  expect_equal(rtStart, 1)
  expect_equal(c(rtStart,FWHMmin,FWHMmax,rtDelta), c(1,10,90,32))
  expect_equal(rtEnd, 'max')
})
