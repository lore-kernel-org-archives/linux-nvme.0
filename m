From: mlin@kernel.org (Ming Lin)
Date: Thu, 30 Jun 2016 14:08:57 -0700
Subject: NVMeoF multi-path setup
Message-ID: <CAF1ivSbe+NboO+nbiWfEijHFJPd-AgNa=4AvWT24-HjH8A_izw@mail.gmail.com>

Hi Mike,

I'm trying to test NVMeoF multi-path.

root at host:~# lsmod |grep dm_multipath
dm_multipath           24576  0
root at host:~# ps aux |grep multipath
root     13183  0.0  0.1 238452  4972 ?        SLl  13:41   0:00
/sbin/multipathd

I have nvme0 and nvme1 that are 2 paths to the same NVMe subsystem.

root at host:/sys/class/nvme# grep . nvme*/address
nvme0/address:traddr=192.168.3.2,trsvcid=1023
nvme1/address:traddr=192.168.2.2,trsvcid=1023

root at host:/sys/class/nvme# grep . nvme*/subsysnqn
nvme0/subsysnqn:nqn.testiqn
nvme1/subsysnqn:nqn.testiqn

root at host:~# /lib/udev/scsi_id --export --whitelisted -d /dev/nvme1n1
ID_SCSI=1
ID_VENDOR=NVMe
ID_VENDOR_ENC=NVMe\x20\x20\x20\x20
ID_MODEL=Linux
ID_MODEL_ENC=Linux
ID_REVISION=0-rc
ID_TYPE=disk
ID_SERIAL=SNVMe_Linux
ID_SERIAL_SHORT=
ID_SCSI_SERIAL=1122334455667788

root at host:~# /lib/udev/scsi_id --export --whitelisted -d /dev/nvme0n1
ID_SCSI=1
ID_VENDOR=NVMe
ID_VENDOR_ENC=NVMe\x20\x20\x20\x20
ID_MODEL=Linux
ID_MODEL_ENC=Linux
ID_REVISION=0-rc
ID_TYPE=disk
ID_SERIAL=SNVMe_Linux
ID_SERIAL_SHORT=
ID_SCSI_SERIAL=1122334455667788

But seems multipathd didn't recognize these 2 devices.

What else I'm missing?

Thanks,
Ming
