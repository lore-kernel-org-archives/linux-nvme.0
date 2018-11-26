From: james@dingwall.me.uk (James Dingwall)
Date: Mon, 26 Nov 2018 13:38:39 +0000
Subject: Two M.2 NVMe drives with same NQN, one gets removed
Message-ID: <20181126133839.GA4348@dingwall.me.uk>

Hi,

We have also encountered this issue but the devices have a customised
firmware from Lenovo:

# nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid : 0x8086
ssvid : 0x8086
sn : BTHH82250N1X1P0E
mn : INTEL SSDPEKKF010T8L
fr : L08P

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803692?comments=all

I tried to force install the Intel firmware but that did not work.  I
was fobbed off by Lenovo support with a 'we don't support Linux' even
after pointing out the upstream Intel fix.  Is there any possibility
of being able to work around this in the nvme code?

Thanks,
James
