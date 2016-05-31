source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

if(is.null(opt$url)){
    result <- api(opt$key, "ping")
} else {
    result <- api(opt$key, "ping", opt$url)
}
print(result)