test_that("getTICs works", {
  ClassType<-c('Mix', 'Treatment1')
  DefineClassAttributes(ClassType)
  data(xdata)
  xsetConvert(xdata)
  sampnames(xset)<-spn
  dir.create('./QC')
  getTICs(xcmsSet= xset, pngName= "./QC/TICs_raw.png", rt= "raw")
  expect_true(file.exists('./QC/TICs_raw.png'))
})
