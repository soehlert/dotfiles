#!/bin/bash

# From networksetup -listnetworkserviceorder

PRIMARY_IFACE_NAME="Wi-Fi"

PRIMARY_V4_GW=$(networksetup -getinfo "${PRIMARY_IFACE_NAME}" | grep Router | grep -v IPv6 | cut -f 2 -d' ') 
PRIMARY_V6_GW=$(networksetup -getinfo "${PRIMARY_IFACE_NAME}" | grep "IPv6 Router" | cut -f 3 -d' ') 

echo "Primary v4 gateway detected as ${PRIMARY_V4_GW}"
echo "Primary v6 gateway detected as ${PRIMARY_V6_GW}"

# Don't use the VPN for gateway hosts.
# Reference: https://esnet.atlassian.net/wiki/spaces/NET/pages/1959822584/Gateway+hosts

if [ "$PRIMARY_V4_GW" != "none" ]; then
    networksetup -setadditionalroutes "${PRIMARY_IFACE_NAME}" \
        198.124.252.150 255.255.255.255 ${PRIMARY_V4_GW} `# aofa-gw` \
        198.124.252.210 255.255.255.255 ${PRIMARY_V4_GW} `# cern-513-gw` \
        198.124.252.162 255.255.255.255 ${PRIMARY_V4_GW} `# chic-gw` \
        198.129.252.102 255.255.255.255 ${PRIMARY_V4_GW} `# lbnl-gw` \
        198.129.252.54 255.255.255.255  ${PRIMARY_V4_GW} `# pnwg-gw` \
        198.129.252.98 255.255.255.255  ${PRIMARY_V4_GW} `# sunn-gw`
else
    echo "No v4 gateway found, skipping gateway host config"
fi

if [ "$PRIMARY_V6_GW" != "none" ]; then
    networksetup -setv6additionalroutes "${PRIMARY_IFACE_NAME}" \
        2001:400:ff00:2::2 126 ${PRIMARY_V6_GW} `# aofa-gw` \
        2001:400:ff00:3::2 126 ${PRIMARY_V6_GW} `# cern-513-gw` \
        2001:400:ff00:1::2 126 ${PRIMARY_V6_GW} `# chic-gw` \
        2001:400:ff00:4::2 126 ${PRIMARY_V6_GW} `# lbnl-gw` \
        2001:400:ff00:5::2 126 ${PRIMARY_V6_GW} `# pnwg-gw` \
        2001:400:ff00:6::2 126 ${PRIMARY_V6_GW} `# sunn-gw`
else
    echo "No v6 gateway found, skipping gateway host config"
fi

