From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Fri, 3 Aug 2018 17:20:39 +0000
Subject: How /dev/nvme numbers are allocated/mapped to BDF
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
 <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
 <20180803165411.GA4551@localhost.localdomain>
Message-ID: <85bec04c520848a9aa388e4334bb13ce@ausx13mps321.AMER.DELL.COM>

On 08/03/2018 11:53 AM, Keith Busch wrote:
> On Fri, Aug 03, 2018@04:16:16PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>> Thanks. I'm fairly convinced I have that patch. I can see by-path links
>> for Intel drives, but not the Samasungs.
>>
>> [root at g-prime mrnuke]# ls /dev/disk/by-path/ |grep nvme
>> pci-0000:3f:00.0-nvme-1
>> pci-0000:3f:00.0-nvme-1-part1
>> pci-0000:b1:00.0-nvme-1
>> pci-0000:b1:00.0-nvme-1-part1
>>
>> [root at g-prime mrnuke]# lspci |grep NVM
>> 3f:00.0 Non-Volatile memory controller: Intel Corporation Express Flash  NVMe P4500
>> 40:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe  SSD Controller 172Xa/172Xb (rev 01)
>> b1:00.0 Non-Volatile memory controller: Intel Corporation Express Flash  NVMe P4600
>> b2:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe  SSD Controller 172Xa/172Xb (rev 01)
>>
>>
>> [root at g-prime mrnuke]# nvme list
>> Node             SN                    Model                                    Namespace  Usage                      Format           FW Rev
>> ---------------- --------------------  ---------------------------------------- ---------  -------------------------- ---------------- --------
>> /dev/nvme0n1     PHLF7363029G1P0GGN   Dell Express Flash NVMe P4500  1.0TB SFF  1           1.00  TB /   1.00  TB     512   B +  0 B   QDV1DP12
>> /dev/nvme1n1     PHLE7260008Z3P2EGN   Dell Express Flash NVMe P4600  3.2TB SFF  1           3.20  TB /   3.20  TB     512   B +  0 B   QDV1DP12
>> /dev/nvme2n1           S39YNX0HB00195 Dell Express Flash PM1725a 800GB  SFF     1           800.17  GB / 800.17  GB   512   B +  0 B   1.0.4
>> /dev/nvme3n1           S39YNX0HB00293 Dell Express Flash PM1725a 800GB  SFF     1           800.17  GB / 800.17  GB   512   B +  0 B   1.0.4
> 
> The sammy drives do not have compliant serial number. Spec requires
> strings are left justified, padding spaces to the right.

They're Koreans. They write from right to left. I don't see the problem ;)

> Not that it should matter to the by-path symlinks...
> 
> Could you attach output from:
> 
>    udevadm test -a -p $(udevadm info -q path -n /dev/nvme2n1)


[root at g-prime mrnuke]#  udevadm test -a -p $(udevadm info -q path -n 
/dev/nvme2n1)
calling: test
version 238
This program is for debugging only, it does not run any program
specified by a RUN key. It may show incorrect results, because
some values may be different, or not available at a simulation run.

Load module index
Parsed configuration file /usr/lib/systemd/network/99-default.link
Created link configuration context.
Reading rules file: /usr/lib/udev/rules.d/10-dm.rules
Reading rules file: /usr/lib/udev/rules.d/11-dm-lvm.rules
Reading rules file: /usr/lib/udev/rules.d/11-dm-mpath.rules
Reading rules file: /usr/lib/udev/rules.d/11-dm-parts.rules
Reading rules file: /usr/lib/udev/rules.d/13-dm-disk.rules
Reading rules file: /usr/lib/udev/rules.d/40-libgphoto2.rules
/usr/lib/udev/rules.d/40-libgphoto2.rules:11: IMPORT found builtin 
'usb_id --export %%p', replacing
Reading rules file: /usr/lib/udev/rules.d/40-usb-media-players.rules
Reading rules file: /usr/lib/udev/rules.d/40-usb_modeswitch.rules
Reading rules file: /usr/lib/udev/rules.d/50-udev-default.rules
Reading rules file: /usr/lib/udev/rules.d/60-block.rules
Reading rules file: /usr/lib/udev/rules.d/60-cdrom_id.rules
Reading rules file: /usr/lib/udev/rules.d/60-drm.rules
Reading rules file: /usr/lib/udev/rules.d/60-evdev.rules
Reading rules file: /usr/lib/udev/rules.d/60-ffado.rules
Reading rules file: /usr/lib/udev/rules.d/60-fprint-autosuspend.rules
Reading rules file: /usr/lib/udev/rules.d/60-input-id.rules
Reading rules file: /usr/lib/udev/rules.d/60-net.rules
Reading rules file: /usr/lib/udev/rules.d/60-persistent-alsa.rules
Reading rules file: /usr/lib/udev/rules.d/60-persistent-input.rules
Reading rules file: /usr/lib/udev/rules.d/60-persistent-storage-tape.rules
Reading rules file: /usr/lib/udev/rules.d/60-persistent-storage.rules
Reading rules file: /usr/lib/udev/rules.d/60-persistent-v4l.rules
Reading rules file: /usr/lib/udev/rules.d/60-raw.rules
Reading rules file: /usr/lib/udev/rules.d/60-rdma-ndd.rules
Reading rules file: /usr/lib/udev/rules.d/60-sensor.rules
Reading rules file: /usr/lib/udev/rules.d/60-serial.rules
Reading rules file: /usr/lib/udev/rules.d/60-u2f-hidraw.rules
Reading rules file: /usr/lib/udev/rules.d/61-kde-bluetooth-rfkill.rules
Reading rules file: /usr/lib/udev/rules.d/62-multipath.rules
Reading rules file: /usr/lib/udev/rules.d/63-md-raid-arrays.rules
Reading rules file: /usr/lib/udev/rules.d/64-btrfs-dm.rules
Reading rules file: /usr/lib/udev/rules.d/64-btrfs.rules
Reading rules file: /usr/lib/udev/rules.d/64-md-raid-assembly.rules
Reading rules file: /usr/lib/udev/rules.d/65-libwacom.rules
Reading rules file: /usr/lib/udev/rules.d/65-md-incremental.rules
Reading rules file: /usr/lib/udev/rules.d/65-sane-backends.rules
Reading rules file: /usr/lib/udev/rules.d/66-kpartx.rules
Reading rules file: /usr/lib/udev/rules.d/68-del-part-nodes.rules
Reading rules file: /usr/lib/udev/rules.d/69-btattach-bcm.rules
Reading rules file: /usr/lib/udev/rules.d/69-cd-sensors.rules
Reading rules file: /usr/lib/udev/rules.d/69-dm-lvm-metad.rules
Reading rules file: /usr/lib/udev/rules.d/69-libmtp.rules
Reading rules file: /usr/lib/udev/rules.d/70-hypervfcopy.rules
Reading rules file: /usr/lib/udev/rules.d/70-hypervkvp.rules
Reading rules file: /usr/lib/udev/rules.d/70-hypervvss.rules
Reading rules file: /usr/lib/udev/rules.d/70-joystick.rules
Reading rules file: /usr/lib/udev/rules.d/70-mouse.rules
Reading rules file: /etc/udev/rules.d/70-persistent-ipoib.rules
Reading rules file: /usr/lib/udev/rules.d/70-power-switch.rules
Reading rules file: /usr/lib/udev/rules.d/70-printers.rules
Reading rules file: /usr/lib/udev/rules.d/70-spice-vdagentd.rules
Reading rules file: /usr/lib/udev/rules.d/70-touchpad.rules
Reading rules file: /usr/lib/udev/rules.d/70-uaccess.rules
Reading rules file: /usr/lib/udev/rules.d/70-wacom.rules
Reading rules file: /usr/lib/udev/rules.d/71-seat.rules
Reading rules file: /usr/lib/udev/rules.d/73-seat-late.rules
Reading rules file: /usr/lib/udev/rules.d/75-net-description.rules
Reading rules file: /usr/lib/udev/rules.d/75-probe_mtd.rules
Reading rules file: /usr/lib/udev/rules.d/75-rdma-description.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-cinterion-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-dell-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-ericsson-mbm.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-haier-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-huawei-net-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-longcheer-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-mtk-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-nokia-port-types.rules
Reading rules file: 
/usr/lib/udev/rules.d/77-mm-pcmcia-device-blacklist.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-simtech-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-telit-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-usb-device-blacklist.rules
Reading rules file: 
/usr/lib/udev/rules.d/77-mm-usb-serial-adapters-greylist.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-x22x-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/77-mm-zte-port-types.rules
Reading rules file: /usr/lib/udev/rules.d/78-sound-card.rules
Reading rules file: /usr/lib/udev/rules.d/80-drivers.rules
Reading rules file: /usr/lib/udev/rules.d/80-libinput-device-groups.rules
Reading rules file: /usr/lib/udev/rules.d/80-mm-candidate.rules
Reading rules file: /usr/lib/udev/rules.d/80-net-setup-link.rules
Reading rules file: /usr/lib/udev/rules.d/80-udisks2.rules
Reading rules file: /usr/lib/udev/rules.d/82-gfs2-withdraw.rules
Reading rules file: /usr/lib/udev/rules.d/84-nm-drivers.rules
Reading rules file: /usr/lib/udev/rules.d/85-nm-unmanaged.rules
Reading rules file: /usr/lib/udev/rules.d/85-regulatory.rules
Reading rules file: /usr/lib/udev/rules.d/90-alsa-restore.rules
Reading rules file: /usr/lib/udev/rules.d/90-libgpod.rules
Reading rules file: /usr/lib/udev/rules.d/90-libinput-model-quirks.rules
Reading rules file: /usr/lib/udev/rules.d/90-pulseaudio.rules
Reading rules file: /usr/lib/udev/rules.d/90-rdma-hw-modules.rules
Reading rules file: /usr/lib/udev/rules.d/90-rdma-ulp-modules.rules
Reading rules file: /usr/lib/udev/rules.d/90-rdma-umad.rules
Reading rules file: /usr/lib/udev/rules.d/90-vconsole.rules
Reading rules file: /usr/lib/udev/rules.d/91-drm-modeset.rules
Reading rules file: /usr/lib/udev/rules.d/95-cd-devices.rules
Reading rules file: /usr/lib/udev/rules.d/95-dm-notify.rules
Reading rules file: /usr/lib/udev/rules.d/95-upower-csr.rules
Reading rules file: /usr/lib/udev/rules.d/95-upower-hid.rules
Reading rules file: /usr/lib/udev/rules.d/95-upower-wup.rules
Reading rules file: /usr/lib/udev/rules.d/98-kexec.rules
Reading rules file: /usr/lib/udev/rules.d/98-rdma.rules
Reading rules file: /usr/lib/udev/rules.d/99-qemu-guest-agent.rules
Reading rules file: /usr/lib/udev/rules.d/99-systemd.rules
Reading rules file: /usr/lib/udev/rules.d/99-vmware-scsi-udev.rules
rules contain 393216 bytes tokens (32768 * 12 bytes), 40129 bytes strings
47125 strings (381339 bytes), 43170 de-duplicated (345166 bytes), 3956 
trie nodes used
LINK 'disk/by-id/nvme-eui.3339593048b001950025385800000001' 
/usr/lib/udev/rules.d/60-persistent-storage.rules:19
LINK 
'disk/by-id/nvme-Dell_Express_Flash_PM1725a_800GB_SFF__S39YNX0HB00195' 
/usr/lib/udev/rules.d/60-persistent-storage.rules:26
IMPORT builtin 'blkid' /usr/lib/udev/rules.d/60-persistent-storage.rules:90
probe /dev/nvme2n1 raid offset=0
LINK 'disk/by-uuid/bf1f37cd-55d1-40e2-8d2f-faf01728aac0' 
/usr/lib/udev/rules.d/60-persistent-storage.rules:93
handling device node '/dev/nvme2n1', devnum=b259:5, mode=0600, uid=0, gid=0
preserve already existing symlink '/dev/block/259:5' to '../nvme2n1'
found 'b259:5' claiming 
'/run/udev/links/\x2fdisk\x2fby-id\x2fnvme-Dell_Express_Flash_PM1725a_800GB_SFF__S39YNX0HB00195'
creating link 
'/dev/disk/by-id/nvme-Dell_Express_Flash_PM1725a_800GB_SFF__S39YNX0HB00195' 
to '/dev/nvme2n1'
preserve already existing symlink 
'/dev/disk/by-id/nvme-Dell_Express_Flash_PM1725a_800GB_SFF__S39YNX0HB00195' 
to '../../nvme2n1'
found 'b259:5' claiming 
'/run/udev/links/\x2fdisk\x2fby-id\x2fnvme-eui.3339593048b001950025385800000001'
creating link 
'/dev/disk/by-id/nvme-eui.3339593048b001950025385800000001' to 
'/dev/nvme2n1'
preserve already existing symlink 
'/dev/disk/by-id/nvme-eui.3339593048b001950025385800000001' to 
'../../nvme2n1'
found 'b259:5' claiming 
'/run/udev/links/\x2fdisk\x2fby-uuid\x2fbf1f37cd-55d1-40e2-8d2f-faf01728aac0'
creating link '/dev/disk/by-uuid/bf1f37cd-55d1-40e2-8d2f-faf01728aac0' 
to '/dev/nvme2n1'
preserve already existing symlink 
'/dev/disk/by-uuid/bf1f37cd-55d1-40e2-8d2f-faf01728aac0' to '../../nvme2n1'
.ID_FS_TYPE_NEW=ext3
ACTION=-p
DEVLINKS=/dev/disk/by-id/nvme-eui.3339593048b001950025385800000001 
/dev/disk/by-id/nvme-Dell_Express_Flash_PM1725a_800GB_SFF__S39YNX0HB00195 
/dev/disk/by-uuid/bf1f37cd-55d1-40e2-8d2f-faf01728aac0
DEVNAME=/dev/nvme2n1
DEVPATH=/devices/virtual/nvme-subsystem/nvme-subsys2/nvme2n1
DEVTYPE=disk
ID_FS_TYPE=ext3
ID_FS_USAGE=filesystem
ID_FS_UUID=bf1f37cd-55d1-40e2-8d2f-faf01728aac0
ID_FS_UUID_ENC=bf1f37cd-55d1-40e2-8d2f-faf01728aac0
ID_FS_VERSION=1.0
ID_MODEL=Dell Express Flash PM1725a 800GB SFF
ID_SERIAL=Dell Express Flash PM1725a 800GB SFF_      S39YNX0HB00195
ID_SERIAL_SHORT=      S39YNX0HB00195
ID_WWN=eui.3339593048b001950025385800000001
MAJOR=259
MINOR=5
SUBSYSTEM=block
TAGS=:systemd:
USEC_INITIALIZED=8235082
Unload module index
Unloaded link configuration context.
