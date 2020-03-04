test_that("FilterDM works", {
  data(xSetRef)
  data(PksAnDF)
  FilterDM(PksAnDF, xSetRef)
  expect_equal(nrow(BasePks),239)
})
