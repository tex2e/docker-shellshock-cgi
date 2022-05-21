
FROM centos:8

RUN dnf -y --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos
RUN dnf -y distro-sync
RUN dnf -y install gcc gcc-c++ make httpd wget nmap net-tools bash-completion

ADD src/index.html /var/www/html/
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

