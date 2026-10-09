FROM forumi0721/alpine-base:latest AS builder_stage1

LABEL maintainer="forumi0721@gmail.com"

COPY local/. /usr/local/

RUN ["docker-build-stage1"]



FROM forumi0721/scratch:latest AS builder_stage2

LABEL maintainer="forumi0721@gmail.com"

COPY --from=builder_stage1 /output /

COPY local/bin/docker-build-stage2 /usr/local/bin/

RUN ["docker-build-stage2"]



FROM forumi0721/scratch:latest

LABEL maintainer="forumi0721@gmail.com"

COPY --from=builder_stage2 / /

ENTRYPOINT ["docker-run"]

