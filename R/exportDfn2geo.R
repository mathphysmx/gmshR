#' @title dfn to gmsh .geo file generation
#'
#' @description dfn to gmsh .geo file generation
#'
#' @param dfn data frame of line segments ends coordinates.
#' @param bdry 2-columns table (data.frame, matrix, array). The first column are the x coordinates and the 2nd column the y coordinates of the open polygon.
#' @param cl cl Numeric scalar. Characteristic length of gmsh. It tunes up the meshing.
#' @param file The name of the exported .geo file.
#'
#' @details To mesh the .geo files in the examples, go to the <file> directory, and run in the terminal \code{gmsh -2 <file>}. To view run in the terminal \code{gmsh -2 <file>.geo <file>.msh}.
#'
#' @return A file named <file>.
#' @export
#'
#' @examples
#'# Example 1
#'loweLeftrCorner <- -1
#'bdry <- cbind(x = c(loweLeftrCorner,6,6,0), y = c(loweLeftrCorner,0,3, 3))
#' data(dfn)
#' exportDfn2geo(dfn, bdry, cl = 0.1, file = 'dfn.geo')
#'
#'# Example 2
#' data(synthDFN)
#' print(min(synthDFN$lengthCm))
#' bdry <- cbind(x = c(-1,401, 401, -1),
#'	      y = c(-1,-1,  401, 401))
#' exportDfn2geo(dfn = synthDFN, bdry,
#' 	cl = min(synthDFN$lengthCm), file = 'newDfn.geo')

exportDfn2geo <- function(dfn, bdry, cl, file){

	nf <- nrow(dfn)
	nb <- nrow(bdry)

	write('// gmsh file\n', file = file)
	bdryStart = 10*(nf+1)
	bdry2Dgmsh(x = bdry, cl, idStart=bdryStart,
		   file, add = T)
	dfn2geo(x = dfn, cl, idStart=1,
		file, add = T)

	idLine <- paste(1:nf, collapse= ',')
	ind <- paste0('Line{', 1,':', nf,'} In Surface{1};')
	write(ind, file = file, append = T)

}

