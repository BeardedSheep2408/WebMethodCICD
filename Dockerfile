FROM ubuntu:latest
 
USER root
#------------#
# apt update #
#------------#
RUN  pwd && id && apt update &&  apt-get update && \
    export PATH=$PATH:/usr/local/bin && \
    # -----------------------------#
    # Install necessary packages   #
    # -----------------------------#
    echo "===> Installing necessary packages" && \
    apt-get install -y --no-install-recommends bash coreutils curl jq openssl colordiff git unzip wget tree && \
    echo "JQ, OPENSSL, COLORDIFF, GIT, SNAP, UNZIP AND WGET ARE INSTALLED" && \
    # ----------------------------- #
    # Install kubectl               #
    # ----------------------------- #
    echo "===> Installing kubectl" && \
    rm -f /etc/ssl/certs/ca-bundle.crt &&\
    apt reinstall ca-certificates &&\
    update-ca-certificates &&\
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&\
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl &&\
    kubectl version --client &&\
    echo "KUBECTL IS INSTALLED"&& \
    # ----------------------------- #
    # Install aws-cli               #
    # ----------------------------- #
    echo "===> Installing awscli" && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    echo "AWS-CLI IS INSTALLED" && \
    # ----------------------------- #
    # Install Helm                  #
    # ----------------------------- #
    echo "===> Installing Helm" && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    echo "HELM IS INSTALLED" && \
    # ----------------------------- #
    # Install FluxCD                #
    # ----------------------------- #
    echo "===> Installing FluxCD" && \
    curl -s https://fluxcd.io/install.sh | bash && \
    echo "FLUXCD IS INSTALLED" && \
    # ----------------------------- #
    # Install kubeconform           #
    # ----------------------------- #
    echo "===> Installing Kubeconform" && \
    wget https://github.com/yannh/kubeconform/releases/download/v0.6.7/kubeconform-linux-amd64.tar.gz && \
    tar -xzf kubeconform-linux-amd64.tar.gz && \
    mv kubeconform /usr/local/bin/ && \
    echo "KUBECONFORM IS INSTALLED" && \
    # ----------------------------- #
    # Install Kustomize             #
    # ----------------------------- #
    echo "===> Installing Kustomize" && \
    wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v5.6.0/kustomize_v5.6.0_linux_amd64.tar.gz && \
    tar -xzf kustomize_v5.6.0_linux_amd64.tar.gz && \
    mv kustomize /usr/local/bin/ && \
    echo "KUSTOMIZE IS INSTALLED" && \
    # ----------------------------- #
    # Install Terraform             #
    # ----------------------------- #
    echo "===> Installing Terraform: version 1.8.4" && \
    wget https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_amd64.zip && \
    unzip terraform_1.8.4_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    terraform --version && \
    # ----------------------------- #
    # Clean up                      #
    # ----------------------------- #
    echo "===> Cleaning up" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f get_helm.sh && \
    rm -f /usr/local/bin/kubectl && \
    rm -rf /root/.cache/go-build && \
    rm -rf /tmp/*

