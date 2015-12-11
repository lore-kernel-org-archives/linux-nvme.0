From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 Dec 2015 13:14:28 -0700
Subject: [PATCH for-4.4] NVMe: IO ending fixes on surprise removal
Message-ID: <1449864868-8216-1-git-send-email-keith.busch@intel.com>

This patch fixes a lost request discovered during IO + hot removal.

The driver's pci removal deletes gendisks prior to shutting down the
controller to allow dirty data to sync. Dirty data can not be synced on
a surprise removal, though, and would potentially block indefinitely.

The driver previously had marked the queue as dying in this scenario
to prevent new requests from attempting, however it will still block
for requests that already entered the queue. This patch fixes this by
quiescing IO first, then aborting the requeued requests before deleting
disks.

Reported-by: Sujith Pandel <sujith_pandel at dell.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e294ff..0c67b57 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2540,8 +2540,17 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 {
 	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns->queue);
 
-	if (kill)
+	if (kill) {
 		blk_set_queue_dying(ns->queue);
+
+		/*
+		 * The controller was shutdown first if we got here through
+		 * device removal. The shutdown may requeue outstanding
+		 * requests. These need to be aborted immediately so
+		 * del_gendisk doesn't block indefinitely for their completion.
+		 */
+		blk_mq_abort_requeue_list(ns->queue);
+	}
 	if (ns->disk->flags & GENHD_FL_UP)
 		del_gendisk(ns->disk);
 	if (kill || !blk_queue_dying(ns->queue)) {
@@ -2977,6 +2986,15 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
+	if (nvme_io_incapable(dev)) {
+		/*
+		 * If the device is not capable of IO (surprise hot-removal,
+		 * for example), we need to quiesce prior to deleting the
+		 * namespaces. This will end outstanding requests and prevent
+		 * attempts to sync dirty data.
+		 */
+		nvme_dev_shutdown(dev);
+	}
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
 		nvme_ns_remove(ns);
 }
-- 
2.6.2.307.g37023ba
