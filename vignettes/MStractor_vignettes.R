## ----install_pacakge, eval=FALSE----------------------------------------------
#  setRepositories(ind=1:2)
#  
#  remotes::install_local("C:/pathtoPackage/MStractor_0.1.0.tar.gz",
#   '               dependencies=NA)
#  

## ----load_library, message=FALSE, warning= FALSE------------------------------
library(MStractor)


## ----define_project, eval=FALSE-----------------------------------------------
#  Project()
#  #Skip this step if using the dataset provided within the package

## ----load_package_dataset, message=FALSE--------------------------------------
path<-system.file("extdata",package = "MStractor")
files <- dir(path, pattern = ".mzXML", full.names = TRUE)


## ----eval= TRUE---------------------------------------------------------------
ChromParam()

MassSpecParam()
# leave default values if using the package dataset

## ----eval=FALSE---------------------------------------------------------------
#  
#  LoadData()
#  #Skip this step if using the dataset provided within the package
#  

## ----eval=TRUE----------------------------------------------------------------

ClassType<-c('Mix','Treatment1')## don't run if using the the provided dataset
DefineClassAttributes(ClassType)

## ----eval=TRUE----------------------------------------------------------------
#leave default values if using the package dataset
PeakPickingParam()


## ----eval=FALSE---------------------------------------------------------------
#  exploreRefs()
#  

## ----eval=TRUE, message=FALSE, results='hide',warning=FALSE-------------------
dir.create("./QC")
SampleGroup<-c("Mix", "Mix")
symbol<-c(1,1)
ClassCol<-c("#FF0000FF", "#FF0000FF")
path<-system.file("extdata",package = "MStractor")
files <- dir(path, pattern = ".mzXML", full.names = TRUE)
test<-files[1:2]
pd <- data.frame(sample_name = sub(basename(test), pattern = filetype,
    replacement ="", fixed = TRUE),sample_group = SampleGroup,
    stringsAsFactors = FALSE)
ref_data <- readMSData(test, pdata = new("NAnnotatedDataFrame",
    pd), mode = "onDisk")
expRefData(ref_data)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
refTic(x_refs)

## ----eval=TRUE, message=FALSE, results='hide'---------------------------------
get100(x_refs)

## ----eval=FALSE---------------------------------------------------------------
#  peakPickGroup() # don't run if using the example dataset

## ----eval=TRUE, results='hide', message=FALSE, warning=FALSE------------------
ClassType<-c('Mix', 'Treatment1')
SampleGroup<-c("Mix",        "Mix",        "Mix",        "Treatment1", "Treatment1", "Treatment1")
symbol<-c(1 ,1, 1, 2,2, 2)
ClassCol<- c("#FF0000FF", "#FF0000FF", "#FF0000FF", "#00FFFFFF", "#00FFFFFF", "#00FFFFFF")
path<-system.file("extdata",package = "MStractor")
files <- dir(path, pattern = ".mzXML", full.names = TRUE)
pd <- data.frame(sample_name = sub(basename(files), pattern = filetype,
    replacement = "", fixed = TRUE), sample_group = SampleGroup,
    stringsAsFactors = FALSE)
raw_data <- readMSData(files =files, pdata = new("NAnnotatedDataFrame",
    pd), mode = "onDisk")
ppgExData(raw_data) 


## ----eval=TRUE, message=FALSE, results='hide', warning=FALSE------------------
OverlaidTICs(xdata, 'raw') #raw indicates non-retention time aligned signals
printEICs(xdata, 'raw')


## ----eval=TRUE, message=FALSE, results='hide', warning=FALSE------------------
RTalign(xdata,'loess')

xdata <- groupChromPeaks(xdata, param = PeakDensityParam(sampleGroups = 
        xdata$sample_group, minFraction = 0.3, bw = 20))     

xfilled <- fillChromPeaks(xdata, param =(FillChromPeaksParam(ppm = 50, 
        expandMz = 0.5)))


## ----eval=TRUE, message=FALSE, results='hide', warning=FALSE------------------
OverlaidTICs(xdata, 'aligned')        
printEICs(xfilled, 'filled')
#'aligned' and 'filled' indicate retention time aligned signals

## ----eval=TRUE----------------------------------------------------------------
CreateDM(xfilled,'maxo')

## ----eval=TRUE----------------------------------------------------------------
xsetConvert(xfilled)
sampnames(xset)<-spn

## ----eval=TRUE----------------------------------------------------------------
xsetConvert(xdata)
sampnames(xset)<-spn

## ----eval=FALSE---------------------------------------------------------------
#  getTICs(xcmsSet= xset, pngName= "./QC/TICs_raw.png", rt= "raw")
#  #raw indicates non-retention time aligned signals
#  printEICsXset(xset,'raw')
#  

## ----eval=FALSE---------------------------------------------------------------
#  RTalign_xset(xset,'loess')
#  xsAlign <- group(xsAlign, method= "nearest", mzVsRTbalance= 10, mzCheck=
#          mzErrAbs,rtCheck= rtDelta, kNN=10)
#  xsFilled <- fillPeaks(xsAlign, method="chrom", expand.mz=0.5)

## ----eval=FALSE---------------------------------------------------------------
#  getTICs(xcmsSet= xsAlign, pngName= "./QC/TICs_Aligned.png", rt= "corrected")
#  printEICsXset(xsFilled,'corrected')
#  # 'corrected' indicates retention time aligned signals

## ----eval=TRUE----------------------------------------------------------------
autoCamera(xset)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
FilterDM(PksAn, xset)

#the second argument of the function below is either 'filled' (branch a) or "corrected' (branch b)
CollectBP_EICs(BasePks,'filled') 
#after this step manual curation is necessary 
BasePks_Curated(BasePks)
MedianNormalize(BasePksCur, xset)

## ----eval=TRUE----------------------------------------------------------------
StatsByClass(ClassType, xset)

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

