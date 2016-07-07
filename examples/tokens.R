source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

tokens_data <- "北京大学生物系主任办公室内部会议"

key <- "content"
value <- tokens_data

parameters <- list()
parameters[[ key ]] <- value
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "tokens", parameters)
} else {
   result <- api(opt$key, "tokens", parameters, NULL, opt$url)
}
print(result)
