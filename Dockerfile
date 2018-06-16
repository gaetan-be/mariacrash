FROM centos:latest

ADD mariadb.repo /etc/yum.repos.d/mariadb.repo
RUN yum -y update
RUN yum -y install MariaDB-server-10.2.15
RUN yum -y install MariaDB-client-10.2.15
ADD crash.sql /crash.sql
ADD server.cnf /etc/my.cnf.d/server.cnf
EXPOSE 3306 
CMD ["mysqld_safe"]