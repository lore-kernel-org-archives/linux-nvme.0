From: keith.busch@intel.com (Keith Busch)
Date: Fri, 31 Jan 2014 16:53:42 -0700
Subject: [PATCHv2 4/4] NVMe: CPU hot plug notification
In-Reply-To: <1391212422-14764-1-git-send-email-keith.busch@intel.com>
References: <1391212422-14764-1-git-send-email-keith.busch@intel.com>
Message-ID: <1391212422-14764-5-git-send-email-keith.busch@intel.com>

Registers with hot cpu notification to rebalance - and potentially
allocate additional - io queues among cpus.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   23 ++++++++++++++++++++++-
 include/linux/nvme.h      |    1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index acea1ee..c68016d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2018,7 +2018,8 @@ static void nvme_assign_io_queues(struct nvme_dev *dev)
 	/*
 	 * All possible cpus must point to a valid queue. We don't have thread
 	 * sibling info on offline cpus, so no sharing optimization on these
-	 * cpus.
+	 * cpus. These should automatically be rebalanced from hot plug
+	 * notification.
 	 */
 	cpumask_andnot(&unassigned_cpus, cpu_possible_mask, cpu_online_mask);
 	i = 0;
@@ -2044,6 +2045,19 @@ static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
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
 	struct nvme_queue *adminq = dev->queues[0];
@@ -2121,6 +2135,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	/* Free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, nr_io_queues + 1);
 	nvme_assign_io_queues(dev);
+
+	dev->nb.notifier_call = &nvme_cpu_notify;
+	result = register_hotcpu_notifier(&dev->nb);
+	if (result)
+		goto free_queues;
+
 	return 0;
 
  free_queues:
@@ -2398,6 +2418,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	int i;
 
 	dev->initialized = 0;
+	unregister_hotcpu_notifier(&dev->nb);
 
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d574acd..fb5911d 100644
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
