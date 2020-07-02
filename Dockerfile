FROM dragoncrafted87/alpine-supervisord:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="DragonCrafted87 Alpine Samba" \
      org.label-schema.description="Alpine Image with additional controls from supervisord to enable gracefull server shudown." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-alpine-greyhole" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

COPY root/. /

# Install all the things!
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add samba shadow && \
    addgroup -S smb && \
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g 'Samba User' smbuser && \
    rm -rf /var/cache/apk/* && \
    chmod +x -R /scripts/*

EXPOSE 137/udp 138/udp 139 445

WORKDIR /root

CMD ["/docker_service_init"]
