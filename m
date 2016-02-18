From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 19:38:51 +0000
Subject: [PATCH-4.5-v3 4/5] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <20160218041122.GC12379@infradead.org>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-5-git-send-email-keith.busch@intel.com>
 <20160218041122.GC12379@infradead.org>
Message-ID: <20160218193850.GA9620@localhost.localdomain>

On Wed, Feb 17, 2016@08:11:22PM -0800, Christoph Hellwig wrote:
> Is there a good reason to skyp the admin queue here entirely?

It is not necessary to progress namespace removal, and we don't want to
step on the controller removal path in case it actually is making progress
(we only think it's dead in this path).

A catch all place to restart a failed admin queue to allow controller
removal to complete is nvme_dev_remove_admin().

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f11daba..4953008 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1253,6 +1253,12 @@ static struct blk_mq_ops nvme_mq_ops = {
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
 {
 	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q)) {
+		/*
+		 * If the controller was reset during removal, it's possible
+		 * user requests may be waiting on a stopped queue. Start the
+		 * queue to flush these to completion.
+		 */
+		blk_mq_start_stopped_hw_queues(dev->ctrl.admin_q, true);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
--

BTW, from testing this I notice the logic in nvme_queue_rq was screwed
up in this patch when I switched from the ternary '?:' to 'if-else'.

Jens hasn't pushed anything this series yet so I'll resend and fold the
above in.
