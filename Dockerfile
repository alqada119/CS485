FROM alpine
COPY env.sh /
RUN chmod +x /env.sh
CMD ["/env.sh"]
