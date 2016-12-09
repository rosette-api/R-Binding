source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

entities_text_data <- "Bill Murray will appear in new Ghostbusters film: Dr. Peter Venkman was spotted filming a cameo in Boston this… http://dlvr.it/BnsFfS"

parameters <- list()
parameters[[ "content" ]] <- entities_text_data
parameters[[ "genre" ]] <- "social-media"
# advanced output
url_parameters <- list(output = "rosette")

if (is.na(opt$url)){
   result <- api(opt$key, "entities", parameters, url_parameters = url_parameters)
} else {
   result <- api(opt$key, "entities", parameters, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))