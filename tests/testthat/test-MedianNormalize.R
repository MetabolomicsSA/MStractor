test_that("Median Normalize works", {
 data(xSetRef)
 data(BasePksCur)
 MedianNormalize(BasePksCur,xSetRef)
 expect_equal((NormalizedMatrix[1,4]),0.8377)
})
