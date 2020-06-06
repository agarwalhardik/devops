FROM centos
RUN yum install sudo -y
RUN yum install java -y
RUN yum install openssh-server -y
RUN /usr/sbin/sshd -D &
RUN ssh-keygen -A
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mkdir /root/.kube /root/jenkins
RUN sudo mv ./kubectl /usr/local/bin/kubectl
COPY ca.crt client.crt client.key myinfo myweb-deploy.yml /root/
RUN mv /root/myinfo /root/.kube/config
 
RUN yum install httpd -y
RUN yum install php -y
COPY index.html /var/www/html/
EXPOSE 80
CMD /usr/sbin/httpd -DFOREGROUND
