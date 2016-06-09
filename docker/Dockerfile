
FROM r-base:3.2.5
MAINTAINER Sam Hausmann

ENV API_KEY api_key
RUN apt-get -y update && apt-get install -y \
    curl \
    r-base \
    r-base-dev \
    libcurl4-openssl-dev \
    r-cran-rjson \
    libssl-dev

RUN mkdir /R-dev
COPY runAll.sh /R-dev/runAll.sh
RUN chmod 0755 /R-dev/runAll.sh

#set the working directory
WORKDIR /R-dev

CMD ./runAll.sh 
VOLUME ["/source"]