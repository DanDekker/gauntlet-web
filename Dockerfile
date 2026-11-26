FROM oven/bun:1.4.5-slim@sha256:b780593f3e10918cbdaec3d5a08d52224b9198069a65eb47812085c2ec007643

LABEL org.opencontainers.image.source="https://github.com/DanDekker/gauntlet-web"

WORKDIR /app

RUN mkdir -p /data && chown bun:bun /app /data
COPY --chown=bun:bun package.json bun.lock ./
USER bun
RUN bun install --frozen-lockfile --production --ignore-scripts

COPY --chown=bun:bun src/ ./src/
COPY --chown=bun:bun public/ ./public/
COPY --chown=bun:bun exercises/ ./exercises/

ENV NODE_ENV=production \
    PORT=3000 \
    GUANTLET_WEB_HOST=0.0.0.0 \
    GUANTLET_WEB_DATA_DIR=/data

EXPOSE 3000
CMD ["bun", "src/server.js"]
