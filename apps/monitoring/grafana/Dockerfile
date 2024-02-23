FROM node:16-alpine AS base

ENV CHROME_BIN="/usr/bin/chromium-browser"
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"
ENV IMAGE_RENDERER_SOURCE_VERSION=${IMAGE_RENDERER_SOURCE_VERSION:-3.10.0}

WORKDIR /usr/src/app
RUN apk --no-cache upgrade \
    && apk add --no-cache udev ttf-opensans unifont chromium ca-certificates dumb-init \
    && rm -rf /tmp/*

FROM base as build
RUN apk add --no-cache curl unzip
RUN curl -L -o grafana-image-renderer.zip https://github.com/grafana/grafana-image-renderer/archive/refs/tags/v$IMAGE_RENDERER_SOURCE_VERSION.zip \
    && unzip grafana-image-renderer.zip \
    && mv grafana-image-renderer-$IMAGE_RENDERER_SOURCE_VERSION grafana-image-renderer \
    && rm -f grafana-image-renderer.zip
WORKDIR /usr/src/app/grafana-image-renderer
RUN yarn install --pure-lockfile
RUN yarn run build

FROM base
ENV NODE_ENV=production
COPY --from=build /usr/src/app/grafana-image-renderer/node_modules node_modules
COPY --from=build /usr/src/app/grafana-image-renderer/build build
COPY --from=build /usr/src/app/grafana-image-renderer/proto proto
COPY --from=build /usr/src/app/grafana-image-renderer/default.json config.json
COPY --from=build /usr/src/app/grafana-image-renderer/plugin.json plugin.json

CMD [ "node", "build/app.js", "server", "--config=config.json"]
