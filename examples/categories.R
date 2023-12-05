source("../R/Api.R")
library(jsonlite)
library(optparse)

option_list <- list(
  make_option(c("-k", "--key"),
    action = "store", default = NA, type = "character",
    help = "Rosette API key"),
  make_option(c("-u", "--url"),
    action = "store", default = NA, type = "character",
    help = "Rosette API url"))
opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

categories_text_data <- "If you are a fan of the British television series Downton Abbey and you are planning to be in New York anytime before April 2nd, there is a perfect stop for you while in town."

parameters <- list()
parameters[["content"]] <- categories_text_data

if (is.na(opt$url)) {
   result <- api(opt$key, "categories", parameters)
} else {
   result <- api(opt$key, "categories", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))
