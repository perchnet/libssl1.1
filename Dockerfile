ARG NEW_CODENAME=trixie
ARG BASE_IMAGE=debian:${NEW_CODENAME}
FROM ${BASE_IMAGE} AS builder

ARG OLD_CODENAME=bullseye
ARG PACKAGE=libssl1.1
ENV DEBIAN_FRONTEND=noninteractive

RUN printf '%s\n' \
  "Types: deb-src" \
  "URIs: http://deb.debian.org/debian" \
  "Suites: ${OLD_CODENAME} ${OLD_CODENAME}-updates" \
  "Components: main" \
  "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" \
  "" \
  "Types: deb-src" \
  "URIs: http://deb.debian.org/debian-security" \
  "Suites: ${OLD_CODENAME}-security" \
  "Components: main" \
  "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" \
  > /etc/apt/sources.list.d/snapshot-src.sources

RUN apt-get update && apt-get install -y dpkg-dev devscripts build-essential fakeroot

RUN mkdir /w \
 && cd /w \
 && apt-get source "$PACKAGE" \
 && SRC_DIR="$(find . -mindepth 1 -maxdepth 1 -type d)" \
 && cd "$SRC_DIR" \
 \
 && mk-build-deps --install --remove --tool 'apt-get --yes --no-remove --no-install-recommends' \
 \
 && UPSTREAM_VER=$(head -n1 debian/changelog | sed -En 's/^[^(]+\(([^)]+)\).*/\1/p' | sed 's/-.*//') \
 \
 # Handle numeric or codename version suffix:
 && MAJOR_VER=$(echo "${NEW_CODENAME}" | sed -E 's/^([0-9]+)(\..*)?$/\1/') \
 && if echo "$NEW_CODENAME" | grep -Eq '^[0-9]+(\.[0-9]+)?$'; then \
      # Numeric version detected, use ~<major>1 suffix \
      NEW_VER="${UPSTREAM_VER}~${MAJOR_VER}1"; \
    elif echo "$NEW_CODENAME" | grep -Eq '^(bookworm|bullseye|buster)$'; then \
      NEW_VER="${UPSTREAM_VER}+deb${NEW_CODENAME}u1"; \
    else \
      NEW_VER="${UPSTREAM_VER}~${NEW_CODENAME}1"; \
    fi \
 \
 && dch --newversion "$NEW_VER" "Rebuild for Debian ${NEW_CODENAME}" -b \
 \
 && dpkg-buildpackage -us -uc -b \
 \
 && cd /w

FROM scratch
COPY --from=builder /w/*.deb /

