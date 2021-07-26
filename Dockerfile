ARG BUILD_TAG=latest

FROM forumi0721/alpine-base:${BUILD_TAG} as stage1

LABEL maintainer="forumi0721@gmail.com"

ENV TARGET_ARCH=x64

COPY local/. /usr/local/

RUN ["docker-init"]



FROM scratch as stage2

LABEL maintainer="forumi0721@gmail.com"

COPY --from=stage1 /build/archroot /

COPY local/. /usr/local/

#RUN ["docker-build-start"]

RUN ["docker-init"]

#RUN ["docker-build-end"]



FROM scratch

LABEL maintainer="forumi0721@gmail.com"

COPY --from=stage2 / /

#RUN ["docker-build-start"]

RUN ["docker-init"]

#RUN ["docker-build-end"]

ENTRYPOINT ["docker-run"]

