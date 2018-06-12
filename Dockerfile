# base image
FROM node:8.11.2-onbuild

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /usr/src/app/package.json

#RUN yarn
RUN yarn global upgrade
RUN yarn global add @angular/cli@~6.0.3

# set Yarn as the default package manager.
RUN ng config -g cli.packageManager yarn

# add app
COPY . /usr/src/app

# start app
CMD yarn && yarn start