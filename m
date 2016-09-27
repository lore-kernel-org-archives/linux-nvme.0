From: sbates@raithlin.com (Stephen Bates)
Date: Tue, 27 Sep 2016 16:15:12 -0600
Subject: [PATCH 0/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
Message-ID: <1475014513-18083-1-git-send-email-sbates@raithlin.com>

We have had a few attempts at adding CMB properties and control to
sysfs [1][2]. This patch is based on Jon Derrick's [1] to some exent but
takes a much more conservative approach by only displaying CMB
properties and not attmpting to control them. Assuming this gets
accepted I do have a follow-on that adds more information to the cmb
attribute file.

Rather nicely we contain these changes solely to pci.c.

Applies to commit 1a6fe74dfd1b ("nvme: Pass pointers, not dma
addresses, to nvme_get/set_features()") in Jens' for-4.9/block branch.

Tested on both QEMU and on some real hardware I have access too that can
advertise and expose a CMB.

[1] http://www.spinics.net/lists/linux-block/msg01560.html
[2] http://www.spinics.net/lists/linux-rdma/msg38752.html

Stephen Bates (1):
  nvme : Add sysfs entry for NVMe CMBs when appropriate

 drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

--
2.1.4
