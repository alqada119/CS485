FROM node AS build
COPY ./frontend /frontend/
WORKDIR /frontend/
RUN npm install
RUN npm run build 
FROM nginx:alpine AS runtime
COPY  --from=build /frontend/build /usr/share/nginx/html
#Go to frontend, public, add index.html 
#Run docker build -t a1-4b .
#Run docker run --name a1-4b -d --rm -p 3500:80 a1-4b