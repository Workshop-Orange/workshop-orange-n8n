ARG NODE_IMAGE
FROM ${NODE_IMAGE} 

# Install Supervisord
RUN apk add --update supervisor && rm  -rf /tmp/* /var/cache/apk/*
RUN mkdir -p /etc/supervisor/conf.d/ && fix-permissions /etc/supervisor/conf.d
ADD lagoon/supervisord.conf /etc/
ADD lagoon/supervisord-worker-one.conf /etc/supervisor/conf.d/
ADD lagoon/supervisord-worker-two.conf /etc/supervisor/conf.d/

# Run Supervisor
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
