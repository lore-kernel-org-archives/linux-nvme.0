From: kernel@jbeekman.nl (Jethro Beekman)
Date: Sun, 19 Jun 2016 16:06:31 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
Message-ID: <20160619230634.17229-1-kernel@jbeekman.nl>

Hi all,

If an NVMe drive is locked with ATA Security, most commands sent to the drive 
will fail. This includes commands sent by the kernel upon discovery to probe 
for partitions. The failing happens in such a way that trying to do anything 
with the drive (e.g. sending an unlock command; unloading the nvme module) is 
basically impossible with the high default command timeout.

This patch adds a check to see if the drive is locked, and if it is, its 
namespaces are not initialized. It is expected that userspace will send the 
proper "security send/unlock" command and then reset the controller. Userspace 
tools are available at [1].

This is my first kernel patch so please let me know if you have any feedback.

I intend to also submit a future patch that tracks ATA Security commands sent 
from userspace and remembers the password so it can be submitted to a locked 
drive upon pm_resume. (still WIP)

Jethro Beekman

[1] https://github.com/jethrogb/nvme-ata-security

Jethro Beekman (3):
  nvme: When scanning namespaces, make sure the drive is not locked
  nvme: Add function for NVMe security receive command
  nvme: Check if drive is locked using ATA Security

 drivers/nvme/host/core.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

-- 
2.9.0
