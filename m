From: keith.busch@intel.com (Keith Busch)
Date: Tue, 14 Jul 2015 11:57:32 -0600
Subject: [PATCH] NVMe: Allow reserved minors
Message-ID: <1436896652-27332-1-git-send-email-keith.busch@intel.com>

The patch is to aid users transitioning from SCSI to NVM-Express. Some
storage applications inherited from scsi have fixed minor requirements
for partitions, so this patch allows a user to specify a number of
minors they want reserved per namespace, defaulting to 0 to match
existing functionality; set to 16 to match scsi.

Reported-by: Dammi Wickramanayake <dammi_wickramanayake at symantec.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Matthew Wilcox <willy at linux.intel.com>
---
 drivers/block/nvme-core.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..e9127ad 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -66,6 +66,10 @@ MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown")
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
+static unsigned char nvme_minors = 0;
+module_param_named(minors, nvme_minors, byte, 0444);
+MODULE_PARM_DESC(minors, "number of minors per nvme namespace");
+
 static int nvme_char_major;
 module_param(nvme_char_major, int, 0);
 
@@ -2052,6 +2056,33 @@ static int nvme_kthread(void *data)
 	return 0;
 }
 
+static DEFINE_IDA(nvme_index_ida);
+
+static int nvme_get_ns_idx(void)
+{
+	int index, error;
+
+	do {
+		if (!ida_pre_get(&nvme_index_ida, GFP_KERNEL))
+			return -1;
+
+		spin_lock(&dev_list_lock);
+		error = ida_get_new(&nvme_index_ida, &index);
+		spin_unlock(&dev_list_lock);
+	} while (error == -EAGAIN);
+
+	if (error)
+		index = -1;
+	return index;
+}
+
+static void nvme_put_ns_idx(int index)
+{
+	spin_lock(&dev_list_lock);
+	ida_remove(&nvme_index_ida, index);
+	spin_unlock(&dev_list_lock);
+}
+
 static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 {
 	struct nvme_ns *ns;
@@ -2089,7 +2120,13 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 
 	disk->major = nvme_major;
-	disk->first_minor = 0;
+	disk->minors = nvme_minors;
+
+	if (nvme_minors)
+		disk->first_minor = nvme_minors * nvme_get_ns_idx();
+	else
+		disk->first_minor = 0;
+
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
@@ -2249,7 +2286,10 @@ static void nvme_free_namespace(struct nvme_ns *ns)
 	ns->disk->private_data = NULL;
 	spin_unlock(&dev_list_lock);
 
+	if (nvme_minors)
+		nvme_put_ns_idx(ns->disk->first_minor / nvme_minors);
 	put_disk(ns->disk);
+
 	kfree(ns);
 }
 
-- 
1.7.10.4
