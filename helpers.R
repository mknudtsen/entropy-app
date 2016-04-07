library(stringr)
library(magrittr)

letter_codes <- function() {
  key_codes <- c(97:122, 32)
  names(key_codes) <- c(letters, " ")
  return(key_codes)
}

alt_letter_codes <- function() {
  key_codes <- c(97:122, 32)
  names(key_codes) <- c(LETTERS, "SPACE")
  return(key_codes)
}

get_code <- function(let) {
  codes <- letter_codes()
  idx <- match(let, names(codes))
  return(codes[idx])
}

get_letter <- function(key) {
  codes <- letter_codes()
  idx <- match(key, codes)
  return(toupper(names(codes[idx])))
}

alt_get_letter <- function(key) {
  codes <- alt_letter_codes()
  idx <- match(key, codes)
  return(names(codes[idx]))
}

listify <- function(x) {
  a <- x %>%
    str_replace_all("[^[:alpha:] ']", "") %>%
    str_replace_all("\\s+", " ")
  a <- strsplit(a, "")
  # a <- lapply(a, function(x) ifelse(x == " ", "sp", x))
  return(a)
} 

# function to generate random quote and then listify()
get_quote <- function(rnum) {
  choice <- quotes[rnum]
  txt <- listify(choice)[[1]]
  return(txt)
}

# list of possible text quotes to generate
quotes <- list(
  "in bell towers and church towers that play a melody they always have a programming wheel exactly like the
  one that is on the marble machine",
  "two quantities are in the golden ratio if their ratio is the same as the ratio of their sum to the larger
  of the two quantities",
  "the lights then shined through a sequence of holes punched into two discs that rotated via a motor",
  "the central intelligence agency fostered and promoted american abstract expressionist painting
  around the world for more than twenty years",
  "some encryption schemes can be proven on the basis of the presumed difficulty of a mathematical problem",
  "systems analysis is a problem solving technique that decomposes a system into its component pieces",
  "a black swan is an event that deviates beyond what is normally expected of a situation and that would
  be extremely difficult to predict",
  "the bayesian interpretation of probability can be seen as an extension of propositional logic that 
  enables reasoning with hypotheses",
  "machine learning is a method used to devise complex models and algorithms that lend themselves to prediction",
  "harry survived with only a lightning shaped scar on his forehead as a memento of the attack"
)






