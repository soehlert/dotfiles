function FindProxyForURL(url, host) {
    host = host.toLowerCase();
    if (dnsDomainIs(host, "ncsa.illinois.edu")
    || dnsDomainIs(host, "internal.ncsa.edu")
    || shExpMatch(host, "10.142.*"))
        return "SOCKS 127.0.0.1:12345"; // (IP:port)
    return "DIRECT";
}