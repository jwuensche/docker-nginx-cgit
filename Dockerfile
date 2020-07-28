FROM alpine:latest

MAINTAINER Johannes Wuensche "johannes@spacesnek.rocks"

RUN apk add git cgit nginx openssh fcgiwrap spawn-fcgi gettext highlight markdown

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

RUN ssh-keygen -A
RUN passwd -d root

EXPOSE 80 443

RUN mkdir /srv/git

VOLUME ["/srv/git"]
VOLUME ["/var/cache/cgit"]

COPY cgitrc.template /etc/

COPY sshd_config /etc/ssh/sshd_config

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY nginx.conf /etc/nginx/nginx.conf

COPY start.sh /start.sh

CMD /start.sh

ENV CGIT_TITLE "My cgit interface"
ENV CGIT_DESC "Super fast interface to my git repositories"
ENV CGIT_VROOT "/"
ENV CGIT_SECTION_FROM_STARTPATH 0
ENV CGIT_MAX_REPO_COUNT 50
