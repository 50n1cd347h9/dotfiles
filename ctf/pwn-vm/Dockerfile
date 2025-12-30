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
	elfutils \
	yq \
	git \
	ncat \
	less \
	ruby \
	ruby-dev \
	cpio \
	musl-tools musl-dev musl \
	qemu-system-x86
	

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

# neovim plugin
WORKDIR /root/.config/nvim
RUN curl -L https://github.com/50n1cd347h9/fudebako.vim/archive/refs/heads/master.zip -o fudebako.zip
RUN mkdir fudebako.vim
RUN unzip -j -d fudebako.vim/ fudebako.zip
WORKDIR /root/.config/nvim/fudebako.vim
RUN ./install.sh
WORKDIR /root/.config/nvim
COPY ./nvim/plugins.yaml ./

# Rust
WORKDIR /root
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust_setup.sh
RUN chmod +x rust_setup.sh
RUN ./rust_setup.sh -y

# pwninit
RUN bash -c 'source "$HOME/.cargo/env" && cargo install pwninit' 
# ropr
RUN bash -c 'source "$HOME/.cargo/env" && cargo install ropr' 

#  gef
RUN wget -q https://raw.githubusercontent.com/bata24/gef/dev/install-uv.sh -O- | sh

RUN gem install seccomp-tools

CMD ["tmux"]
