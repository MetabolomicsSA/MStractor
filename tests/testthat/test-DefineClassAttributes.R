test_that("DefineClassAttributes works", {
  ClassType<-c('Mix','Treatment1')
  DefineClassAttributes(ClassType)
  expect_equal(SampleGroup, c('Mix','Mix','Mix','Treatment1','Treatment1','Treatment1'))
  expect_equal(symbol, c(1,1,1,2,2,2))
  expect_equal(length(ClassCol), 6)

})
