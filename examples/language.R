source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

language_data <- "Por favor Señorita, says the man."
key <- "content"
value <- language_data
headers <- c("X-RosetteAPI-App" = "r-application-test")

parameters <- list()
parameters[[ key ]] <- value
parameters [[ "customHeaders" ]] <- headers
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "language", parameters, headers)
} else {
   result <- api(opt$key, "language", parameters, headers, opt$url)
}
print(result)
