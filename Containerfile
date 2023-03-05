# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# https://www.gnu.org/software/bash/
ARG BASH_VERSION=5.2.15

WORKDIR /src/bash
RUN set -xeu; \
    curl -#Lo bash.tar.gz \
        "https://ftp.gnu.org/gnu/bash/bash-$BASH_VERSION.tar.gz"; \
    tar -xvf bash.tar.gz --strip-components=1; \
    rm -f bash.tar.gz

COPY patches/ .
RUN set -xeu; \
    patch configure < configure.patch; \
    patch m4/strtoimax.m4 < m4_strtoimax.patch

ARG CFLAGS="-Wno-parentheses -Wno-format-security -w -g -Os -static"
RUN set -xeu; \
    autoconf -f; \
    ./configure --without-bash-malloc; \
    make -j"$(nproc)"; \
    # make tests; \
    strip -s -R .comment --strip-unneeded bash; \
    chmod -cR 755 bash; \
    chown -cR 0:0 bash; \
    ! ldd bash && :; \
    ./bash --version

# static Bash image
FROM scratch
COPY --from=build /src/bash/bash /bin/bash
ENTRYPOINT ["/bin/bash"]
