FROM node:20-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    git \
  && rm -rf /var/lib/apt/lists/*

COPY . .

# Install dependencies if Node project
RUN if [ -f package.json ]; then npm install; fi

EXPOSE 3000 3001 5005/udp

ENV CONFIG_PATH=/app/config
ENV DATA_PATH=/app/data
ENV LOG_PATH=/app/logs
ENV MODEL_PATH=/app/models

RUN mkdir -p /app/config /app/data /app/logs /app/models

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -fs http://localhost:3000/health || exit 1

CMD ["npm", "start"]
