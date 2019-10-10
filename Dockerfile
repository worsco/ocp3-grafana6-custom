# CHANGE ME to customer image
FROM registry.redhat.io/rhel7-minimal

EXPOSE 3000/tcp

# from upstream  https://dl.grafana.com/oss/release/grafana-6.3.3-1.x86_64.rpm
#ADD assets/grafana-6.3.3-1.x86_64.rpm /tmp/grafana-6.3.3-1.x86_64.rpm
ADD https://dl.grafana.com/oss/release/grafana-6.3.3-1.x86_64.rpm /tmp/grafana-6.3.3-1.x86_64.rpm

# from https://packages.grafana.com/gpg.key
#ADD assets/gpg.key /tmp/gpg.key
ADD https://packages.grafana.com/gpg.key /tmp/gpg.key

ADD assets/grafana-server.sh /tmp/grafana-server.sh

RUN echo "" && \
    chmod a+x /tmp/grafana-server.sh && \
    microdnf \
       --enablerepo=rhel-7-server-rpms \
       --enablerepo=rhel-7-server-extras-rpms \
       --enablerepo=rhel-7-server-optional-rpms \
       install \
       unzip \
       shadow-utils \
       initscripts \
       dejavu-fonts-common \
       dejavu-sans-fonts \
       fontconfig \
       fontpackages-filesystem \
       libICE \
       libSM \
       libX11 \
       libX11-common \
       libXau \
       libXcursor \
       libXext \
       libXfixes \
       libXi \
       libXinerama \
       libXmu \
       libXrandr \
       libXrender \
       libXt \
       libXxf86misc \
       libXxf86vm \
       libfontenc \
       libxcb \
       urw-base35-bookman-fonts \
       urw-base35-c059-fonts \
       urw-base35-d050000l-fonts \
       urw-base35-fonts \
       urw-base35-fonts-common \
       urw-base35-gothic-fonts \
       urw-base35-nimbus-mono-ps-fonts \
       urw-base35-nimbus-roman-fonts \
       urw-base35-nimbus-sans-fonts \
       urw-base35-p052-fonts \
       urw-base35-standard-symbols-ps-fonts \
       urw-base35-z003-fonts \
       xorg-x11-font-utils \
       xorg-x11-server-utils \
    && \
    microdnf clean all && \
    useradd -u 1001 grafana -m 

RUN rpm --import /tmp/gpg.key && \
    rpm -ivh /tmp/grafana-6.3.3-1.x86_64.rpm 

RUN curl -s -L https://github.com/Vonage/Grafana_Status_panel/archive/master.zip -o /tmp/master.zip && \
    unzip -o /tmp/master.zip -d /var/lib/grafana/plugins/ && \
    rm -f /tmp/master.zip

# doesn't require a root user.
USER 1001

ENTRYPOINT [ "/tmp/grafana-server.sh" ]
