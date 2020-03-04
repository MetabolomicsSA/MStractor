test_that("ppgExData works", {
  ChromParam()
  MassSpecParam()
  PeakPickingParam()
  ClassType<-c('Mix', 'Treatment1')
  DefineClassAttributes(ClassType)
  path<-system.file("extdata",package = "MStractor")
  files <- dir(path, pattern = ".mzXML", full.names = TRUE)
  pd <- data.frame(sample_name = sub(basename(files), pattern = filetype,
                                     replacement = "", fixed = TRUE), sample_group = SampleGroup,
                   stringsAsFactors = FALSE)
  raw_data <- readMSData(files =files, pdata = new("NAnnotatedDataFrame",
                                                   pd), mode = "onDisk")
  ppgExData(raw_data)
  expect_equal(length(xdata), 26400)
})
