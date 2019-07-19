FROM linuxkit/alpine:08c8d8aa3638d035e18499a74faf50eedb8d6cf6-amd64 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/

RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox \
    ca-certificates \
    tini \
    eudev \
    && true

# Remove apk residuals. We have a read-only rootfs, so apk is of no use.
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache

FROM scratch
WORKDIR /
ENTRYPOINT []
COPY --from=mirror /out /
COPY etc/ /etc/
COPY usr/ /usr/
CMD ["/sbin/tini", "/usr/bin/udevd.sh"]
