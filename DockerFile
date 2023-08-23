FROM centos:7
MAINTAINER this is sshd <carl>
RUN yum -y update
RUN yum -y install openssh* net-tools lsof telnet passwd
RUN echo '123456' | passwd --stdin root
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i '/^session\s\+required\s\+pam_loginuid.so/s/^/#/' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]