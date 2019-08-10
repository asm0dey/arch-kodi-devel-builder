FROM archlinux/base

RUN pacman -Sy && \
    pacman -S --noconfirm base-devel git ccache && \
    ln -s /usr/bin/ccache /usr/local/bin/gcc && \
    ln -s /usr/bin/ccache /usr/local/bin/cc && \
    ln -s /usr/bin/ccache /usr/local/bin/c++ && \
    ln -s /usr/bin/ccache /usr/local/bin/g++ && \
    mkdir -p /root/.ccache
