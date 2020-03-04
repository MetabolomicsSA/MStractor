test_that("RTalign works", {
  ClassType<-c('Mix', 'Treatment1')
  DefineClassAttributes(ClassType)
  data(xdata)
  RTalign(xdata,'loess')
  expect_equal(length(xdata),26400)
})
