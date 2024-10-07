FROM ubuntu as build

RUN apt-get update 
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update -y
RUN apt-get install -y nodejs
Run apt-get install -y typescript

WORKDIR /app

COPY package.json  package.json
COPY package-lock.json package-lock.json

RUN npm install

RUN tsc -p .# build


FROM Node as runner


WORKDIR /app

COPY --from=build /app .

ENTRYPOINT ["node", "main.js"]