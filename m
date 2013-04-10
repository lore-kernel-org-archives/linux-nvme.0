From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Apr 2013 16:11:29 -0600
Subject: [PATCH] NVMe: Discard errors adding namespaces
Message-ID: <1365631889-20647-1-git-send-email-keith.busch@intel.com>

Errors encountered while discovering namespaces are not fatal and we
should continue adding the device. Erroring out from there before would
leave namespaces registered as block devices but the nvme device and
queues would have been deleted, which isn't good.

Signed-off-by: Keith Busch <keith.busch at intel.com>

This patch was discussed here:

http://merlin.infradead.org/pipermail/linux-nvme/2013-April/000198.html

In case there are errors or we can't add any namespaces, it would be
helpful if we had the character device from here:

http://merlin.infradead.org/pipermail/linux-nvme/2013-February/000138.html

I can resubmit the character device patch to merge with the nvme scsi
commits.
---
 drivers/block/nvme-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a89f7db..5cdfc3a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1556,6 +1556,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	list_for_each_entry(ns, &dev->namespaces, list)
 		add_disk(ns->disk);
 
+	res = 0;
 	goto out;
 
  out_free:
-- 
1.7.0.4
