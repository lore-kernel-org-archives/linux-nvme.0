From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Fri, 27 Nov 2015 12:09:44 +0800
Subject: [PATCH v2 3/3] nvme: change the interface between nvme and lightnvm
In-Reply-To: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>
References: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>
Message-ID: <1448597384-27976-4-git-send-email-ww.tao0320@gmail.com>

When nvme devices were removed, we need to handle the targets
build upon them properly: remove the existing targets, block
creations of new ones. To do this clean up job well, we
need to change the interface between nvme and lightnvm.

Signed-off-by: Wenwei Tao <ww.tao0320 at gmail.com>
---
 drivers/nvme/host/lightnvm.c | 17 ++++++++++++++++-
 drivers/nvme/host/nvme.h     |  1 +
 drivers/nvme/host/pci.c      |  7 +++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 9202d1a..742875e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -542,6 +542,14 @@ static void nvme_nvm_dev_dma_free(void *pool, void *ppa_list,
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
 
@@ -557,13 +565,20 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
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
index f3b53af..5f0f934 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1967,13 +1967,10 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -2540,6 +2537,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 {
 	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns->queue);
 
+	if (ns->type == NVME_NS_LIGHTNVM)
+		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
 	if (kill)
 		blk_set_queue_dying(ns->queue);
 	if (ns->disk->flags & GENHD_FL_UP)
-- 
1.8.3.1
