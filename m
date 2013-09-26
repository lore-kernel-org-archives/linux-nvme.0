From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Sep 2013 15:53:03 -0600
Subject: [RFC PATCH] NVMe: Asynchronous namespace discovery
Message-ID: <1380232383-18214-1-git-send-email-keith.busch@intel.com>

This is a first attempt at adding the namespaces asynchronously. I tried
to implement a generic way to submit asynchronous admin commands not
tied to namespace indentification so that it could perhaps be used in
other contexts (maybe queue creation/deletion?).

Specifically for namespace discovery, this creates a kthread_worker that
lives on after the device probe completes. The asynchronous callback
schedules new work for each completed command, and the worker goes
on to allocate the namespace and adds the disk; we can't allocate the
namespace and disk directly in the async NVMe completion hander because
we're holding locks in that ISR context.

This skips sending the LBA Range Type get feature request at the
moment. I didn't want to deal with two levels of asynchronous events
without knowing if this idea looks promising.

This might prove to be useful if an nvme device with many namespaces
is developed. I don't have one of those right now, but to compare what
happens if I did, I changed the firmware in my device to return 2M
namespaces (identify namespace for anything but NSID 1 would return
a blank page). Here are the results for how long it takes to load
the module:

Current sync method:

# time insmod ./drivers/block/nvme.ko 
real	4m41.787s
user	0m0.000s
sys	0m38.430s

Async discovery 1M namespaces:

# time insmod drivers/block/nvme.ko 
real	0m18.109s
user	0m0.000s
sys	0m18.090s

For fun, I wanted to see what would happen if we up the admin queue
depth from 64 to 256. Turns out, not a whole lot:

# time insmod drivers/block/nvme.ko 
real	0m15.967s
user	0m0.000s
sys	0m15.420s

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  169 +++++++++++++++++++++++++++++++++++++--------
 include/linux/nvme.h      |    3 +
 2 files changed, 144 insertions(+), 28 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..d35c6fb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -843,6 +843,22 @@ struct sync_cmd_info {
 	int status;
 };
 
+struct async_cmd_info {
+	struct kthread_work work;
+	struct kthread_worker *worker;
+	u32 result;
+	int status;
+};
+
+static void async_completion(struct nvme_dev *dev, void *ctx,
+						struct nvme_completion *cqe)
+{
+	struct async_cmd_info *cmdinfo = ctx;
+	cmdinfo->result = le32_to_cpup(&cqe->result);
+	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
+}
+
 static void sync_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -886,12 +902,32 @@ int nvme_submit_sync_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 	return cmdinfo.status;
 }
 
+int nvme_submit_async_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
+						struct async_cmd_info *cmdinfo,
+						unsigned timeout)
+{
+	int cmdid = alloc_cmdid_killable(nvmeq, cmdinfo, async_completion,
+								timeout);
+	if (cmdid < 0)
+		return cmdid;
+	cmd->common.command_id = cmdid;
+	nvme_submit_cmd(nvmeq, cmd);
+
+	return 0;
+}
+
 int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 								u32 *result)
 {
 	return nvme_submit_sync_cmd(dev->queues[0], cmd, result, ADMIN_TIMEOUT);
 }
 
+int nvme_submit_admin_cmd_async(struct nvme_dev *dev, struct nvme_command *cmd,
+						struct async_cmd_info *cmdinfo)
+{
+	return nvme_submit_async_cmd(dev->queues[0], cmd, cmdinfo, ADMIN_TIMEOUT);
+}
+
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	int status;
@@ -1868,6 +1904,81 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
+struct nvme_discover_event {
+	struct async_cmd_info cmdinfo;
+	struct nvme_dev *dev;
+	unsigned nsid;
+	void *mem;
+	dma_addr_t dma_addr;
+};
+
+static void free_disco_event(struct nvme_discover_event *event)
+{
+	dma_free_coherent(&event->dev->pci_dev->dev, 8192, event->mem,
+							event->dma_addr);
+	kfree(event);
+}
+
+void nvme_discovery_work_handler(struct kthread_work *work)
+{
+	struct nvme_ns *ns;
+	struct nvme_discover_event *event = container_of(work,
+				struct nvme_discover_event, cmdinfo.work);
+
+	if (!event->cmdinfo.status) {
+		struct nvme_id_ns *id_ns = event->mem;
+
+		if (!id_ns->ncap)
+			goto free;
+		memset(event->mem + 4096, 0x0, 4096);
+		ns = nvme_alloc_ns(event->dev, event->nsid, event->mem,
+								event->mem + 4096);
+		if (ns) {
+			list_add_tail(&ns->list, &event->dev->namespaces);
+			add_disk(ns->disk);
+		}
+	}
+ free:
+	free_disco_event(event);
+}
+
+struct nvme_discover_event *alloc_disco_event(struct nvme_dev *dev,
+								unsigned nsid)
+{
+	struct nvme_discover_event *event;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		return NULL;
+
+	event->mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192,
+				&event->dma_addr, GFP_KERNEL);
+	if (!event->mem) {
+		kfree(event);
+		return NULL;
+	}
+	event->dev = dev;
+	event->nsid = nsid;
+	event->cmdinfo.worker = &dev->discovery_worker;
+	init_kthread_work(&event->cmdinfo.work, nvme_discovery_work_handler);
+
+	return event;
+}
+
+static int nvme_identify_async(struct nvme_dev *dev,
+				struct nvme_discover_event *event)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(event->nsid);
+	c.identify.prp1 = cpu_to_le64(event->dma_addr);
+	c.identify.cns = cpu_to_le32(0);
+
+	return nvme_submit_admin_cmd_async(dev, &c, &event->cmdinfo);
+}
+
 /*
  * Return: error value if an error occurred setting up the queues or calling
  * Identify Device.  0 if these succeeded, even if adding some of the
@@ -1876,24 +1987,21 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
-	int res;
 	unsigned nn, i;
-	struct nvme_ns *ns;
 	struct nvme_id_ctrl *ctrl;
-	struct nvme_id_ns *id_ns;
 	void *mem;
 	dma_addr_t dma_addr;
-	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+	int res, shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192, &dma_addr,
+	mem = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
 								GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	res = nvme_identify(dev, 0, 1, dma_addr);
 	if (res) {
-		res = -EIO;
-		goto out;
+		dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
+		return -EIO;
 	}
 
 	ctrl = mem;
@@ -1907,31 +2015,22 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if ((dev->pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
 			(dev->pci_dev->device == 0x0953) && ctrl->vs[3])
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
+	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
 
-	id_ns = mem;
 	for (i = 1; i <= nn; i++) {
-		res = nvme_identify(dev, i, 0, dma_addr);
-		if (res)
-			continue;
+		struct nvme_discover_event *event = alloc_disco_event(dev, i);
 
-		if (id_ns->ncap == 0)
-			continue;
-
-		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
-							dma_addr + 4096, NULL);
-		if (res)
-			memset(mem + 4096, 0, 4096);
-
-		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
-		if (ns)
-			list_add_tail(&ns->list, &dev->namespaces);
+		if (!event) {
+			res = -ENOMEM;
+			break;
+		}
+		res = nvme_identify_async(dev, event);
+		if (res) {
+			free_disco_event(event);
+			break;
+		}
 	}
-	list_for_each_entry(ns, &dev->namespaces, list)
-		add_disk(ns->disk);
-	res = 0;
 
- out:
-	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
 	return res;
 }
 
@@ -1997,6 +2096,9 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_disable_queue(dev, i);
 
+	flush_kthread_worker(&dev->discovery_worker);
+	kthread_stop(dev->discovery_worker_task);
+
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
@@ -2134,12 +2236,23 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	list_add(&dev->node, &dev_list);
 	spin_unlock(&dev_list_lock);
 
+	init_kthread_worker(&dev->discovery_worker);
+	dev->discovery_worker_task = kthread_run(kthread_worker_fn,
+			&dev->discovery_worker, "nvme%d", dev->instance);
+	if (IS_ERR_OR_NULL(dev->discovery_worker_task)) {
+		result = PTR_ERR(dev->discovery_worker_task);
+		goto disable;
+	}
+
 	result = nvme_setup_io_queues(dev);
 	if (result && result != -EBUSY)
-		goto disable;
+		goto stop_discovery;
 
 	return result;
 
+ stop_discovery:
+	flush_kthread_worker(&dev->discovery_worker);
+	kthread_stop(dev->discovery_worker_task);
  disable:
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26ebcf4..6384c44 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -22,6 +22,7 @@
 #include <uapi/linux/nvme.h>
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
+#include <linux/kthread.h>
 #include <linux/kref.h>
 
 struct nvme_bar {
@@ -94,6 +95,8 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	struct kthread_worker discovery_worker;
+	struct task_struct *discovery_worker_task;
 };
 
 /*
-- 
1.7.0.4
