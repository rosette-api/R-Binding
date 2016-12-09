source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

relationships_text_data <- "Bill Gates, Microsoft's former CEO, is a philanthropist."

parameters <- list()
parameters[[ "content" ]] <- relationships_text_data

if (is.na(opt$url)){
   result <- api(opt$key, "relationships", parameters)
} else {
   result <- api(opt$key, "relationships", parameters, NULL, opt$url)
}
print(toJSON(result$header, pretty = TRUE))
print(toJSON(result$content, pretty = TRUE))