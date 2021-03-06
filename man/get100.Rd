% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get100.R
\name{get100}
\alias{get100}
\title{Get 100 features}
\usage{
get100(x)
}
\arguments{
\item{x}{is a XCMSnExp object (for the reference file replicates)
after peak picking and grouping are performed.}
}
\value{
Na
}
\description{
Prints a .png showing 100 features across the RT range
    of the reference files.
}
\details{
The graphical output is stored in the QC folder created in
    the previous steps of the workflow.
}
\examples{
{ChromParam()
    MassSpecParam()
    PeakPickingParam()
    SampleGroup<-c("Mix", "Mix")
    symbol<-c(1,1)
    ClassCol<-c("#FF0000FF", "#FF0000FF")
    path<-system.file("extdata",package = "MStractor")
    files <- dir(path, pattern = ".mzXML", full.names = TRUE)
    test<-files[1:2]
    pd <- data.frame(sample_name = sub(basename(test), pattern = filetype,
        replacement ="", fixed = TRUE),
        sample_group = SampleGroup, stringsAsFactors = FALSE)
    ref_data <- readMSData(test,
        pdata = new("NAnnotatedDataFrame", pd), mode = "onDisk")
    expRefData(ref_data)
    dir.create('./QC')
    get100(x_refs)
    }
}
\seealso{
\code{\link[xcms]{chromatogram-method}}
}
