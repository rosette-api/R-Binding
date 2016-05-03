
FROM r-base:3.2.5
MAINTAINER Sam Hausmann

ENV API_KEY api_key
RUN apt-get -y update && apt-get install -y curl && apt-get install -y r-base && apt-get install -y r-base-dev &&  apt-get install -y libcurl4-openssl-dev && apt-get install -y r-cran-rjson && apt-get install -y libssl-dev

RUN mkdir /R-dev
COPY runAll.sh /R-dev/runAll.sh
RUN chmod 0755 /R-dev/runAll.sh

#set the working directory
WORKDIR /R-dev

CMD ./runAll.sh $API_KEY $FILENAME $ALT_URL; /bin/bash
VOLUME ["/source"]