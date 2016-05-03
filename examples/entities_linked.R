source("../rosetteApi/R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

key <- "content"
value <- "Last month director Paul Feig announced the movie will have an all-star female cast including Kristen Wiig, Melissa McCarthy, Leslie Jones and Kate McKinnon."

parameters <- list()
parameters[[ key ]] <- value
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "entities/linked", parameters)
} else {
   result <- api(opt$key, "entities/linked", parameters, opt$url)
}
print(result)