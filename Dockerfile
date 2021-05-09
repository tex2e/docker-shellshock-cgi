
FROM centos:8
MAINTAINER tex2e <tex2eq@gmail.com>

RUN dnf -y install gcc gcc-c++ make httpd wget

ADD src/test.cgi /var/www/cgi-bin/
RUN chmod +x /var/www/cgi-bin/test.cgi

RUN wget https://ftp.gnu.org/gnu/bash/bash-4.3.tar.gz && \
    tar zxvf bash-4.3.tar.gz && \
    cd bash-4.3 && \
    ./configure && \
    make && \
    make install

EXPOSE 80

RUN systemctl enable httpd

CMD /sbin/init

