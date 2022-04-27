FROM mysql:latest

RUN adduser --shell /usr/sbin/nologin
USER mysql

#ADD ./products.csv /products.csv
COPY ./products.csv /products.csv
#ADD ./users.csv /users.csv
COPY ./users.csv /users.csv
#ADD ./setup.sql /docker-entrypoint-initdb.d/setup.sql
COPY ./setup.sql /docker-entrypoint-initdb.d/setup.sql


#ENV MYSQL_ROOT_PASSWORD "thisisatestthing."


ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld", "--secure-file-priv=/"]
#CMD ["--secure-file-priv=/"]
