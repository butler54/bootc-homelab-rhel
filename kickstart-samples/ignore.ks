# may work
%pre
mkdir -p /etc/ostree
cat > /etc/ostree/auth.json << 'EOF'
{
        "auths": {
                "quay.io": {
                        "auth": ""
                }
        }
}
EOF
%end

text 
network --bootproto=dhcp --device=link --activate --onboot=on --hostname=lab


zerombr
# For the command below it is critical to specify the disk otherwise it will erase ALL disks attached to the system
clearpart --initlabel --disklabel=gpt --all
ignoredisk --drives=/dev/disk/by-id/ata-LK1600GEYMV_BTHC5453025K1P6PGN,/dev/disk/by-id/ata-HGST_HUS726060ALE610_K8GJSLYD,/dev/disk/by-id/ata-HGST_HUS726060ALE610_K8GKKH1D

reqpart --add-boot
part / --grow --fstype xfs

ostreecontainer --url quay.io/rh-ee-chbutler/bootc-lab:prod

# https://docs.fedoraproject.org/en-US/fedora/f36/install-guide/appendixes/Kickstart_Syntax_Reference/#sect-kickstart-commands-users-groups
# Generate an ssh key using the command `openssl passwd -6`

rootpw --iscrypted locked
sshkey --username root "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpcy6zqLnilQKimkWNkOANJ2Y4V2R78jQgkrG7w7L5MJCTDgqZbu8rXgTfEx2m2yoGv2LMP7AaCjbVP8bn9zXTZU7hKITitVjpT8+IfLW4nZCeWONxNdT21Eol39JJ6SJwGPsAZ5AV8++/M+59I5cuwfTVf/+2P4WA3SxJAh1fRttvr1uCB1+Nt/Gr6ykO6W4VTWp4YptNiOJG2qjrLCnqk/6839KScudzhY9DOpYB5FGc9r2i2XhxY/1WiYt0Ck+y3/zdMetF/+X1cE4edtp+OD++JulYD2Y0g9yEok2R1QZx0wYjr6khjbTfBaqjniiVchMSaZZwU64j9WrTkCVuvd+J2TfuLPxqR8kf1OjZOwuYSpA2Dgk8rGM8HuHwATnM/TCdwG8YZUDlFfd8DrojPV0VdPqaJEy/XYhkL8jGRrllFFnFZAMPqYm2tZsRcpKr4uWcxviLeiVh0YzjgdBwydJeELGT1sqDfHt/sGHC+Out9nbAi5yeDXORX4T5L6sd0Cn5mxtDnTPrdg4LHvkHoRmrjFSPsAg6whO5KdiNUphkKX3iwFy+f91cDdlkhK7fKVqfefvdXqyBl1+lZO4Ie6YJ+WhuuWYrTJL6JuJbgirrME2Pynrq43dEEpJw/dV6adbOVyfnpVNbngUZQ7AQpve5b/ZKTBRMWIH8wXYMhw== cardno:15_486_682"

firewall --disabled
services --enabled=sshd

group --name=chris --gid=1000
user --name=chris --uid=1000 --gid=1000 --homedir=/var/home/chris --shell=/bin/bash --groups=wheel,media,libvirt 
sshkey --username chris "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpcy6zqLnilQKimkWNkOANJ2Y4V2R78jQgkrG7w7L5MJCTDgqZbu8rXgTfEx2m2yoGv2LMP7AaCjbVP8bn9zXTZU7hKITitVjpT8+IfLW4nZCeWONxNdT21Eol39JJ6SJwGPsAZ5AV8++/M+59I5cuwfTVf/+2P4WA3SxJAh1fRttvr1uCB1+Nt/Gr6ykO6W4VTWp4YptNiOJG2qjrLCnqk/6839KScudzhY9DOpYB5FGc9r2i2XhxY/1WiYt0Ck+y3/zdMetF/+X1cE4edtp+OD++JulYD2Y0g9yEok2R1QZx0wYjr6khjbTfBaqjniiVchMSaZZwU64j9WrTkCVuvd+J2TfuLPxqR8kf1OjZOwuYSpA2Dgk8rGM8HuHwATnM/TCdwG8YZUDlFfd8DrojPV0VdPqaJEy/XYhkL8jGRrllFFnFZAMPqYm2tZsRcpKr4uWcxviLeiVh0YzjgdBwydJeELGT1sqDfHt/sGHC+Out9nbAi5yeDXORX4T5L6sd0Cn5mxtDnTPrdg4LHvkHoRmrjFSPsAg6whO5KdiNUphkKX3iwFy+f91cDdlkhK7fKVqfefvdXqyBl1+lZO4Ie6YJ+WhuuWYrTJL6JuJbgirrME2Pynrq43dEEpJw/dV6adbOVyfnpVNbngUZQ7AQpve5b/ZKTBRMWIH8wXYMhw== cardno:15_486_682"

reboot