# Routes we will exclude
########################
# 2FA Gateways:
$ROUTE add -host 198.124.252.162 gw $route_net_gateway metric 0 dev $INTERFACE
# vpn-east
$ROUTE add -host 198.124.218.34 gw $route_net_gateway metric 0 dev $INTERFACE
$ROUTE add -host 198.124.218.38 gw $route_net_gateway metric 0 dev $INTERFACE
# vpn-west
$ROUTE add -host 198.129.252.122 gw $route_net_gateway metric 0 dev $INTERFACE
$ROUTE add -host 198.129.252.110 gw $route_net_gateway metric 0 dev $INTERFACE

# Routes we want
########################
# West coast
$ROUTE add -net 198.128.0.0 netmask 255.252.0.0 gw $route_vpn_gateway metric 50 dev $dev
# East coast, with a metric of 100
$ROUTE add -net 198.124.0.0 netmask 255.252.0.0 gw $route_vpn_gateway metric 100 dev $dev
# Something
$ROUTE add -net 192.188.22.0 netmask 255.255.255.0 gw $route_vpn_gateway metric 60 dev $dev
# # Backbone
$ROUTE add -net 134.55.0.0 netmask 255.255.0.0 gw $route_vpn_gateway metric 60 dev $dev
# # Netlab
$ROUTE add -net 192.74.211.0 netmask 255.255.255.0 gw $route_vpn_gateway metric 50 dev $dev

