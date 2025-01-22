#Base image of runner must be walnut-arc-runner. Please refer to documentation linked in the README of this repository.
FROM ubuntu:latest
#------------------------------------------------------------------------------------------
# File Name           : Dockerfile
# Author              : Mebarek ADEL
# Creation Date       : 2024/05/07
# Version             : 0.2
# Top                 : com
# Company             : engie
# Bu                  : gbs
# Be                  : engieit
# Project             : clip
# Service Provider    : bis
# Description         : Dockerfile for clip confluent
# Updates history     :
# -------+------------+------------------+------------------------------------------------
# Version|  Date      |   Author         | Description
# -------+------------+------------------+------------------------------------------------
#  0.1   | 07/05/2024 | Mebarek ADEL     | Add aws cli v2 and terraform
# -------+------------+------------------+------------------------------------------------
#  0.2   | 27/05/2024 | Mebarek ADEL     | Upgrade Terraform to 1.8.4
# -------+------------+------------------+------------------------------------------------
#        |            |                  |
#-----------------------------------------------------------------------------------------
#        |            |                  |
#-----------------------------------------------------------------------------------------
#        |            |                  |
#-----------------------------------------------------------------------------------------

#------------#
# apt update #
#------------#
RUN  apt update &&  apt-get update && \
    # -----------------------------#
    # Install necessary packages   #
    # -----------------------------#
    echo "===> Installing necessary packages" && \
    apt-get install -y --no-install-recommends bash coreutils curl jq openssl colordiff git golang-go unzip && \
    echo "JQ, CURL, OPENSSL, COLORDIFF, GO ARE INSTALLED" && \
    # ----------------------------- #
    # Install kubectl               #
    # ----------------------------- #
    echo "===> Installing kubectl" && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    echo "KUBECTL IS INSTALLED" 
    # && \
    # # ----------------------------- #
    # # Install aws-cli               #
    # # ----------------------------- #
    # echo "===> Installing awscli" && \
    # curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    # unzip awscliv2.zip && \
    # ./aws/install && \
    # echo "AWS-CLI IS INSTALLED" && \
    # # ----------------------------- #
    # # Install Helm                  #
    # # ----------------------------- #
    # echo "===> Installing Helm" && \
    # curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    # chmod 700 get_helm.sh && \
    # ./get_helm.sh && \
    # echo "HELM IS INSTALLED" && \
    # # ----------------------------- #
    # # Install FluxCD                #
    # # ----------------------------- #
    # echo "===> Installing FluxCD" && \
    # curl -s https://fluxcd.io/install.sh | bash && \
    # echo "FLUXCD IS INSTALLED" && \
    # # ----------------------------- #
    # # Install kubeconform           #
    # # ----------------------------- #
    # echo "===> Installing kubeconform" && \
    # go install github.com/yannh/kubeconform/cmd/kubeconform@latest && \
    # echo "KUBECONFORM IS INSTALLED" && \
    # # ----------------------------- #
    # # Install Kustomize             #
    # # ----------------------------- #
    # echo "===> Installing Kustomize" && \
    # GOBIN=$(pwd)/ GO111MODULE=on go install sigs.k8s.io/kustomize/kustomize/v5@latest && \
    # echo "KUSTOMIZE IS INSTALLED" && \
    # # ----------------------------- #
    # # Install Terraform             #
    # # ----------------------------- #
    # echo "===> Installing Terraform: version 1.8.4" && \
    # wget https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_amd64.zip && \
    # unzip terraform_1.8.4_linux_amd64.zip && \
    # mv terraform /usr/local/bin/ && \
    # terraform --version && \
    # # ----------------------------- #
    # # Clean up                      #
    # # ----------------------------- #
    # echo "===> Cleaning up" && \
    # apt-get clean && \
    # rm -rf /var/lib/apt/lists/* && \
    # rm -f get_helm.sh && \
    # rm -f /usr/local/bin/kubectl && \
    # rm -rf /root/.cache/go-build && \
    # rm -rf /tmp/*