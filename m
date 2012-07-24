From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 24 Jul 2012 19:26:14 +0000
Subject: [PATCH] NVMe: Set request queue logical block size
Message-ID: <B58D82457FDA0744A320A2FC5AC253B90D438980@FMSMSX105.amr.corp.intel.com>

Sets the request queue logical block size with the block size of the namespace.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
drivers/block/nvme.c |    1 +
1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f4996b0..38b9c73 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1344,6 +1344,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
     ns->disk = disk;
     lbaf = id->flbas & 0xf;
     ns->lba_shift = id->lbaf[lbaf].ds;
+     blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
      disk->major = nvme_major;
     disk->minors = NVME_MINORS;
--
1.7.0.4

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://merlin.infradead.org/pipermail/linux-nvme/attachments/20120724/cf1a7436/attachment.html>
