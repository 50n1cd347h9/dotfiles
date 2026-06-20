FROM rust@sha256:6cff8a33b03d328aa58d00dedda6a3c5bbee4b41e21533932bffd90d7d58f9c4 AS rust
RUN apt update
RUN apt install -y \
	liblzma-dev \
	pkg-config \
	libssl-dev

WORKDIR /root
RUN --mount=type=cache,target=/usr/local/cargo/registry \
	--mount=type=cache,target=/root/.cargo/git \
	cargo install pwninit ropr --root ./


FROM ubuntu:25.04 AS nvim
RUN apt update
RUN apt install -y unzip

WORKDIR /root
RUN mkdir config
COPY ./nvim/ /root/config/
WORKDIR /root/config
ADD https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz ./nvim.tgz
RUN tar xvf nvim.tgz


FROM ubuntu:25.04 AS gef
# gef
ADD https://raw.githubusercontent.com/bata24/gef/dev/install-uv.sh install-uv.sh
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	--mount=type=cache,target=/root/.cache/uv,sharing=locked \
	--mount=type=cache,target=/root/.gem,sharing=locked \
	rm /etc/apt/apt.conf.d/docker-clean && \
	bash install-uv.sh
	#sed -E 's/(uv pip install .*)$/\1 pwntools/' install-uv.sh | sh


FROM ubuntu:25.04 AS final
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt update -y && apt install -y \
	tmux \
	qemu-system-x86 \
	patchelf \
	yq \
	cpio \
	less \
	ncat \
	musl-tools musl-dev musl \
	git \
	clangd llvm lld \
	# gef 
	gdb-multiarch \
	binutils python3-dev gcc make ruby-dev file colordiff imagemagick \
	linux-headers-generic bear

# gef
WORKDIR /root
COPY --from=gef /root /root
ENV PATH=/root/.gef/.venv-gef/bin:$PATH
ENV GEM_HOME=/root/.gef/.venv-gef
ENV GEM_PATH=/root/.gef/.venv-gef


# ropr & pwninit
COPY --link --from=rust /root/bin/pwninit .local/bin/
COPY --link --from=rust /root/bin/ropr .local/bin/
ENV PATH=/root/.local/bin:$PATH

# nvim
WORKDIR /root
COPY --link --from=nvim /root/config .config/nvim
ENV PATH=/root/.config/nvim/nvim-linux-x86_64/bin:$PATH
RUN git clone https://github.com/50n1cd347h9/fudebako.nvim /root/.config/nvim/fudebako.nvim
RUN nvim --headless +qa! # install plugins

RUN uv pip install pwntools

# other stuff
COPY .tmux.conf .
COPY extract_vmlinux /root/.local/bin/

CMD ["tmux"]
