#' Rating scale data (e.g. Likert scale) from a Scaled Beta Distribution
#' @name lfast
#' @description \code{lfast()} generates random discrete values from a
#' (scaled Beta distribution) so the data replicate a rating scale -
#' for example,a 1-5 scale made from 5 items (questions) or 0-10
#' likelihood-of-purchase scale.
#'
#' @param n (positive, int) number of observations to generate
#' @param mean (real) target mean
#' @param sd  (real) target standard deviation
#' @param lowerbound (positive, int) lower bound (e.g. '1' for a 1-5 rating scale)
#' @param upperbound (positive, int) upper bound (e.g. '5' for a 1-5 rating scale)
#' @param items (positive, int) number of items in the rating scale. Default = 1
#' @param seed  (real) optional seed for reproducibility
#'
#' @return a vector of simulated data approximating user-specified conditions.
#'
#' @importFrom stats rbeta
#'
#' @export lfast
#'
#' @examples
#'
#' x <- lfast(
#'   n = 256,
#'   mean = 4.0,
#'   sd = 1.0,
#'   lowerbound = 1,
#'   upperbound = 7,
#'   items = 6
#' )
#'
#' x <- lfast(256, 2, 1.8, 0, 10)
#'
lfast <- function(n, mean, sd, lowerbound, upperbound, items = 1, seed) {
  range <- upperbound - lowerbound
  m <- (mean - lowerbound) / range ## rescale mean
  s <- sd / range ## rescale sd

  ## idiot check
  if (mean <= lowerbound || mean >= upperbound) {
    stop("ERROR: mean is out of range")
  }
  if (sd >= range * 0.6) {
    warning("Standard Deviation is large relative to range
            \nDerived SD will be less than specified
            \nOr the solution is not feasible, producing 'NA' values")
  }

  a <- (m^2 - m^3 - m * s^2) / s^2 ## alpha shape parameter
  b <- (m - 2 * m^2 + m^3 - s^2 + m * s^2) / s^2 ## beta shape parameter
  if (missing(seed)) {
  } else {
    set.seed(seed)
  }
  ## generate data with range 0-1 as Beta distribution
  data <- rbeta(n, a, b)
  ## rescale Beta values to desired parameters
  data <- round((data * range + lowerbound) * items) / items

  return(data)
}
