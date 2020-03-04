test_that("xsetConvert works", {
  data(xdata)
  xsetConvert(xdata)
  sampnames(xset)<-spn
  expect_equal(scanrange(xset), c(1,4400))
})
