#' @title Vector conversion to m x 2 matrix of interval limits
#'
#' @description Vector conversion to m x 2 matrix of interval limits
#'
#' @param x Numeric vector of increasing values (\code{x[i] < x[j], i<j}) that are the limits of the partition of an interval with limits \code{x[1]} and \code{x[n]}. Where \code{length(x)=n+1}.
#' @details This code was implemented having in mind a mixture of disjoint uniform distributions.
#'
#' @return
#' A m x 2 matrix with each row giving the limits of one interval.
#' @export
#'
#' @examples
#' xe <- c(0,1, 4,6)
#' intervaLims(xe)
#see also http://stackoverflow.com/questions/41132081/find-which-interval-row-in-a-data-frame-that-each-element-of-a-vector-belongs-in
intervaLims <- function(x){

	m <- length(x) - 1
	b <- matrix(data = NA,
		    nrow = m, ncol = 2,
		    byrow = TRUE)

	for(i in 1:m){
		b[i,] <- x[i:(i+1)]
	}

	return(b)
}

