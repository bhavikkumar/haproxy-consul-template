FROM haproxy:1.8-alpine
LABEL Description="Runs consul template and runs haproxy based on the generated configuration, based on sirile/haproxy" Version="0.1"

ENV CONSUL_TEMPLATE_VERSION=0.19.4

# Update wget to get support for SSL
RUN apk --update add wget

# Download consul-template
RUN wget --no-check-certificate https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz \
  && tar xfz consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz \
  && mv consul-template /usr/bin/consul-template \
  && rm consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz

RUN touch /run/haproxy.sock
RUN chmod 777 /run/haproxy.sock

COPY haproxy.json /tmp/haproxy.json
COPY haproxy.ctmpl /tmp/haproxy.ctmpl

ENTRYPOINT ["consul-template"]
CMD ["-help"]
