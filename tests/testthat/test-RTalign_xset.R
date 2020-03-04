test_that("RTalign_xset works", {
  data(xSetRef)
  dir.create('./QC')
  RTalign_xset(xSetRef,'loess')
  expect_equal(length(xsAlign@peaks),22968)
})


