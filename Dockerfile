FROM node:22-slim

RUN <<EOF
apt-get update
apt-get install -y wget gnupg
wget -q -O /etc/apt/trusted.gpg.d/linux_signing_key.asc https://dl-ssl.google.com/linux/linux_signing_key.pub
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

apt-get update
apt-get install -y chromium bash pandoc
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

USER node

WORKDIR /home/node

COPY assets assets

COPY README.md README.md

COPY --chmod=755 md2pdf.sh md2pdf.sh

CMD [ "/home/node/md2pdf.sh" ]
