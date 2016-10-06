From: sbates@raithlin.com (Stephen Bates)
Date: Wed,  5 Oct 2016 20:01:11 -0600
Subject: [PATCH v1 0/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
Message-ID: <1475719272-8370-1-git-send-email-sbates@raithlin.com>

We have had a few attempts at adding CMB properties and control to
sysfs [1][2]. This patch is based on Jon Derrick's [1] to some exent but
takes a much more conservative approach by only displaying CMB
properties and not attmpting to control them. Assuming this gets
accepted I do have a follow-on that adds more information to the cmb
attribute file.

Rather nicely we contain these changes solely to pci.c.

Applies cleanly to commit 997198ba1ed691c ("fs/block_dev.c: return the
right error in thaw_bdev()") in Jens' for-4.9/block branch.

Tested on both QEMU and on some real hardware I have access too that can
advertise and expose a CMB.

[1] http://www.spinics.net/lists/linux-block/msg01560.html
[2] http://www.spinics.net/lists/linux-rdma/msg38752.html

Changes since v0:
  Use direct refernece to nvme_dev cmbsz.
  Use snprintf.
  Added Reviewed-By tags.

Stephen Bates (1):
  nvme : Add sysfs entry for NVMe CMBs when appropriate

 drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

--
2.1.4
