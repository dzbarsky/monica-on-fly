FROM monica:4.0.0
#RUN \
#  apt-get -y install wget gnupg lsb-release && \
#  curl -o /tmp/out.deb https://dev.mysql.com/get/mysql-apt-config_0.8.26-1_all.deb && \
#  dpkg -i /tmp/out.deb && \
#  rm /tmp/out.deb && \
#  apt update && \
#  apt-get -y install mysql-client
RUN apt-get update && apt-get -y install iptables

COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

COPY start.sh /app/start.sh
ENTRYPOINT ["/app/start.sh"]
