#!/bin/sh

# Download and install xRay
mkdir /tmp/wordpress
curl -L -H "Cache-Control: no-cache" -o /tmp/wordpress/wordpress.zip https://github.com/XTLS/Xray-core/releases/download/v1.4.2/Xray-linux-64.zip
unzip /tmp/wordpress/wordpress.zip -d /tmp/wordpress
install -m 755 /tmp/wordpress/wordpress /usr/local/bin/wordpress

# Remove temporary directory
rm -rf /tmp/wordpress

# XRay new configuration
install -d /usr/local/etc/wordpress
cat << EOF > /usr/local/etc/wordpress/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "level": 0
                    }
                ],
                "decryption": "none"
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
/usr/local/bin/wordpress -config /usr/local/etc/wordpress/config.json
