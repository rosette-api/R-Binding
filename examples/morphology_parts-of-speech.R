source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

morphology_parts_of_speech_data <- "The fact is that the geese just went back to get a rest and I'm not banking on their return soon"

parameters <- list()
parameters[[ "content" ]] <- morphology_parts_of_speech_data
parameters[[ "morphology" ]] <- "parts-of-speech"

if (is.na(opt$url)){
   result <- api(opt$key, "morphology", parameters)
} else {
   result <- api(opt$key, "morphology", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))