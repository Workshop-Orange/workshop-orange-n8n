FROM uselagoon/node-18

# The N8N version to use
ARG N8N_VERSION=1.79.3

WORKDIR /app

RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!" ; exit 1; fi

ENV NODE_ENV=production

RUN set -eux; \
	npm install -g --omit=dev n8n@${N8N_VERSION} --ignore-scripts && \
	npm rebuild --prefix=/usr/local/lib/node_modules/n8n sqlite3 && \
	rm -rf /usr/local/lib/node_modules/n8n/node_modules/@n8n/chat && \
	rm -rf /usr/local/lib/node_modules/n8n/node_modules/n8n-design-system && \
	rm -rf /usr/local/lib/node_modules/n8n/node_modules/n8n-editor-ui/node_modules && \
	find /usr/local/lib/node_modules/n8n -type f -name "*.ts" -o -name "*.js.map" -o -name "*.vue" | xargs rm -f && \
	rm -rf /root/.npm

COPY lagoon/n8n-entrypoint.sh /lagoon/entrypoints/71-n8n-entrypoint

ENV N8N_VERSION=${N8N_VERSION}
ENV N8N_PORT 3000
ENV N8N_PROTOCOL http
ENV N8N_USER_FOLDER /app/storage
ENV EXECUTIONS_DATA_PRUNE true
ENV N8N_SKIP_WEBHOOK_DEREGISTRATION_SHUTDOWN true
ENV DB_TYPE postgresdb

EXPOSE 3000

COPY /app /app
COPY lagoon/n8n-entrypoint.sh /lagoon/entrypoints/71-n8n-entrypoint

CMD ["/app/start-n8n-queue-main"]
