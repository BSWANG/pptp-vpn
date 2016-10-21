FROM registry.aliyuncs.com/acs/alpine
MAINTAINER wbs9399@sina.com

RUN apk --update add ppp pptpd iptables rsyslog

ENV USERNAME username
ENV PASSWORD password

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

COPY ./pptpd.conf /etc/pptpd.conf
COPY ./pptpd-options /etc/ppp/pptpd-options
COPY ./chap-secrets /etc/ppp/chap-secrets
COPY ./stdout.conf /etc/rsyslog.d/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pptpd", "--fg"]
