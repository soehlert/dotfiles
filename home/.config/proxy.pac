function FindProxyForURL(url, host) {
    host = host.toLowerCase();
    if (dnsDomainIs(host, "internal.sjo")
    || shExpMatch(host, "198.168.*"))
        return "SOCKS 127.0.0.1:22345"; // (IP:port)
    return "DIRECT";
}
