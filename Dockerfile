# node used for PagedJS. Other major dependencies work well from packages.
FROM node:22-slim

RUN <<EOF
apt-get update
apt-get install -y wget gnupg
wget -q -O /etc/apt/trusted.gpg.d/linux_signing_key.asc https://dl-ssl.google.com/linux/linux_signing_key.pub
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

apt-get update
apt-get install -y chromium bash pandoc inotify-tools zsh
rm -rf /var/lib/apt/lists/*

EOF

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN <<EOF
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export HOME=/home/node

cd $HOME

npm install -g --unsafe-perm=true --allow-root --ignore-scripts pagedjs-cli

chown -R node:node /home/node
EOF

RUN <<EOF
mkdir /in
mkdir /work
chown -R node:node /in /work
EOF


COPY defaults /defaults
COPY theme /theme
COPY README.md /defaults/README.md

USER node

WORKDIR /

COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
