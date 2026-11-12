# Ubuntu 24.04 LTS - chosen deliberately:
# its MySQL is 8.0.x, which still supports mysql_native_password.
# Ubuntu 26.04 ships MySQL 8.4, where that plugin is gone.
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    # --- C toolchain, 32-bit support, debugging (buffer overflow,
    #     integer overflow, secure coding labs) ---
    build-essential \
    gcc-multilib \
    g++-multilib \
    gdb \
    make \
    binutils \
    strace \
    ltrace \
    # --- crypto labs (AES/OpenSSL, RSA/certificates) ---
    openssl \
    ca-certificates \
    # --- password cracking lab ---
    john \
    # --- scripting (Caesar / substitution ciphers, helper scripts) ---
    python3 \
    python3-pip \
    python3-venv \
    # --- web labs: SQL injection, XSS, DoS ---
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    php-cli \
    mysql-server \
    mysql-client \
    # --- general shell tooling students will reach for ---
    curl wget git vim nano less tree file xxd \
    net-tools iproute2 netcat-openbsd dnsutils \
    zip unzip man-db manpages \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Convenience wrapper: run a binary with ASLR disabled without needing
# to write to /proc/sys/kernel/randomize_va_space (not writable inside
# a codespace, since the kernel is shared).
#   Usage:  noaslr ./vuln AAAA
RUN printf '#!/bin/sh\nexec setarch "$(uname -m)" -R "$@"\n' > /usr/local/bin/noaslr \
 && chmod +x /usr/local/bin/noaslr

# gdb: disable randomization inside the debugger (this is gdb's default,
# set explicitly so the labs behave identically for everyone).
RUN printf 'set disable-randomization on\nset disassembly-flavor intel\n' \
    > /etc/gdb/gdbinit.d-default.gdb 2>/dev/null || true
RUN printf 'set disable-randomization on\n' >> /home/vscode/.gdbinit \
 && chown vscode:vscode /home/vscode/.gdbinit
