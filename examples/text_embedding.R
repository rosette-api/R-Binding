source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

embeddings_data <- "Cambridge, Massachusetts"

key <- "content"
value <- embeddings_data

parameters <- list()
parameters[[ key ]] <- value
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "text-embedding", parameters)
} else {
   result <- api(opt$key, "text-embedding", parameters, NULL, opt$url)
}
print(result)
