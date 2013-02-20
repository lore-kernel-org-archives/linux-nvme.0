From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:42 -0700
Subject: [PATCH 5/8] NVMe: End queued bio requests for removed disks
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-5-git-send-email-keith.busch@intel.com>

Bio requests queued in the driver should not submit the request to disks
being deleted. This patch checks if the disk is up before submitting and
lets the kthread run on a device being removed until after the namespaces
have been cleared so that the bio's can be ended.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index aeaea1a..199c182 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1308,6 +1308,10 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 	while (bio_list_peek(list)) {
 		struct bio *bio = bio_list_pop(list);
 		struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
+		if (!(bio->bi_bdev->bd_disk->flags & GENHD_FL_UP)) {
+				bio_endio(bio, -EIO);
+				continue;
+		}
 		if (nvme_submit_bio_queue(nvmeq, ns, bio)) {
 			bio_list_add_head(list, bio);
 			break;
@@ -1592,16 +1596,16 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
-	spin_lock(&dev_list_lock);
-	list_del(&dev->node);
-	spin_unlock(&dev_list_lock);
-
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
 		del_gendisk(ns->disk);
 		nvme_ns_free(ns);
 	}
 
+	spin_lock(&dev_list_lock);
+	list_del(&dev->node);
+	spin_unlock(&dev_list_lock);
+
 	nvme_free_queues(dev);
 
 	return 0;
-- 
1.7.0.4
