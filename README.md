# MStractor 
Please note that this version of the script has been tested  using Bioconductor version 3.8.1 and R version 3.6.2 

MStractor is an R workflow package for non-targeted processing of LC-MS data 
The MStractor workflow performs the following: 
1. Feature extraction (m/z-retention-time pair) using XCMS. 
2. Retention time alignment of the detected features across the samples composing the analytical set. 
3. Recognition and annotation of isotope clusters, fragments and charge states using CAMERA. 
4. Molecular feature filtering based on multiple criteria and conservative usage of intensity thresholds for maximum sensitivity. 
5. Creation of a data matrix summarizing the data processing results. 

MStractor shows some additional features such as:  
1. Parameterization based on user provided inputs obtained from instrument specifications and reference measurements. 
2. Graphical tools for real-time quality monitoring and optimization of the feature extraction process 
## Getting started 
The package is availabe to download as tar.gz under the 'releases' section. 
All the instructions are included in the package documentation
## Case study 
A case study to test the script is available. 
A LCMS data set is included in the package, please see vignettes and package documentation for details
Raw data are available for download in exdata.zip. Extract the files locally  in the inst/  directory.
## Developers 
The workflow was developed by the Metabolomics South Australia team at The Australian Wine Research Institute. 
Funding has been provided by Bioplatforms Australia (BPA) under the National Collaborative Research Infrastructure Strategy (NCRIS) 
## References 
1) Smith, C.A. and Want, E.J. and O'Maille, G. and Abagyan,R. and Siuzdak, G.: XCMS: Processing mass spectrometry data for metabolite profiling using nonlinear peak alignment, matching and identification, Analytical Chemistry, 78:779-787 (2006) 
2) Ralf Tautenhahn, Christoph Boettcher, Steffen Neumann: Highly sensitive feature detection for high resolution LC/MS BMCBioinformatics, 9:504 (2008) 
3) H. Paul Benton, Elizabeth J. Want and Timothy M. D. Ebbels Correction of mass calibration gaps in liquid chromatography-mass spectrometry metabolomics data Bioinformatics, 26:2488 (2010) 
4) Kuhl, C., Tautenhahn, R., Boettcher, C., Larson, T. R. and Neumann, 
S. CAMERA: an integrated strategy for compound spectra extraction and annotation of liquid chromatography/mass spectrometry data sets. Analytical Chemistry, 84:283-289 (2012) 
 
