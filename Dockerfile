FROM archlinux/base

RUN pacman -Sy && \
    pacman -S --noconfirm base-devel git ccache && \
    ln -s /usr/bin/ccache /usr/local/bin/gcc && \
    ln -s /usr/bin/ccache /usr/local/bin/cc && \
    ln -s /usr/bin/ccache /usr/local/bin/c++ && \
    ln -s /usr/bin/ccache /usr/local/bin/g++ && \
    useradd builder && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir -p /home/builder && chown builder /home/builder

USER builder
RUN mkdir -p /home/builder/.ccache && mkdir -p /home/builder/pkg
WORKDIR /home/builder
VOLUME /home/builder/.ccache
VOLUME /home/builder/pkg
