FROM ubuntu:24.04

RUN apt update
RUN apt upgrade -y

RUN apt install -y \
	gdb \
	gdb-multiarch \
	gdbserver \
	wget \
	curl \
	tmux \
	patchelf \
	python3 \
	python3-pip \
	pkg-config \
	liblzma-dev \
	libssl-dev \
	elfutils

# pwntools
WORKDIR /root
COPY .tmux.conf .
RUN pip3 install pwntools --break-system-packages

# neovim
WORKDIR /root
RUN curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o nvim.tgz
RUN tar xvf nvim.tgz
RUN mkdir -p ~/.local/bin
RUN ln -s ~/nvim-linux-x86_64/bin/nvim ~/.local/bin/
RUN mkdir -p ~/.config/nvim
COPY ./nvim/init.lua /root/.config/nvim/

# Rust
WORKDIR /root
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust_setup.sh
RUN chmod +x rust_setup.sh
RUN ./rust_setup.sh -y

# pwninit
RUN bash -c 'source "$HOME/.cargo/env" && cargo install pwninit' 

#  gef
RUN wget -q https://raw.githubusercontent.com/bata24/gef/dev/install-uv.sh -O- | sh

CMD ["tmux"]
