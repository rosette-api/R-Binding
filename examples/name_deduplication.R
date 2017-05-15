source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

name_dedupe_data <- "John Smith,Johnathon Smith,Fred Jones"


text <- unlist(strsplit(name_dedupe_data, ","))
targetLanguage <- c("eng", "eng", "eng")
targetScript <- c("Latn", "Latn", "Latn")

names = data.frame(text, targetLanguage, targetScript)
parameters <- list()
parameters[[ "names" ]] <- names
parameters[[ "threshold" ]] <- 0.75

if (is.na(opt$url)){
   result <- api(opt$key, "name-deduplication", parameters)
} else {
   result <- api(opt$key, "name-deduplication", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))
