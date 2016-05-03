source("../rosetteApi/R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

if(is.na(opt$url)){
   result <- api(opt$key, "info")
} else {
   result <- api(opt$key, "info", opt$url)
}
print(result)