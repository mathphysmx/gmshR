# add import(stats) to NAMESPACE file to import stats package
devtools::document() # or press Ctrl/Cmd + Shift + D in RStudio
devtools::load_all(".") # or press Ctrl/Cmd + Shift + L in RStudio
devtools::build()
devtools::build(binary = TRUE)

# datasets
devtools::use_data_raw()
devtools::use_data()
dfn <- data.frame(x0=c(0,0,3), y0=c(0,2,1),
		  x1=c(2,2,5), y1=c(2,0,1))
pathL <- '/media/paco/myhdd/Doctorado/Magazines/JPSE/fmt01/LaTeXsource/codes/datasets/syntheticData.txt'
len <- read.table(pathL, header = TRUE)

path <- '/media/paco/myhdd/Doctorado/Magazines/JPSE/fmt01/LaTeXsource/codes/datasets/dfn.txt'
synthDFN <- read.table(path, header = TRUE)
synthDFN <- cbind(synthDFN, len)
devtools::use_data(synthDFN, overwrite = T)

devtools::use_vignette("Vignettes")
devtools::build_vignettes()

