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


address1_data <- list("houseNumber" = "1600",
                      "road" = "Pennsylvania Ave NW",
                      "city" = "Washington",
                      "state" = "DC",
                      "postCode" = "20500")

address2_data <- list("houseNumber" = "160",
                      "road" = "Pennsilvana Avenue",
                      "city" = "Washington",
                      "state" = "D.C.",
                      "postCode" = "20500")

parameters <- list()
parameters[["address1"]] <- address1_data
parameters[["address2"]] <- address2_data

if (is.na(opt$url)) {
   result <- api(opt$key, "address-similarity", parameters)
} else {
   result <- api(opt$key, "address-similarity", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))
