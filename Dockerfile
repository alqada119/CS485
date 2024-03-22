FROM python
COPY ./ /src/
WORKDIR /src/
ENV DEBIAN_FRONTEND=noninteractive
RUN pip install -r requirements.txt
RUN apt update && apt -y install supervisor && apt -y install mariadb-server
RUN chmod +x /src/*.sh
RUN /src/dbsetup.sh
RUN supervisord -c /src/supervisord.conf
CMD ["supervisord","-c","/src/supervisord.conf"]