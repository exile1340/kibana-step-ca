FROM docker.elastic.co/kibana/kibana:8.12.2

USER root

# Update and install step
RUN apt update && apt upgrade -y && \
    apt install -y wget cron gosu && \
    export arch=$(dpkg --print-architecture) && \
    wget https://dl.smallstep.com/cli/docs-ca-install/latest/step-cli_${arch}.deb && \
    dpkg -i step-cli_${arch}.deb && \
    rm -rf /var/lib/apt/lists/*

# Create cron to check certificates every 5 minutes
COPY certcron /etc/cron.d/certcron
RUN chmod 0644 /etc/cron.d/certcron
RUN crontab /etc/cron.d/certcron
RUN touch /var/log/cron.log
COPY cert-renewal.sh /usr/local/bin/cert-renewal.sh
RUN chmod +x /usr/local/bin/cert-renewal.sh


# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]