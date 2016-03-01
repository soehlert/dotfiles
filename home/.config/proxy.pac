function FindProxyForURL(url, host) {
    host = host.toLowerCase();
    if (dnsDomainIs(host, "es.net")
    || dnsDomainIs(host, "lbl.gov")
    || shExpMatch(host, "198.128.*"))
        return "SOCKS 127.0.0.1:12345"; // (IP:port)
    return "DIRECT";
}
