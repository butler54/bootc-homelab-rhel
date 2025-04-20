FROM registry.redhat.io/rhel9/rhel-bootc:latest

RUN dnf config-manager --add-repo https://pkgs.tailscale.com/stable/rhel/9/tailscale.repo

RUN dnf -y install wget \
    vim-enhanced \
    firewalld \
    cockpit* \
    podman \
    buildah \
    skopeo \
    qemu-kvm \
    qemu-kvm-tools \
    qemu-img \
    libvirt \
    libvirt-client \
    virt-who \
    virt-top \
    virt-viewer \
    openssh-server \
    git \
    lm_sensors \ 
    tmux \
    tailscale \
    make \
    xfsdump

RUN dnf -y install usbutils

ADD files/sudoers.d/wheel-passwordless-sudo /etc/sudoers.d/
ADD files/chrony.conf /etc/
# ADD files/NetworkManager/system-connections/br0.nmconnection /etc/NetworkManager/system-connections/
# ADD files/NetworkManager/system-connections/eno1.nmconnection /etc/NetworkManager/system-connections/
# RUN chmod 600 /etc/NetworkManager/system-connections/br0.nmconnection
# RUN chmod 600 /etc/NetworkManager/system-connections/eno1.nmconnection

RUN ln -s /lib/systemd/system/tailscaled.service /etc/systemd/system/multi-user.target.wants/tailscaled.service
RUN mkdir -p -m 777 /var/mnt/vms

COPY files/node-sysuser.conf /usr/lib/sysusers.d/

COPY node_exporter /usr/local/bin/node_exporter

COPY files/node-exporter.service /etc/systemd/system/node-exporter.service
RUN ln -s /etc/systemd/system/node-exporter.service /etc/systemd/system/multi-user.target.wants/node-exporter.service


RUN bootc container lint


