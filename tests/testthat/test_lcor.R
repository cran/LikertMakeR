#' Rearrange columns in a data-frame to fit a predefined correlation matrix
#'
#' @name lcor
#'
#' @description \code{lcor()} rearranges values in each column of a
#' data-frame so that columns are correlated to match a predefined
#' correlation matrix.
#'
#' @details Values in a column do not change, so univariate
#' statistics remain the same.
#'
#'
#' @param data beginning data-frame that is to be rearranged
#' @param target target correlation matrix - should be a symmetric
#' (square) k*k matrix
#'
#' @return Returns a data-frame whose column-wise correlations
#' approximate a user-specified correlation matrix
#'
#' @importFrom stats cor
#' @importFrom stats rbeta
#'
#' @export lcor
#'
#' @examples
#'
#' ## generate uncorrelated synthetic data
#'
#' n <- 32
#' x1 <- lfast(n, 3.5, 1.0, 1, 5, 5)
#' x2 <- lfast(n, 1.5, 0.75, 1, 5, 5)
#' x3 <- lfast(n, 3.0, 2.0, 1, 5, 5)
#'
#' mydat3 <- cbind(x1, x2, x3) |> data.frame()
#'
#' cor(mydat3)
#'
#' ## describe a target correlation matrix
#' tgt3 <- matrix(
#'   c(
#'     1.00, 0.50, 0.75,
#'     0.50, 1.00, 0.25,
#'     0.75, 0.25, 1.00
#'   ),
#'   nrow = 3
#' )
#'
#' ## apply lcor function
#' new3 <- lcor(mydat3, tgt3)
#'
#' cor(new3) |> round(3)
#'
lcor <- function(data, target) {
  multiplier <- 10000
  current_dat <- data
  current_cor <- cor(current_dat)
  target_cor <- target
  diff.score <- sum((abs(target_cor - current_cor)) * multiplier)
  n <- nrow(current_dat)
  nc <- ncol(current_dat)

  ## generate a complete list of value-pairs as switch candidates
  ye <- expand.grid(c(1:n), c(1:n))
  ## no need to switch with yourself
  ye <- subset(ye, ye[, 1] != ye[, 2])
  ny <- nrow(ye)

  ## begin column selection loop
  ## for each column in the data set ...
  for (r in 1:ny) {
    ## Other columns are relative to first column
    ##
    ### begin row values swap loop
    for (colID in 2:nc) {
      ## locate data points to switch
      i <- ye[r, 1]
      j <- ye[r, 2]

      ## check that values in two locations are different
      if (current_dat[i, colID] == current_dat[j, colID]) {
        break
      }

      ## record values in case they need to be put back
      ii <- current_dat[i, colID]
      jj <- current_dat[j, colID]

      ## swap the values in selected locations
      current_dat[i, colID] <- jj
      current_dat[j, colID] <- ii

      ## if switched values reduce the difference between correlation
      ## matrices then keep the switch, otherwise put them back
      if (sum((abs(target_cor - cor(current_dat))) * multiplier) < diff.score) {
        ## update data-frame and target statistic
        current_cor <- cor(current_dat)
        diff.score <- sum((abs(target_cor - current_cor)) * multiplier)
      } else {
        ## swap values back
        current_dat[i, colID] <- ii
        current_dat[j, colID] <- jj
      }
    } ## end row values swap loop
  } ## end column selection loop

  return(current_dat)
} ## end lcor function
