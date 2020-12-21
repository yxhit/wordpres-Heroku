#!/bin/sh

# Download and install V2Ray
mkdir /tmp/Xray
curl -L -H "Cache-Control: no-cache" -o /tmp/Xray/Xray.zip https://github.com/XTLS/Xray-core/releases/download/$RELEASE_VERSION/Xray-linux-$MACHINE.zip
unzip /tmp/Xray/Xray.zip -d /tmp/Xray
install -m 755 /tmp/Xray/Xray /usr/local/bin/Xray
install -m 755 /tmp/Xray/Xctl /usr/local/bin/Xctl

# Remove temporary directory
rm -rf /tmp/Xray

# XRay new configuration
install -d /usr/local/etc/Xray
cat << EOF > /usr/local/etc/Xray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 128
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
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

# Run XRay
/usr/local/bin/Xray -config /usr/local/etc/Xray/config.json
