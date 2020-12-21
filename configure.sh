#!/bin/sh

# Download and install V2Ray
mkdir /tmp/xray
curl -L -H "Cache-Control: no-cache" -o /tmp/xray/xray.zip https://github.com/XTLS/Xray-core/releases/download/$RELEASE_VERSION/Xray-linux-$MACHINE.zip
unzip /tmp/xray/xray.zip -d /tmp/xray
install -m 755 /tmp/xray/xray /usr/local/bin/xray
install -m 755 /tmp/xray/xctl /usr/local/bin/xctl

# Remove temporary directory
rm -rf /tmp/xray

# V2Ray new configuration
install -d /usr/local/etc/xray
cat << EOF > /usr/local/etc/xray/config.json
{
    "inbounds": [
      {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$UUID",
            "level": 0
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "wsSettings": {
        "path": "/xray"
        }
      },
      "sniffing": {
              "enabled": true,
              "destOverride":[
                      "http",
                      "tls"
              ]
      }
    }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/xray -config /usr/local/etc/xray/config.json
