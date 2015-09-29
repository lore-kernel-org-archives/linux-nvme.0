From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Sep 2015 19:21:31 -0700
Subject: [PATCH 4/4] nvme: move pci specific calls in ops structure to allow
 other (i.e. fabrics) modules to be added
Message-ID: <1443493291.3449.16.camel@linux.intel.com>

>From 8828a038146e1f28cd71e691c6fad476e74e4309 Mon Sep 17 00:00:00 2001
From: Jay Sternberg <jay.e.sternberg@intel.com>
Date: Mon, 28 Sep 2015 11:43:21 -0700
Subject: [PATCH 4/4] nvme: move pci specific calls in ops structure to
allow other (i.e. fabrics) modules to be added

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
---
 drivers/nvme/host/common.h |    8 ++---
 drivers/nvme/host/core.c   |   52 ++++++++++++++++--------------
 drivers/nvme/host/ops.h    |   61 ++++++++++++++++++----------------
 drivers/nvme/host/pci.c    |   77 +++++++++++++++++++++++++++++-------
-------
 drivers/nvme/host/scsi.c   |    4 +-
 5 files changed, 117 insertions(+), 85 deletions(-)

diff --git a/drivers/nvme/host/common.h b/drivers/nvme/host/common.h
index 0c1ca8a..202d876 100644
--- a/drivers/nvme/host/common.h
+++ b/drivers/nvme/host/common.h
@@ -20,10 +20,7 @@
 #include <linux/kthread.h>
 #include <linux/blk-mq.h>
 
-#define NVME_MINORS		(1U << MINORBITS)
-#define ADMIN_TIMEOUT		(admin_timeout * HZ)
 #define NVME_IO_TIMEOUT		(nvme_io_timeout * HZ)
-#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
 #define NVME_AQ_DEPTH		256
 #define NVME_Q_DEPTH		1024
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -47,7 +44,7 @@ struct async_cmd_info {
 struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
-	void *context;
+	void *context;		/* Fabric Specific data */
 	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
 	struct nvme_command __iomem *sq_cmds_io;
@@ -71,7 +68,8 @@ struct nvme_queue {
  */
 struct nvme_dev {
 	struct list_head node;
-	void *context;
+	void *context;		/* Fabric Specific data */
+	struct nvme_common_host_operations *nvme_ops;
 	struct nvme_queue **queues;
 	struct request_queue *admin_q;
 	struct blk_mq_tag_set tagset;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cda911f..6fcca22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -335,7 +335,7 @@ static void __nvme_submit_cmd(struct nvme_queue
*nvmeq,
 		tail = 0;
 
 	nvmeq->sq_tail = tail;
-	nvme_pci_submit_sync_cmd(nvmeq, cmd);
+	nvmeq->dev->nvme_ops->sync_cmd(nvmeq, cmd);
 }
 
 static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct
nvme_command *cmd)
@@ -911,7 +911,7 @@ int nvme_process_cq(struct nvme_queue *nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
-	nvme_pci_process_cq(nvmeq, head);
+	nvmeq->dev->nvme_ops->process_completion(nvmeq, head);
 
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
@@ -1322,7 +1322,9 @@ static int nvme_suspend_queue(struct nvme_queue
*nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvme_pci_get_vector(nvmeq);
+
+	vector = dev->nvme_ops->get_vector(nvmeq);
+
 	dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1330,7 +1332,7 @@ static int nvme_suspend_queue(struct nvme_queue
*nvmeq)
 	if (!nvmeq->qid && dev->admin_q)
 		blk_mq_freeze_queue_start(dev->admin_q);
 
-	nvme_pci_suspend_queue(nvmeq, vector);
+	dev->nvme_ops->suspend_queue(nvmeq, vector);
 
 	return 0;
 }
@@ -1354,7 +1356,7 @@ static void nvme_disable_queue(struct nvme_dev
*dev, int qid)
 
 	/* Don't tell the adapter to delete the admin queue.
 	 * Don't tell a removed adapter to delete IO queues. */
-	if (qid && nvme_pci_is_active(dev)) {
+	if (qid && dev->nvme_ops->is_active(dev)) {
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
@@ -1396,8 +1398,8 @@ static struct nvme_queue *nvme_alloc_queue(struct
nvme_dev *dev, int qid,
 	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
 
-	/* added call for setting irqname and q_db */
-	nvme_pci_alloc_queue(nvmeq);
+// added ops call for setting irqname and q_db
+	dev->nvme_ops->alloc_queue(nvmeq);
 
 	/* make sure queue descriptor is set before queue count, for
kthread */
 	mb();
@@ -1423,7 +1425,7 @@ static void nvme_init_queue(struct nvme_queue
*nvmeq, u16 qid)
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 
-	nvme_pci_init_queue(nvmeq);
+	dev->nvme_ops->init_queue(nvmeq);
 
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
@@ -1444,7 +1446,7 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
-	result = nvme_pci_create_queue(nvmeq);
+	result = dev->nvme_ops->create_queue(nvmeq);
 	if (result)
 		goto release_sq;
 
@@ -1526,7 +1528,7 @@ static int nvme_configure_admin_queue(struct
nvme_dev *dev)
 			return -ENOMEM;
 	}
 
-	result = nvme_pci_setup_admin_queue(nvmeq);
+	result = dev->nvme_ops->setup_admin_queue(nvmeq);
 	if (result)
 		goto free_nvmeq;
 
@@ -1819,7 +1821,7 @@ static int nvme_kthread(void *data)
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
 
-			if (nvme_pci_is_status_fatal(dev)) {
+			if (dev->nvme_ops->is_status_fatal(dev)) {
 				if (work_busy(&dev->reset_work))
 					continue;
 				list_del_init(&dev->node);
@@ -1971,7 +1973,7 @@ static int nvme_setup_io_queues(struct nvme_dev
*dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
-	result = nvme_pci_setup_io_queues(dev, nr_io_queues);
+	result = dev->nvme_ops->setup_io_queues(dev, nr_io_queues);
 	if (result <= 0)
 		goto free_queues;
 
@@ -2025,7 +2027,7 @@ static struct nvme_ns *nvme_find_ns(struct
nvme_dev *dev, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool kill = nvme_pci_is_io_incapable(ns->dev) &&
+	bool kill = ns->dev->nvme_ops->is_io_incapable(ns->dev) &&
 		!blk_queue_dying(ns->queue);
 
 	if (kill)
@@ -2098,7 +2100,7 @@ int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 	}
-	return nvme_pci_dev_add(dev);
+	return dev->nvme_ops->dev_add(dev);
 }
 EXPORT_SYMBOL_GPL(nvme_dev_add);
 
@@ -2127,7 +2129,7 @@ static void nvme_wait_dq(struct nvme_delq_ctx
*dq, struct nvme_dev *dev)
 			 * queues than admin tags.
 			 */
 			set_current_state(TASK_RUNNING);
-			nvme_pci_disable_ctrl(dev);
+			dev->nvme_ops->dev_disable(dev);
 			nvme_clear_queue(dev->queues[0]);
 			flush_kthread_worker(dq->worker);
 			nvme_disable_queue(dev, 0);
@@ -2297,18 +2299,18 @@ void nvme_dev_shutdown(struct nvme_dev *dev)
 	nvme_dev_list_remove(dev);
 
 	nvme_freeze_queues(dev);
-	if (nvme_pci_is_active(dev) || !nvme_pci_is_ready(dev)) {
+	if (dev->nvme_ops->is_active(dev) || !dev->nvme_ops
->is_ready(dev)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = dev->queues[i];
 			nvme_suspend_queue(nvmeq);
 		}
 	} else {
 		nvme_disable_io_queues(dev);
-		nvme_pci_shutdown_ctrl(dev);
+		dev->nvme_ops->dev_shutdown(dev);
 		nvme_disable_queue(dev, 0);
 	}
 
-	nvme_pci_dev_unmap(dev);
+	dev->nvme_ops->dev_unmap(dev);
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_clear_queue(dev->queues[i]);
@@ -2448,7 +2450,7 @@ static long nvme_dev_ioctl(struct file *f,
unsigned int cmd, unsigned long arg)
 		dev_warn(dev->dev, "resetting controller\n");
 		return nvme_reset(dev);
 	case NVME_IOCTL_SUBSYS_RESET:
-		return nvme_pci_subsys_reset(dev);
+		return dev->nvme_ops->subsys_reset(dev);
 	default:
 		return -ENOTTY;
 	}
@@ -2467,7 +2469,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	int result;
 	bool start_thread = false;
 
-	result = nvme_pci_dev_map(dev);
+	result = dev->nvme_ops->dev_map(dev);
 	if (result)
 		return result;
 
@@ -2515,7 +2517,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	nvme_disable_queue(dev, 0);
 	nvme_dev_list_remove(dev);
  unmap:
-	nvme_pci_dev_unmap(dev);
+	dev->nvme_ops->dev_unmap(dev);
 	return result;
 }
 
@@ -2523,7 +2525,7 @@ static int nvme_remove_dead_ctrl(void *arg)
 {
 	struct nvme_dev *dev = (struct nvme_dev *)arg;
 
-	nvme_pci_remove_dead_ctrl(dev);
+	dev->nvme_ops->remove_dead_dev(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 	return 0;
 }
@@ -2551,7 +2553,7 @@ int nvme_dev_resume(struct nvme_dev *dev)
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
-		nvme_pci_set_irq_hints(dev);
+		dev->nvme_ops->set_hints(dev);
 	}
 	return 0;
 }
@@ -2646,7 +2648,8 @@ static ssize_t nvme_sysfs_reset(struct device
*dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
-struct nvme_dev *nvme_common_create_dev(struct device *device, void
*context)
+struct nvme_dev *nvme_common_create_dev(struct device *device, void
*context,
+					struct
nvme_common_host_operations *ops)
 {
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
@@ -2693,6 +2696,7 @@ struct nvme_dev *nvme_common_create_dev(struct
device *device, void *context)
 		goto put_dev;
 
 	dev->context = context;
+	dev->nvme_ops = ops;
 
 	INIT_LIST_HEAD(&dev->node);
 
diff --git a/drivers/nvme/host/ops.h b/drivers/nvme/host/ops.h
index 6727da2..02e76fe 100644
--- a/drivers/nvme/host/ops.h
+++ b/drivers/nvme/host/ops.h
@@ -14,43 +14,46 @@
 #ifndef _NVME_OPS_H
 #define _NVME_OPS_H
 
+#include <linux/spinlock_types.h>
+
+struct nvme_common_host_operations {
+	int (*get_version)(struct nvme_dev *dev);
+	int (*get_vector)(struct nvme_queue *nvmeq);
+	int (*is_status_fatal)(struct nvme_dev *dev);
+	int (*is_active)(struct nvme_dev *dev);
+	int (*is_ready)(struct nvme_dev *dev);
+	int (*is_io_incapable)(struct nvme_dev *dev);
+	int (*sync_cmd)(struct nvme_queue *q, struct nvme_command
*cmd);
+	int (*async_cmd)(struct nvme_queue *q, struct nvme_command
*cmd,
+			 struct nvme_iod *iod);
+	void (*process_completion)(struct nvme_queue *q, u16 head);
+	int (*setup_admin_queue)(struct nvme_queue *nvmeq);
+	int (*setup_io_queues)(struct nvme_dev *dev, int
nr_io_queues);
+	int (*create_queue)(struct nvme_queue *q);
+	void (*init_queue)(struct nvme_queue *q);
+	void (*suspend_queue)(struct nvme_queue *q, int);
+	void (*set_hints)(struct nvme_dev *dev);
+	int (*alloc_queue)(struct nvme_queue *q);
+	int (*dev_add)(struct nvme_dev *dev);
+	int (*dev_map)(struct nvme_dev *dev);
+	void (*dev_unmap)(struct nvme_dev *dev);
+	int (*dev_enable)(struct nvme_dev *dev);
+	int (*dev_disable)(struct nvme_dev *dev);
+	int (*dev_shutdown)(struct nvme_dev *dev);
+	int (*subsys_reset)(struct nvme_dev *dev);
+	void (*remove_dead_dev)(struct nvme_dev *dev);
+};
+
 void nvme_dev_shutdown(struct nvme_dev *dev);
 int nvme_dev_resume(struct nvme_dev *dev);
 void nvme_dead_ctrl(struct nvme_dev *dev);
 void nvme_remove(struct nvme_dev *dev);
 void nvme_common_reset_failed_dev(struct nvme_dev *dev);
-struct nvme_dev *nvme_common_create_dev(struct device *device, void
*context);
+struct nvme_dev *nvme_common_create_dev(struct device *device, void
*context,
+					struct
nvme_common_host_operations *o);
 void nvme_dev_reset(struct nvme_dev *dev);
 int nvme_dev_add(struct nvme_dev *dev);
 void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn);
 int nvme_process_cq(struct nvme_queue *nvmeq);
 
-int nvme_pci_get_version(struct nvme_dev *dev);
-int nvme_pci_get_vector(struct nvme_queue *nvmeq);
-int nvme_pci_is_active(struct nvme_dev *dev);
-int nvme_pci_is_status_fatal(struct nvme_dev *dev);
-int nvme_pci_is_ready(struct nvme_dev *dev);
-int nvme_pci_subsys_reset(struct nvme_dev *dev);
-int nvme_pci_is_io_incapable(struct nvme_dev *dev);
-void nvme_pci_process_cq(struct nvme_queue *nvmeq, u16 head);
-int nvme_pci_submit_sync_cmd(struct nvme_queue *nvmeq,
-				    struct nvme_command *cmd);
-int nvme_pci_submit_async_cmd(struct nvme_queue *nvmeq,
-				     struct nvme_command *cmd,
-				     struct nvme_iod *iod);
-void nvme_pci_set_irq_hints(struct nvme_dev *dev);
-int nvme_pci_setup_io_queues(struct nvme_dev *dev, int nr_io_queues);
-int nvme_pci_disable_ctrl(struct nvme_dev *dev);
-int nvme_pci_enable_ctrl(struct nvme_dev *dev);
-int nvme_pci_shutdown_ctrl(struct nvme_dev *dev);
-void nvme_pci_init_queue(struct nvme_queue *nvmeq);
-int nvme_pci_create_queue(struct nvme_queue *nvmeq);
-int nvme_pci_setup_admin_queue(struct nvme_queue *nvmeq);
-void nvme_pci_suspend_queue(struct nvme_queue *nvmeq, int vector);
-int nvme_pci_alloc_queue(struct nvme_queue *nvmeq);
-int nvme_pci_dev_add(struct nvme_dev *dev);
-int nvme_pci_dev_map(struct nvme_dev *dev);
-void nvme_pci_dev_unmap(struct nvme_dev *dev);
-void nvme_pci_remove_dead_ctrl(struct nvme_dev *dev);
-
 #endif	/* _NVME_OPS_H */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b5de565..2a4b04c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -12,8 +12,8 @@
  */
 
 #include "common.h"
-#include "ops.h"
 #include "pci.h"
+#include "ops.h"
 
 #include <linux/module.h>
 #include <linux/device.h>
@@ -37,7 +37,7 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's
memory buffer for I/O SQes");
 static struct workqueue_struct *nvme_workq;
 static int shutting_down;
 
-int nvme_pci_get_version(struct nvme_dev *dev)
+static int nvme_pci_get_version(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 
@@ -46,7 +46,7 @@ int nvme_pci_get_version(struct nvme_dev *dev)
 	return readl(&pdev->bar->vs);
 }
 
-int nvme_pci_get_vector(struct nvme_queue *nvmeq)
+static int nvme_pci_get_vector(struct nvme_queue *nvmeq)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
@@ -54,7 +54,7 @@ int nvme_pci_get_vector(struct nvme_queue *nvmeq)
 	return pdev->entry[nvmeq->cq_vector].vector;
 }
 
-int nvme_pci_is_active(struct nvme_dev *dev)
+static int nvme_pci_is_active(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 
@@ -64,7 +64,7 @@ int nvme_pci_is_active(struct nvme_dev *dev)
 		  readl(&pdev->bar->csts) != -1);
 }
 
-int nvme_pci_is_status_fatal(struct nvme_dev *dev)
+static int nvme_pci_is_status_fatal(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 	int ret = 0;
@@ -80,7 +80,7 @@ int nvme_pci_is_status_fatal(struct nvme_dev *dev)
 	return ret;
 }
 
-int nvme_pci_is_ready(struct nvme_dev *dev)
+static int nvme_pci_is_ready(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 
@@ -90,7 +90,7 @@ int nvme_pci_is_ready(struct nvme_dev *dev)
 		  readl(&pdev->bar->csts) & NVME_CSTS_RDY);
 }
 
-int nvme_pci_subsys_reset(struct nvme_dev *dev)
+static int nvme_pci_subsys_reset(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 
@@ -103,7 +103,7 @@ int nvme_pci_subsys_reset(struct nvme_dev *dev)
 	return 0;
 }
 
-int nvme_pci_is_io_incapable(struct nvme_dev *dev)
+static int nvme_pci_is_io_incapable(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 
@@ -114,7 +114,7 @@ int nvme_pci_is_io_incapable(struct nvme_dev *dev)
 		dev->online_queues < 2);
 }
 
-void nvme_pci_process_cq(struct nvme_queue *nvmeq, u16 head)
+static void nvme_pci_process_cq(struct nvme_queue *nvmeq, u16 head)
 {
 	struct nvme_pci_queue *q;
 	struct nvme_pci_dev *pdev;
@@ -125,7 +125,7 @@ void nvme_pci_process_cq(struct nvme_queue *nvmeq,
u16 head)
 	writel(head, q->q_db + pdev->db_stride);
 }
 
-int nvme_pci_submit_sync_cmd(struct nvme_queue *nvmeq,
+static int nvme_pci_submit_sync_cmd(struct nvme_queue *nvmeq,
 				    struct nvme_command *cmd)
 {
 	struct nvme_pci_queue *q;
@@ -137,7 +137,7 @@ int nvme_pci_submit_sync_cmd(struct nvme_queue
*nvmeq,
 	return 0;
 }
 
-int nvme_pci_submit_async_cmd(struct nvme_queue *nvmeq,
+static int nvme_pci_submit_async_cmd(struct nvme_queue *nvmeq,
 				     struct nvme_command *cmd,
 				     struct nvme_iod *iod)
 {
@@ -150,7 +150,7 @@ int nvme_pci_submit_async_cmd(struct nvme_queue
*nvmeq,
 	return 0;
 }
 
-void nvme_pci_set_irq_hints(struct nvme_dev *dev)
+static void nvme_pci_set_irq_hints(struct nvme_dev *dev)
 {
 	struct nvme_queue *nvmeq;
 	struct nvme_pci_dev *pdev;
@@ -253,7 +253,7 @@ static inline void nvme_release_cmb(struct nvme_dev
*dev)
 	}
 }
 
-int nvme_pci_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
+static int nvme_pci_setup_io_queues(struct nvme_dev *dev, int
nr_io_queues)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct nvme_pci_queue *q = (struct nvme_pci_queue *) adminq
->context;
@@ -387,7 +387,7 @@ static int _nvme_pci_enable_ctrl(struct nvme_dev
*dev, u64 cap)
 	return nvme_wait_ready(dev, cap, true);
 }
 
-int nvme_pci_disable_ctrl(struct nvme_dev *dev)
+static int nvme_pci_disable_ctrl(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 	u64		     cap;
@@ -398,7 +398,7 @@ int nvme_pci_disable_ctrl(struct nvme_dev *dev)
 	return _nvme_pci_disable_ctrl(dev, cap);
 }
 
-int nvme_pci_enable_ctrl(struct nvme_dev *dev)
+static int nvme_pci_enable_ctrl(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev *pdev;
 	u64		     cap;
@@ -437,7 +437,7 @@ int nvme_pci_shutdown_ctrl(struct nvme_dev *dev)
 	return 0;
 }
 
-void nvme_pci_init_queue(struct nvme_queue *nvmeq)
+static void nvme_pci_init_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	struct nvme_dev *dev = nvmeq->dev;
@@ -446,7 +446,7 @@ void nvme_pci_init_queue(struct nvme_queue *nvmeq)
 	q->q_db = &pdev->dbs[nvmeq->qid * 2 * pdev->db_stride];
 }
 
-int nvme_pci_create_queue(struct nvme_queue *nvmeq)
+static int nvme_pci_create_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	struct nvme_dev *dev = nvmeq->dev;
@@ -454,7 +454,7 @@ int nvme_pci_create_queue(struct nvme_queue *nvmeq)
 	return queue_request_irq(dev, nvmeq, q->irqname);
 }
 
-int nvme_pci_setup_admin_queue(struct nvme_queue *nvmeq)
+static int nvme_pci_setup_admin_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	struct nvme_dev *dev = nvmeq->dev;
@@ -516,7 +516,7 @@ int nvme_pci_setup_admin_queue(struct nvme_queue
*nvmeq)
 	return result;
 }
 
-void nvme_pci_suspend_queue(struct nvme_queue *nvmeq, int vector)
+static void nvme_pci_suspend_queue(struct nvme_queue *nvmeq, int
vector)
 {
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
@@ -588,7 +588,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev,
struct nvme_queue *nvmeq,
 	return 0;
 }
 
-int nvme_pci_alloc_queue(struct nvme_queue *nvmeq)
+static int nvme_pci_alloc_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_pci_queue	*q;
 	struct nvme_dev		*dev = nvmeq->dev;
@@ -615,7 +615,7 @@ err:
 	return -ENOMEM;
 }
 
-int nvme_pci_dev_add(struct nvme_dev *dev)
+static int nvme_pci_dev_add(struct nvme_dev *dev)
 {
 	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
 	struct pci_dev		*pci_dev = to_pci_dev(dev->dev);
@@ -661,7 +661,7 @@ int nvme_pci_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
-int nvme_pci_dev_map(struct nvme_dev *dev)
+static int nvme_pci_dev_map(struct nvme_dev *dev)
 {
 	u64 cap;
 	int bars, result = -ENOMEM;
@@ -725,7 +725,7 @@ int nvme_pci_dev_map(struct nvme_dev *dev)
 	return result;
 }
 
-void nvme_pci_dev_unmap(struct nvme_dev *dev)
+static void nvme_pci_dev_unmap(struct nvme_dev *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
 	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
@@ -749,7 +749,7 @@ void nvme_pci_dev_unmap(struct nvme_dev *dev)
 		pci_disable_device(pci_dev);
 }
 
-void nvme_pci_remove_dead_ctrl(struct nvme_dev *dev)
+static void nvme_pci_remove_dead_ctrl(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
@@ -757,6 +757,33 @@ void nvme_pci_remove_dead_ctrl(struct nvme_dev
*dev)
 		pci_stop_and_remove_bus_device_locked(pdev);
 }
 
+static struct nvme_common_host_operations nvme_pci_ops = {
+	.get_version		= nvme_pci_get_version,
+	.get_vector		= nvme_pci_get_vector,
+	.is_active		= nvme_pci_is_active,
+	.is_status_fatal	= nvme_pci_is_status_fatal,
+	.is_ready		= nvme_pci_is_ready,
+	.is_io_incapable	= nvme_pci_is_io_incapable,
+	.subsys_reset		= nvme_pci_subsys_reset,
+	.sync_cmd		= nvme_pci_submit_sync_cmd,
+	.async_cmd		= nvme_pci_submit_async_cmd,
+	.process_completion	= nvme_pci_process_cq,
+	.setup_io_queues	= nvme_pci_setup_io_queues,
+	.setup_admin_queue	= nvme_pci_setup_admin_queue,
+	.create_queue		= nvme_pci_create_queue,
+	.init_queue		= nvme_pci_init_queue,
+	.suspend_queue		= nvme_pci_suspend_queue,
+	.set_hints		= nvme_pci_set_irq_hints,
+	.alloc_queue		= nvme_pci_alloc_queue,
+	.dev_add		= nvme_pci_dev_add,
+	.dev_map		= nvme_pci_dev_map,
+	.dev_unmap		= nvme_pci_dev_unmap,
+	.dev_enable		= nvme_pci_enable_ctrl,
+	.dev_disable		= nvme_pci_disable_ctrl,
+	.dev_shutdown		= nvme_pci_shutdown_ctrl,
+	.remove_dead_dev	= nvme_pci_remove_dead_ctrl,
+};
+
 static void nvme_pci_reset_notify(struct pci_dev *pdev, bool prepare)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
@@ -835,7 +862,7 @@ static int nvme_pci_probe(struct pci_dev *pci_dev,
 	if (!pdev->entry)
 		goto free;
 
-	dev = nvme_common_create_dev(device, pdev);
+	dev = nvme_common_create_dev(device, pdev, &nvme_pci_ops);
 	if (IS_ERR(dev)) {
 		pr_err("nvme_common_create_dev returned %ld",
 		       PTR_ERR(dev));
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index f22d8b7..7a3faab 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -586,7 +586,7 @@ static int nvme_trans_device_id_page(struct nvme_ns
*ns, struct sg_io_hdr *hdr,
 	int res;
 	int nvme_sc;
 	int xfer_len;
-	int vs = nvme_pci_get_version(dev);
+	int vs = dev->nvme_ops->get_version(dev);
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
 	memset(inq_response, 0, alloc_len);
@@ -2279,7 +2279,7 @@ static int nvme_trans_test_unit_ready(struct
nvme_ns *ns,
 {
 	struct nvme_dev *dev = ns->dev;
 
-	if (!nvme_pci_is_ready(dev))
+	if (!dev->nvme_ops->is_ready(dev))
 		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
 					    NOT_READY,
SCSI_ASC_LUN_NOT_READY,
 					   
 SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-- 
1.7.1
