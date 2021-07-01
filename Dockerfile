

FROM ubuntu

MAINTAINER Patrick Haller <patrickhaller40@googlemail.com>

# Install dependencies
RUN apt-get update -y
RUN apt-get install python3 -y
RUN apt-get install unzip

# Download relevant files
RUN wget https://media.dwds.de/dta/download/dtak/2020-10-23/normalized/gesamt.zip 
RUN unzip gesamt.zip 



