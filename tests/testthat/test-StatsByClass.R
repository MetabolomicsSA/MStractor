test_that("StatsByClass works", {
  data(xSetRef)
  data(BasePksCur)
  MedianNormalize( BasePksCur,xSetRef)
  ClassType<-c('Mix', 'Treatment1')
  ne <- 1
  envir = as.environment(ne)
  assign("ClassType", ClassType, envir)
  StatsByClass(ClassType, xSetRef)
  expect_equal(nrow(descriptive_stats[[1]]), 101)
})
