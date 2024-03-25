FROM node AS build
COPY ./frontend /frontend/
WORKDIR /frontend/
RUN npm install
RUN npm run build 
FROM python as runtime
COPY ./backend /app
WORKDIR /app
RUN pip install -r requirements.txt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt -y install supervisor && apt -y install mariadb-server && apt -y install nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY  --from=build /frontend/build /usr/share/nginx/html
COPY mysqld.sh /app/
COPY script.sql /app/
RUN chmod +x mysqld.sh
COPY setupEnv.py /app/
COPY supervisord.conf /app/
RUN mkdir /data
CMD ["supervisord","-c","/app/supervisord.conf"]
#Go to frontend, public, add index.html 
#Run docker build -t a1-4b .
#Run docker run --name a1-4b -d --rm -p 3500:80 a1-4b
# FROM python AS runtime

