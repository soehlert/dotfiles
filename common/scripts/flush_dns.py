#!/usr/bin/env python

# flush_dns.py

"""A handy script to flush dns cache for Linux/macOS/Windows."""

import logging
from subprocess import Popen
from sys import platform
import psutil


def check_if_process_running(logger, process_name):
    """Check for running processes matching process_name."""

    # Iterate through running processes to find matching process_name.
    logger.debug("Checking for process: %s\n", process_name)
    for proc in psutil.process_iter():
        try:
            if process_name.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False


def setup_logger():
    """Setup logging facility."""
    logger = logging.getLogger()
    handler = logging.StreamHandler()
    logger.addHandler(handler)
    logger.setLevel(logging.DEBUG)

    return logger


def linux(logger):
    """Linux specific."""
    logger.debug("Running on Linux.\n")

    # Check for dnsmasq
    if check_if_process_running(logger, "dnsmasq"):
        logger.debug("Flushing DNSMasq...")
        command = Popen(["sudo", "systemctl", "restart", "dnsmasq.service"])
        result = get_command_result(command)
        logger.debug("DNSMasq flush: %s\n", result)

    # Check for named
    if check_if_process_running(logger, "named"):
        logger.debug("Flushing named...")
        command = Popen(["sudo", "systemctl", "restart", "named.service"])
        result = get_command_result(command)
        logger.debug("Bind flush: %s\n", result)

    # Check for nscd
    if check_if_process_running(logger, "nscd"):
        logger.debug("Flushing nscd...")
        command = Popen(["sudo", "systemctl", "restart", "nscd.service"])
        result = get_command_result(command)
        logger.debug("NSCD flush: %s\n", result)

    # Check for systemd-resolved
    if check_if_process_running(logger, "systemd-resolved"):
        logger.debug("Flushing systemd-resolved...")
        command = Popen(["sudo", "systemd-resolve", "--flush-caches"])
        result = get_command_result(command)
        logger.debug("systemd-resolved flush: %s\n", result)


def macos(logger):
    """macOS specific."""
    logger.debug("Running on macOS.\n")

    # Check for mDNSResponder
    if check_if_process_running(logger, "mDNSResponder"):
        logger.debug("Killing mDNSResponder")
        command = Popen(["sudo", "killall", "-HUP", "mDNSResponder"])
        result = get_command_result(command)
        logger.debug("Killing mDNSResponder: %s\n", result)

    # Check for mDNSResponderHelper
    if check_if_process_running(logger, "mDNSResponderHelper"):
        logger.debug("Killing mDNSResponderHelper")
        command = Popen(["sudo", "killall", "mDNSResponderHelper"])
        result = get_command_result(command)
        logger.debug("Killing mDNSResponderHelper: %s\n", result)

    logger.debug("Running: dscacheutil -flushcache")
    command = Popen(["sudo", "dscacheutil", "-flushcache"])
    result = get_command_result(command)
    logger.debug("Flushing dscacheutil: %s\n", result)


def windows(logger):
    """Windows specific."""
    command = Popen(["ipconfig", "/flushdns"])
    result = get_command_result(command)
    logger.debug("ipconfig /flushdns: %s\n", result)


def get_command_result(command):
    """Wait for command to complete and return result."""
    command.wait()
    if command.returncode != 0:
        result = "Failed"
    else:
        result = "Successful"

    return result


def dns_flush(logger):
    """Flush DNS cache by platform."""

    # Linux specific
    if platform in ["linux", "linux2"]:
        linux(logger)

    # macOS specific
    elif platform == "darwin":
        macos(logger)

    # Windows specific
    elif platform == "win32":
        windows(logger)


def main():
    """Main execution."""
    logger = setup_logger()
    dns_flush(logger)


if __name__ == "__main__":
    main()
