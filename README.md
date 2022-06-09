# Webhooks configuration

## Install adnanh/webhook
```sh
apt install webhook
```

## Redeploy
1. Clone in `/home/node/webhooks`.

2.Create `/etc/default/webhook`:
```
OPTIONS="-hooks=/home/node/webhooks/webhooks.json -hotreload -ip 127.0.0.1 -port 9000 -verbose"
```

3. Set up as a daemon
```sh
systemctl edit --force --full webhook.service
```
and enter
```
[Unit]
Description=Small server for creating HTTP endpoints (hooks)
Documentation=https://github.com/adnanh/webhook/
ConditionPathExists=/etc/default/webhook

[Service]
EnvironmentFile=/etc/default/webhook
ExecStart=/usr/bin/webhook -nopanic $OPTIONS
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

4. Start the daemon
```sh
systemctl enable --now webhook
```

5. Try it
Make a GET request to `https://youserver.com/hooks/redeploy?repo=myrepo&command=start` with the correct `Authorization` header as configured in `webhooks.json`.
