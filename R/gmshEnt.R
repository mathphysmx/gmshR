#' @title Utility to make .geo (gmsh) format
#'
#' @description Utility to make .geo (gmsh) format
#'
#' @details See \link{dfn2geo} code for an example on how to write the output of this function to a file. See http://gmsh.info/doc/texinfo/gmsh.html#Geometry-commands
#' @param ent Character representing gmsh entities. Possible options are:
#' "p" = Points
#' "l" = Line
#' "ll" = Line Loop
#' "ps" = "Plane Surface",
#' "Pp" = Physical Point
#' "Pl" = Physical Line
#' "Ps" = Physical Surface
#' "Pv" = Physical Volume
#' @param id Identification number.
#' @param ele elements of each entity.
#'
#' @return
#' A character vector. See examples.
#' @export
#'
#' @examples
#' gmshEnt(en="p", id = 1:2, ele=3:4)
#' gmshEnt(en="l", id = 1:2, ele=cbind(1:2, 10:11))
# ToDo: summarize/implement for all See http://gmsh.info/doc/texinfo/gmsh.html#Geometry-commands
	### 5.1.2 Lines
	# b = "Bezier"
	# bs = "BSpline"
	# s = "Spline"
	# c = "Circle"
	# e = "Ellipse"
	# ll = "Line Loop"
	# w = "Wire"
	# Cl = "Compound Line"
	### 5.1.3 Surfaces
	# S = "Surface"
	# D = "Disk"
	# R = "Rectangle"
	# Sl = "Surface Loop"
	# CS = "Compound Surface"
	### 5.1.3 Volume
gmshEnt <- function(ent="p", id = 1, ele = 2){
  ent <- switch(ent,
                p  = "Point",
                l  = "Line",
                ll = "Line Loop",
		ps = "Plane Surface",
                Pp = "Physical Point",
                Pl = "Physical Line",
                Pl = "Physical Surface",
                PV = "Physical Volume",
		)

  if(!is.vector(ele)){
    ele = data.frame(ele)
    ele <- c(ele, sep=",")
    ele <- do.call("paste",ele)
  }

  x <- paste0(ent,"(", id, ")={",ele,"};")

  return(x)
}
