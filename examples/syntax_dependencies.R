source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

syntax_dependencies_data <- "Yoshinori Ohsumi, a Japanese cell biologist, was awarded the Nobel Prize in Physiology or Medicine on Monday."

key <- "content"
value <- syntax_dependencies_data
key1 <- "genre"
value1 <- "social-media"

parameters <- list()
parameters[[ key ]] <- value
parameters[[ key1 ]] <- value1
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "syntax/dependencies", parameters)
} else {
   result <- api(opt$key, "syntax/dependencies", parameters, NULL, opt$url)
}
print(result)
