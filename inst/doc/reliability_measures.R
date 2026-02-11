## -----------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# library(dplyr)
# library(tibble)
# library(kableExtra)
# library(tidyr)
library(LikertMakeR)


## -----------------------------------------------------------------------------
# reliability(
#   data,
#   include = "none",
#   ci = FALSE,
#   ci_level = 0.95,
#   n_boot = 1000,
#   na_method = c("pairwise", "listwise"),
#   min_count = 2,
#   digits = 3,
#   verbose = TRUE
# )

## -----------------------------------------------------------------------------
# include = c("lambda6", "polychoric")

## -----------------------------------------------------------------------------
# ordinal_diagnostics(result)

## -----------------------------------------------------------------------------
# example correlation matrix
my_cor <- LikertMakeR::makeCorrAlpha(
  items = 4,
  alpha = 0.80
)

# example correlated dataframe
my_data <- LikertMakeR::makeScales(
  n = 64,
  means = c(2.75, 3.00, 3.25, 3.50),
  sds = c(1.25, 1.50, 1.30, 1.25),
  lowerbound = rep(1, 4),
  upperbound = rep(5, 4),
  cormatrix = my_cor
)

## -----------------------------------------------------------------------------
# $\alpha$ and $\omega$

reliability(my_data)

## -----------------------------------------------------------------------------
# $\alpha$, $\omega$ (total), $\lambda 6$, $\omega_h$, and ordinal variants

reliability(
  my_data,
  include = c("lambda6", "omega_h", "polychoric")
)

## -----------------------------------------------------------------------------
library(knitr)
library(kableExtra)

decision_table <- data.frame(
  Situation = c(
    "Legacy comparison, simple reporting",
    "Single-factor scale, unequal loadings",
    "Strength of general factor", 
    "Likert items with skew or ceiling effects",
    "Teaching or demonstration",
    "Ordinal data, small samples or sparse categories"
  ),
  `Recommended coefficient` = c(
    "$\\alpha$, Cronbach's alpha",
    "$\\omega$, McDonalds omega",
    "$\\omega_h$, Coefficient H", 
    "Ordinal $\\omega$",
    "$\\alpha$ and $\\omega$",
    "$\\omega$ (Pearson-based)"
  )
)

kable(
  decision_table,
  format = "html",
  escape = FALSE,
  align = c("l", "l")
) |>
  column_spec(1, width = "60%") |>
  column_spec(2, width = "40%")

