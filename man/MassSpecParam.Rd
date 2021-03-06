% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MassSpecParam.R
\name{MassSpecParam}
\alias{MassSpecParam}
\title{Mass Spectrometry Parameter Definition.}
\usage{
MassSpecParam()
}
\value{
returns a list of input mass spectrometry parameters
}
\description{
Define and store Mass Spec parameters and file type via GUI.
}
\details{
The Parameters are the acquisition mode(negative as default);
    the mass range to be considered (mz start and mz end);
    the number of expected charges (default value set at 3);
    the filetype (default set to mzXML);
    the maximum number of chromatographic peaks expected for a single EIC;
    the sensitivity.
}
\examples{
{MassSpecParam()}
}
\seealso{
\code{\link[xcms]{findChromPeaks-centWave}}
}
