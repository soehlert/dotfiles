function FindProxyForURL(url, host) {
    host = host.toLowerCase();
    if (dnsDomainIs(host, "home.samoehlert.com")
        return "SOCKS 127.0.0.1:12345"; // (IP:port)
    return "DIRECT";
}
