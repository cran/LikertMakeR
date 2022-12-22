## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------

  library(LikertMakeR)

## -----------------------------------------------------------------------------

## a four-item, five-point Likert scale

x <- lfast(
  n = 512,
  mean = 2.0,
  sd = 1.0,
  lowerbound = 1,
  upperbound = 5,
  items = 4
)

## ----fig1, fig.height=3, fig.width=4, fig.align='center', echo = FALSE--------

## distribution of x

hist(x,
  cex.axis = 0.5, cex.main = 0.75,
  breaks = seq(from = 1, to = 5, by = 0.25),
  col = "sky blue", xlab = NULL, ylab = NULL,
  main = paste("mu=", round(mean(x), 2), ", sd=", round(sd(x), 2))
)

## -----------------------------------------------------------------------------

## an 11-point likelihood-of-purchase scale

x <- lfast(256, 2, 2, 0, 10)

## ----fig2, fig.height=3, fig.width=4, fig.align='center', echo = FALSE--------

hist(x,
  cex.axis = 0.5, cex.main = 0.75,
  breaks = seq(from = 0, to = 10, by = 1.0),
  col = "sky blue", xlab = NULL, ylab = NULL,
  main = paste("mu=", round(mean(x), 2), ", sd=", round(sd(x), 2))
)

## -----------------------------------------------------------------------------

x <- lexact(
  n = 64,
  mean = 2.5,
  sd = 1.0,
  lowerbound = 1,
  upperbound = 5,
  items = 4
)

## ----fig3, fig.height=3, fig.width=4, fig.align='center', echo = FALSE--------

hist(x,
  cex.axis = 0.5, cex.main = 0.75,
  breaks = seq(from = 1, to = 5, by = 0.25),
  col = "sky blue", xlab = NULL, ylab = NULL,
  main = paste("mean=", round(mean(x), 2), ", sd=", round(sd(x), 2))
)

## -----------------------------------------------------------------------------

x <- lexact(64, 2, 1.8, 0, 10)

## ----fig4,  fig.height=3, fig.width=4, fig.align='center', echo = FALSE-------

hist(x,
  cex.axis = 0.5, cex.main = 0.75,
  breaks = c(0:10),
  col = "sky blue",
  xlab = NULL, ylab = NULL,
  main = paste("mu=", round(mean(x), 2), ", sd=", round(sd(x), 2))
)

## -----------------------------------------------------------------------------

n <- 32

x1 <- lexact(n, 2.5, 0.75, 1, 5, 5)
x2 <- lexact(n, 3.0, 1.50, 1, 5, 5)
x3 <- lexact(n, 3.5, 1.00, 1, 5, 5)

mydat3 <- cbind(x1, x2, x3) |> data.frame()

## ---- echo = FALSE------------------------------------------------------------

head(mydat3, 10)

## ---- echo = FALSE------------------------------------------------------------

apply(mydat3, 2, mean) |> round(3)

## ----echo=FALSE---------------------------------------------------------------

apply(mydat3, 2, sd) |> round(3)

## ---- echo = FALSE------------------------------------------------------------

cor(mydat3) |> round(2)

## -----------------------------------------------------------------------------

## describe a target correlation matrix

tgt3 <- matrix(
  c(
    1.00, 0.80, 0.75,
    0.80, 1.00, 0.90,
    0.75, 0.90, 1.00
  ),
  nrow = 3
)

## -----------------------------------------------------------------------------

## apply lcor function

new3 <- lcor(mydat3, tgt3)

## ---- echo = FALSE------------------------------------------------------------

cor(new3) |> round(2)

## ---- eval = FALSE------------------------------------------------------------
#  
#       n <- 128
#       sample(1:5, n, replace = TRUE,
#         prob = c(0.1, 0.2, 0.4, 0.2, 0.1)
#       )

