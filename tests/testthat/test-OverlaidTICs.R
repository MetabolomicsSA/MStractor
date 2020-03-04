test_that("OveralidTICs works", {
  ClassType<-c('Mix', 'Treatment1')
  DefineClassAttributes(ClassType)
  dir.create('./QC')
  data(xdata)
  OverlaidTICs(xdata, 'raw')
  expect_true(file.exists("./QC/TICs_ raw .png"))
})

