FROM registry.redhat.io/rhel9/rhel-bootc:latest

RUN dnf config-manager --add-repo https://pkgs.tailscale.com/stable/rhel/9/tailscale.repo

RUN dnf update -y

RUN dnf -y install wget \
    vim-enhanced \
    firewalld \
    cockpit* \
    cockpit-machines \
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
    tailscale 


ADD files/sudoers.d/wheel-passwordless-sudo /etc/sudoers.d/
ADD files/chrony.conf /etc/
# ADD files/NetworkManager/system-connections/br0.nmconnection /etc/NetworkManager/system-connections/
# ADD files/NetworkManager/system-connections/eno1.nmconnection /etc/NetworkManager/system-connections/
# RUN chmod 600 /etc/NetworkManager/system-connections/br0.nmconnection
# RUN chmod 600 /etc/NetworkManager/system-connections/eno1.nmconnection

RUN virtsh

RUN mkdir -p -m 777 /var/mnt/vms


RUN sudo systemctl enable --now tailscaled


