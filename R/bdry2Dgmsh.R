#' @title Export polygon points (vertices) to a gmsh .geo file
#'
#' @description Export polygon points (vertices) to a gmsh .geo file
#'
#' @param x 2-columns table (data.frame, matrix, array). The first column are the x coordinates and the 2nd column the y coordinates of the open polygon.
#' @param cl Numeric scalar. Characteristic length of gmsh. It tunes up the meshing.
#' @param file The name of the exported .geo file.
#' @param idStart Non-negative integer scalar. This value is the first identification number (ID) for the geometric elements to be written to file.
#' @param add This helps to save the DFN.geo to a file
#'
#' @details The polygonal boundary does not need to enclose all the gmsh elements; but the meshing will only be made inside the polygon. See examples.
#'
#' @return If \code{add}, a file named <file>.
#' @export
#'
#' @examples
#' x <- cbind(x = c(0,6,6,0), y = c(0,0,3, 3))
#' plot(x, type='l', col = 'blue')
#' # write boundary to file in the current working directory
#' bdry2Dgmsh(x)
#'
#' # Another saving-to-file example
#' bdry2Dgmsh(x, idStart = 10001)
#' write('// This is another file', file = "newBdry.geo")
#' bdry2Dgmsh(x, file = 'newBdry.geo', add = TRUE)
bdry2Dgmsh <- function(x, cl=0.1, file="dfnBdry.geo",
			idStart = 1, add = FALSE){

	x <- cbind(x, 0, 'cl')
	n <- nrow(x)
	idEnd <- idStart + n - 1
	id <- idStart:idEnd

	# Points
	write('// Boundary', file=file, append = add)
	write(paste0('cl = ', cl, ';'),
	      file=file, append = TRUE)
	write(gmshEnt('p', id, x), file=file, append = TRUE)

	# Lines
	lineChar <- gmshEnt('l', id = id,
			    ele = intervaLims(c(id, idStart)))
	write(lineChar, file=file, append = TRUE)

	lineLoop <- gmshEnt('ll', id = 1,
			    paste(idStart,idEnd,sep=':'))
	write(lineLoop, file=file, append = TRUE)
	surf <- gmshEnt('ps', id = 1, 1)
	write(surf, file=file, append = TRUE)
	write('', file=file, append = TRUE)

}
