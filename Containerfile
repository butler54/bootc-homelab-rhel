FROM registry.redhat.io/rhel9/rhel-bootc:latest

RUN dnf update -y

RUN dnf -y install wget \
    vim-enhanced \
    firewalld \
    cockpit* \
    podman \
    buildah \
    skopeo \
    qemu-kvm \
    libvirt \
    screen \
    openssh-server \
    git \
    lm_sensors

ADD files/sudoers.d/wheel-passwordless-sudo /etc/sudoers.d/
ADD files/chrony.conf /etc/
ADD files/NetworkManager/system-connections/br0.nmconnection /etc/NetworkManager/system-connections/
ADD files/NetworkManager/system-connections/eno1.nmconnection /etc/NetworkManager/system-connections/
RUN chmod 600 /etc/NetworkManager/system-connections/br0.nmconnection
RUN chmod 600 /etc/NetworkManager/system-connections/eno1.nmconnection


RUN mkdir -p -m 777 /var/mnt/vms

