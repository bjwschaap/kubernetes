FROM linuxkit/alpine:08c8d8aa3638d035e18499a74faf50eedb8d6cf6-amd64 AS build

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox

# Remove apk residuals. We have a read-only rootfs, so apk is of no use.
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache

FROM scratch
WORKDIR /
COPY --from=build /out /
COPY --from=docker:18.06.3-ce /usr/local/bin/docker /usr/local/bin/docker
COPY dl/*.tar /images/
ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "sleep 10; for image in /images/*.tar ; do docker image load -i $image && rm -f $image ; done" ]
