FROM ubuntu 22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
curl \
git \
ca-certificates \
gnupg \
lsb-release \
bash \
sudo \
unzip 
#Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
rm kubectl

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg \
  && echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list \
  && apt-get update \
  && apt-get install -y docker-ce-cli

# Intall kind
RUN curl -Lo kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64 && \
    chmod +x kind && \
    mv kind /usr/local/bin/kind

#Install flux
RUN curl -s https://fluxcd.io/install.sh | bash -s -- --version=v2.3.0

WORKDIR /home/gitops
COPY bootstrap.sh /home/gitops/
RUN chmod +x /home/gitops/bootstrap.sh
