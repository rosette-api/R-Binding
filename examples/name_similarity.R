source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

matched_name_data1 <- "Michael Jackson"
matched_name_data2 <- "迈克尔·杰克逊"

parameters <- list()
parameters[[ "name1" ]] <- matched_name_data1
parameters[[ "name2" ]] <- matched_name_data2

if (is.na(opt$url)){
   result <- api(opt$key, "name-similarity", parameters)
} else {
   result <- api(opt$key, "name-similarity", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))