source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

sentences_data <- "This land is your land. This land is my land, from California to the New York island; from the red wood forest to the Gulf Stream waters. This land was made for you and Me. As I was walking that ribbon of highway, I saw above me that endless skyway: I saw below me that golden valley: This land was made for you and me."

parameters <- list()
parameters[[ "content" ]] <- sentences_data

if (is.na(opt$url)){
   result <- api(opt$key, "sentences", parameters)
} else {
   result <- api(opt$key, "sentences", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))