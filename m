From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Wed, 25 Nov 2015 20:42:56 +0800
Subject: [PATCH 3/3] nvme: change the interface between nvme and lightnvm
In-Reply-To: <1448455376-5020-1-git-send-email-ww.tao0320@gmail.com>
References: <1448455376-5020-1-git-send-email-ww.tao0320@gmail.com>
Message-ID: <1448455376-5020-4-git-send-email-ww.tao0320@gmail.com>

When nvme devices were removed, we need to handle the targets
build upon them properly: remove the existing targets, block
creations of new ones. To do this clean up job well, we
need to change the interface between nvme and lightnvm.

Signed-off-by: Wenwei Tao <ww.tao0320 at gmail.com>
---
 drivers/nvme/host/lightnvm.c | 17 ++++++++++++++++-
 drivers/nvme/host/nvme.h     |  1 +
 drivers/nvme/host/pci.c      | 10 ++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e0b7b95..3f4ffb7 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -468,6 +468,14 @@ static void nvme_nvm_dev_dma_free(void *pool, void *ppa_list,
 	dma_pool_free(pool, ppa_list, dma_handler);
 }
 
+static void nvme_nvm_dev_remove(struct request_queue *q)
+{
+	struct nvme_ns *ns = q->queuedata;
+
+	kref_put(&ns->kref, nvme_free_ns);
+
+}
+
 static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.identity		= nvme_nvm_identity,
 
@@ -482,13 +490,20 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.destroy_dma_pool	= nvme_nvm_destroy_dma_pool,
 	.dev_dma_alloc		= nvme_nvm_dev_dma_alloc,
 	.dev_dma_free		= nvme_nvm_dev_dma_free,
+	.dev_remove		= nvme_nvm_dev_remove,
 
 	.max_phys_sect		= 64,
 };
 
 int nvme_nvm_register(struct request_queue *q, char *disk_name)
 {
-	return nvm_register(q, disk_name, &nvme_nvm_dev_ops);
+	int ret;
+	struct nvme_ns *ns = q->queuedata;
+
+	ret = nvm_register(q, disk_name, &nvme_nvm_dev_ops);
+	if (!ret)
+		kref_get(&ns->kref);
+	return ret;
 }
 
 void nvme_nvm_unregister(struct request_queue *q, char *disk_name)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fdb4e5b..251ec9d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -116,6 +116,7 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return (sector >> (ns->lba_shift - 9));
 }
 
+void nvme_free_ns(struct kref *kref);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8187df2..f63223d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1960,13 +1960,10 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #endif
 
 static void nvme_free_dev(struct kref *kref);
-static void nvme_free_ns(struct kref *kref)
+void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
-	if (ns->type == NVME_NS_LIGHTNVM)
-		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
-
 	spin_lock(&dev_list_lock);
 	ns->disk->private_data = NULL;
 	spin_unlock(&dev_list_lock);
@@ -2533,6 +2530,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 {
 	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns->queue);
 
+	if (ns->type == NVME_NS_LIGHTNVM) {
+		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
+		ns->type = 0;
+	}
+
 	if (kill)
 		blk_set_queue_dying(ns->queue);
 	if (ns->disk->flags & GENHD_FL_UP)
-- 
1.8.3.1
