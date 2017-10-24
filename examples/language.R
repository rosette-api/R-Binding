source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

language_data <- "Por favor Señorita, says the man."

parameters <- list()
parameters[[ "content" ]] <- language_data
custom_headers <- c("X-RosetteAPI-App" = "r-application-test")

if (is.na(opt$url)){
  result <- api(opt$key, "language", parameters = parameters, custom_headers = custom_headers)
} else {
  result <- api(opt$key, "language", parameters = parameters, custom_headers = custom_headers, NULL, url = opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))