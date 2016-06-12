source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

key <- "name1"
value <- "Michael Jackson"
key1 <- "name2"
value1 <- "迈克尔·杰克逊"

parameters <- list()
parameters[[ key ]] <- value
parameters[[ key1 ]] <- value1
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "name-similarity", parameters)
} else {
   result <- api(opt$key, "name-similarity", parameters, NULL, opt$url)
}
print(result)