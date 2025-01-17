# Utiliser la dernière version d'Alpine Linux
FROM alpine:latest

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apk update && apk upgrade && \
    apk add --no-cache bash coreutils curl jq openssl colordiff git go && \
    echo "JQ, CURL, OPENSSL, COLORDIFF, GO ARE INSTALLED" && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    echo "KUBECTL IS INSTALLED" && \
    apk add --no-cache aws-cli && \
    echo "AWS-CLI IS INSTALLED" && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    echo "HELM IS INSTALLED" && \
    curl -s https://fluxcd.io/install.sh | bash && \
    echo "FLUXCD IS INSTALLED" && \
    go install github.com/yannh/kubeconform/cmd/kubeconform@latest && \
    echo "KUBECONFORM IS INSTALLED" && \
    GOBIN=$(pwd)/ GO111MODULE=on go install sigs.k8s.io/kustomize/kustomize/v5@latest && \
    echo "KUSTOMIZE IS INSTALLED" &&\
            # Supprimer les fichiers non nécessaires
            rm -rf /var/cache/apk/* && \
            rm -f get_helm.sh && \
            rm -f /usr/local/bin/kubectl && \
            rm -rf /root/.cache/go-build && \
            rm -rf /tmp/*

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de l'application dans le conteneur
COPY . .

# Commande par défaut à exécuter lors du démarrage du conteneur
CMD ["bash"]
