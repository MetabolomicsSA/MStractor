test_that("expRefData works", {
  ChromParam()
  MassSpecParam()
  PeakPickingParam()
  SampleGroup<-c("Mix", "Mix")
  symbol<-c(1,1)
  ClassCol<-c("#FF0000FF", "#FF0000FF")
  path<-system.file("extdata",package = "MStractor")
  files <- dir(path, pattern = ".mzXML", full.names = TRUE)
  test<-files[1:2]
  pd <- data.frame(sample_name = sub(basename(test), pattern = filetype,
                  replacement ="", fixed = TRUE),sample_group = SampleGroup, stringsAsFactors = FALSE)
  ref_data <- readMSData(test, pdata = new("NAnnotatedDataFrame",
                                                   pd), mode = "onDisk")
  expRefData(ref_data)
  expect_equal(length(x_refs), 8800)
})


