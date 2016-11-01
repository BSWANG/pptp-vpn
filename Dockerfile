FROM registry.aliyuncs.com/acs/alpine
MAINTAINER wbs9399@sina.com

RUN apk --update add ppp pptpd iptables rsyslog dnsmasq

ENV USERNAME username
ENV PASSWORD password

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

COPY ./pptpd.conf /etc/pptpd.conf
COPY ./pptpd-options /etc/ppp/pptpd-options
COPY ./chap-secrets /etc/ppp/chap-secrets
COPY ./stdout.conf /etc/rsyslog.d/

EXPOSE 53 53/udp
COPY ./resolv.dnsmasq /etc/resolv.dnsmasq

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pptpd", "--fg"]
