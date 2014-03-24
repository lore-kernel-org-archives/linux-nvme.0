From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Mar 2014 10:46:26 -0600
Subject: [PATCH 2/2] NVMe: CPU hot plug notification
In-Reply-To: <1395679586-13410-1-git-send-email-keith.busch@intel.com>
References: <1395679586-13410-1-git-send-email-keith.busch@intel.com>
Message-ID: <1395679586-13410-3-git-send-email-keith.busch@intel.com>

Registers with hot cpu notification to rebalance, and potentially allocate
additional, io queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   19 +++++++++++++++++++
 include/linux/nvme.h      |    1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d00710b..c3d4989 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2001,6 +2001,19 @@ static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
 }
 
+static int nvme_cpu_notify(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	struct nvme_dev *dev = container_of(self, struct nvme_dev, nb);
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_DEAD:
+		nvme_assign_io_queues(dev);
+		break;
+	}
+	return NOTIFY_OK;
+}
+ 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = raw_nvmeq(dev, 0);
@@ -2079,6 +2092,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	nvme_free_queues(dev, nr_io_queues + 1);
 	nvme_assign_io_queues(dev);
 
+	dev->nb.notifier_call = &nvme_cpu_notify;
+	result = register_hotcpu_notifier(&dev->nb);
+	if (result)
+		goto free_queues;
+
 	return 0;
 
  free_queues:
@@ -2356,6 +2374,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	int i;
 
 	dev->initialized = 0;
+	unregister_hotcpu_notifier(&dev->nb);
 
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f0f95c71..15d071e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -92,6 +92,7 @@ struct nvme_dev {
 	struct kref kref;
 	struct miscdevice miscdev;
 	struct work_struct reset_work;
+	struct notifier_block nb;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.10.4
