source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

matched_name_data1 <- "Michael Jackson"
matched_name_data2 <- "迈克尔·杰克逊"

key <- "name1"
value <- matched_name_data1
key1 <- "name2"
value1 <- matched_name_data2

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
