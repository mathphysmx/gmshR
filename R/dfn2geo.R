#' @title Line Segments to gmsh .geo format export
#'
#' @description Line Segments to gmsh .geo format export
#'
#' @param x data frame of line segments ends coordinates.
#' @param cl Numeric scalar. Characteristic length of gmsh. It tunes up the meshing.
#' @param file The name of the (possibly exported) .geo file.
#' @param idStart Non-negative integer scalar. This value is the first identification number (ID) for the geometric elements to be written to file.
#' @param add This helps to save the DFN.geo to a file
#'
#' @details To mesh the .geo files in the examples, see \link{exportDfn2geo}. To view this .geo <file> in gmsh software, go to the directory, then run in the terminal \code{gmsh <fileWithExtension>}.
#'
#' @return If \code{add}, a file named <file>.
#' @export
#'
#' @examples
#' data(dfn)
#' plot(x = NA, xlim= c(0,5), ylim = c(0,3))
#' segments(dfn$x0, dfn$y0, dfn$x1, dfn$y1, col = 'blue')
#' # write to file in the current working directory
#' dfn2geo(x = dfn)
#'
#' # Another saving-to-file example
#' dfn2geo(x = dfn, idStart = 3)
#' write('// This is another file', file = "new.geo")
#' dfn2geo(x = dfn, file = 'new.geo', add = TRUE)
dfn2geo <- function(x, cl=0.1, file="dfn.geo",
		    idStart = 1, add = FALSE){

	x0 <- cbind(x[,1:2],0, 'cl')
	x1 <- cbind(x[,3:4],0, 'cl')
	n <- nrow(x)
	id <- idStart:(idStart + n - 1)

	write('// Discrete Fracture Network, DFN',
	      file=file, append = add)
	write(paste0('cl = ', cl, ';'),
	      file=file, append = TRUE)

	# Points
	id0 <- paste0(id,'0')
	id1 <- paste0(id,'1')
	x0 <- gmshEnt('p', id0, x0)
	x1 <- gmshEnt('p', id1, x1)
	write(paste(x0, x1, sep = '\t'), file=file, append = TRUE)

	# Lines
	lineChar <- gmshEnt('l', id, cbind(id0,id1))
	write(lineChar, file=file, append = TRUE)
	write('', file=file, append = TRUE)

}
