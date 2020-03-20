ARG BUILD_ARCH=x64

FROM forumi0721/alpine-${BUILD_ARCH}-base as builder

LABEL maintainer="forumi0721@gmail.com"

ENV TARGET_ARCH=x64

COPY local/. /usr/local/

RUN ["docker-init"]



FROM scratch as bootstrap

COPY --from=builder /build/archroot /

COPY local/. /usr/local/

#RUN ["docker-build-start"]

RUN ["docker-init"]

#RUN ["docker-build-end"]



FROM scratch

COPY --from=bootstrap / /

ENTRYPOINT ["docker-run"]

