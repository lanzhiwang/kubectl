FROM debian:bookworm-slim

ENV KUBECTL_VERSION v1.25.4

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates curl; \
	rm -rf /var/lib/apt/lists/*; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${dpkgArch}/kubectl"; \
	curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${dpkgArch}/kubectl.sha256"; \
	echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check; \
	rm -rf kubectl.sha256; \
	chmod +x kubectl; \
	mv kubectl /usr/local/bin/kubectl; \
	kubectl version --client=true
