FROM centos
RUN yum install sudo -y

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mkdir /root/.kube
RUN sudo mv ./kubectl /usr/local/bin/kubectl
COPY ca.crt client.crt client.key myinfo /root/
RUN mv /root/myinfo /root/.kube/config
 


