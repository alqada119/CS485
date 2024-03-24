 
FROM python
#copy the env.sh file to my container
COPY env.sh /
#My script failed to run so I added the chmod command
RUN chmod +x /env.sh

CMD ["/env.sh"]
