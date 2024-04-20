FROM fedora:39
RUN dnf update -y
RUN dnf install -y \
    curl \
    git \
    ripgrep \
    fzf \
    xz \
    tar \
    fontconfig \
    git \
    util-linux-user

RUN curl -L -o /tmp/nerdfont.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.tar.xz && \
    mkdir -p /usr/local/share/fonts/ && \
    mkdir -p /tmp/nerdfont/ && \
    tar -xf /tmp/nerdfont.tar.xz -C /tmp/nerdfont/ && \
    cp /tmp/nerdfont/*.ttf /usr/local/share/fonts/ && \
    fc-cache -f -v && \
    rm -rf /tmp/nerdfont.tar.xz /tmp/nerdfont
