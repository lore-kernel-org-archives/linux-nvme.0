From: s.chawdhary@samsung.com (Swati)
Date: Wed, 10 Dec 2014 20:13:07 +0530
Subject: [PATCH] NVMe: Asynchronous device scan
In-Reply-To: <1415204395-3136-1-git-send-email-h.vinayak@samsung.com>
References: <1415204395-3136-1-git-send-email-h.vinayak@samsung.com>
Message-ID: <01de01d01487$a66e95b0$f34bc110$@samsung.com>

Hi Keith,

Is there any feedback on this patch?
Are we going for the asynchronous add_disk approach, is somebody working on
that?

Regards,
Swati
-----Original Message-----
From: Vinayak Holikatti [mailto:h.vinayak@samsung.com] 
Sent: Wednesday, November 05, 2014 9:50 PM
To: linux-nvme at lists.infradead.org
Cc: Vinayak Holikatti; Swati C
Subject: [PATCH] NVMe: Asynchronous device scan

This patch provides asynchronous device enumeration capablity.
This patch is based on Keiths patch of Asynchronous namespace discovery
http://lists.infradead.org/pipermail/linux-nvme/2013-September/000470.html

Signed-off-by: Vinayak Holikatti <h.vinayak at samsung.com>
Signed-off-by: Swati C <s.chawdhary at samsung.com>
---
 drivers/block/nvme-core.c | 207
+++++++++++++++++++++++++++++++++++++---------
 include/linux/nvme.h      |  11 +++
 2 files changed, 181 insertions(+), 37 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index
00fa5d2..11286c0 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2336,6 +2336,85 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
+static void free_disco_event(struct nvme_discover_event *event) {
+	dma_free_coherent(&event->dev->pci_dev->dev, 8192, event->mem,
+							event->dma_addr);
+	kfree(event);
+}
+
+void nvme_discovery_work_handler(struct kthread_work *work) {
+	struct nvme_ns *ns;
+	struct nvme_discover_event *event = container_of(work,
+				struct nvme_discover_event, cmdinfo.work);
+
+	if (test_bit(NVME_NN_PROBE_STOP, &event->dev->probe_work_stop))
+		goto free;
+
+	if (!event->cmdinfo.status) {
+		struct nvme_id_ns *id_ns = event->mem;
+
+		if (!id_ns->ncap)
+			goto free;
+		memset(event->mem + 4096, 0x0, 4096);
+		ns = nvme_alloc_ns(event->dev, event->nsid, event->mem,
+							 event->mem + 4096);
+		if (ns) {
+			list_add_tail(&ns->list, &event->dev->namespaces);
+			add_disk(ns->disk);
+			event->dev->nvme_nn_probed = ns->ns_id;
+		}
+	}
+ free:
+	free_disco_event(event);
+}
+
+struct nvme_discover_event *alloc_disco_event(struct nvme_dev *dev,
+								unsigned
nsid)
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
+	init_kthread_work(&event->cmdinfo.work,
nvme_discovery_work_handler);
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
+	return nvme_submit_admin_cmd_async(dev, &c, &event->cmdinfo); }
+
 /*
  * Return: error value if an error occurred setting up the queues or
calling
  * Identify Device.  0 if these succeeded, even if adding some of the @@
-2345,24 +2424,24 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
static int nvme_dev_add(struct nvme_dev *dev)  {
 	struct pci_dev *pdev = dev->pci_dev;
+	struct nvme_discover_event *event;
 	int res;
 	unsigned nn, i;
-	struct nvme_ns *ns;
 	struct nvme_id_ctrl *ctrl;
-	struct nvme_id_ns *id_ns;
 	void *mem;
 	dma_addr_t dma_addr;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
-	mem = dma_alloc_coherent(&pdev->dev, 8192, &dma_addr, GFP_KERNEL);
+	mem = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
+								GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	res = nvme_identify(dev, 0, 1, dma_addr);
 	if (res) {
 		dev_err(&pdev->dev, "Identify Controller failed (%d)\n",
res);
-		res = -EIO;
-		goto out;
+		dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
+		return -EIO;
 	}
 
 	ctrl = mem;
@@ -2380,30 +2459,31 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			(pdev->device == 0x0953) && ctrl->vs[3])
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
 
-	id_ns = mem;
-	for (i = 1; i <= nn; i++) {
-		res = nvme_identify(dev, i, 0, dma_addr);
-		if (res)
-			continue;
+	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
 
-		if (id_ns->ncap == 0)
-			continue;
+	if (nn == dev->nvme_nn_probed)
+		return 0;
 
-		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
-							dma_addr + 4096,
NULL);
-		if (res)
-			memset(mem + 4096, 0, 4096);
 
-		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
-		if (ns)
-			list_add_tail(&ns->list, &dev->namespaces);
+	for (i = (dev->nvme_nn_probed + 1); i <= nn; i++) {
+
+		if (kthread_should_stop())
+			return -EIO;
+
+
+		event = alloc_disco_event(dev, i);
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
+	res = 0;
 	return res;
 }
 
@@ -2642,6 +2722,8 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 		}
 	} else {
 		nvme_disable_io_queues(dev);
+		flush_kthread_worker(&dev->discovery_worker);
+		kthread_stop(dev->discovery_worker_task);
 		nvme_shutdown_ctrl(dev);
 		nvme_disable_queue(dev, 0);
 	}
@@ -2811,12 +2893,23 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	}
 	nvme_init_queue(raw_nvmeq(dev, 0), 0);
 
+	init_kthread_worker(&dev->discovery_worker);
+	dev->discovery_worker_task = kthread_run(kthread_worker_fn,
+			&dev->discovery_worker, "nvme%d", dev->instance);
+	if (IS_ERR_OR_NULL(dev->discovery_worker_task)) {
+		result = PTR_ERR(dev->discovery_worker_task);
+		goto disable;
+	}
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
-		goto disable;
+		goto stop_discovery;
 
 	return result;
 
+stop_discovery:
+	flush_kthread_worker(&dev->discovery_worker);
+	kthread_stop(dev->discovery_worker_task);
  disable:
 	nvme_disable_queue(dev, 0);
 	nvme_dev_list_remove(dev);
@@ -2825,6 +2918,24 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 }
 
+static int nvme_probe_workfn(void  *data) {
+	struct nvme_dev *dev = data;
+	int result = -ENOMEM;
+
+	result = nvme_dev_add(dev);
+	if (result == -EIO) {
+		dev->nvme_probe_thread = NULL;
+		return result;
+	}
+
+	flush_kthread_worker(&dev->discovery_worker);
+	dev->initialized = 1;
+	dev->nvme_probe_thread = NULL;
+	return result;
+
+}
+
 static int nvme_remove_dead_ctrl(void *arg)  {
 	struct nvme_dev *dev = (struct nvme_dev *)arg; @@ -2857,7 +2968,16
@@ static int nvme_dev_resume(struct nvme_dev *dev)
 		queue_work(nvme_workq, &dev->reset_work);
 		spin_unlock(&dev_list_lock);
 	}
-	dev->initialized = 1;
+
+	if (dev->online_queues > 1) {
+		dev->nvme_probe_thread = kthread_run(nvme_probe_workfn,
+						     dev,
+
"nvme_namespace_probe%d",
+						     dev->instance);
+		 if (dev->nvme_probe_thread == ERR_PTR(-ENOMEM))
+			dev_err(&dev->pci_dev->dev,
+					  "Failed to invoke
nvme_probe_work");
+	}
 	return 0;
 }
 
@@ -2927,11 +3047,6 @@ static int nvme_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	if (dev->online_queues > 1)
-		result = nvme_dev_add(dev);
-	if (result)
-		goto shutdown;
-
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
@@ -2939,14 +3054,20 @@ static int nvme_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 	dev->miscdev.fops = &nvme_dev_fops;
 	result = misc_register(&dev->miscdev);
 	if (result)
-		goto remove;
+		goto shutdown;
 
-	dev->initialized = 1;
+	if (dev->online_queues > 1) {
+		dev->nvme_probe_thread = kthread_run(nvme_probe_workfn,
+						     dev,
+
"nvme_namespace_probe%d",
+						     dev->instance);
+		 if (dev->nvme_probe_thread == ERR_PTR(-ENOMEM)) {
+			dev_err(&dev->pci_dev->dev,
+					  "Failed to invoke
nvme_probe_work");
+		    goto shutdown;
+		 }
+	}
 	return 0;
-
- remove:
-	nvme_dev_remove(dev);
-	nvme_free_namespaces(dev);
  shutdown:
 	nvme_dev_shutdown(dev);
  release_pools:
@@ -2984,10 +3105,15 @@ static void nvme_remove(struct pci_dev *pdev)  {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	set_bit(NVME_NN_PROBE_STOP, &dev->probe_work_stop);
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
 
+	if (dev->nvme_probe_thread) {
+		kthread_stop(dev->nvme_probe_thread);
+		dev->nvme_probe_thread = NULL;
+	}
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->cpu_work);
@@ -3013,6 +3139,12 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	set_bit(NVME_NN_PROBE_STOP, &ndev->probe_work_stop);
+	if (ndev->nvme_probe_thread) {
+		kthread_stop(ndev->nvme_probe_thread);
+		ndev->nvme_probe_thread = NULL;
+	}
+
 	nvme_dev_shutdown(ndev);
 	return 0;
 }
@@ -3022,6 +3154,7 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	clear_bit(NVME_NN_PROBE_STOP, &ndev->probe_work_stop);
 	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
 		ndev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &ndev->reset_work); diff --git
a/include/linux/nvme.h b/include/linux/nvme.h index ed09074..130ab4a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -18,6 +18,7 @@
 #include <uapi/linux/nvme.h>
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
+#include <linux/kthread.h>
 #include <linux/kref.h>
 
 struct nvme_bar {
@@ -61,6 +62,11 @@ enum {
 	NVME_CSTS_SHST_MASK	= 3 << 2,
 };
 
+enum {
+	NVME_NN_PROBE_STOP
+
+};
+
 #define NVME_VS(major, minor)	(major << 16 | minor)
 
 extern unsigned char nvme_io_timeout;
@@ -92,6 +98,7 @@ struct nvme_dev {
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
 	struct work_struct cpu_work;
+	struct task_struct *nvme_probe_thread;
 	char name[12];
 	char serial[20];
 	char model[40];
@@ -99,11 +106,15 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u32 page_size;
+	u32 nvme_nn_probed;
 	u16 oncs;
+	struct kthread_worker discovery_worker;
+	struct task_struct *discovery_worker_task;
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
 	u8 initialized;
+	unsigned long probe_work_stop;
 };
 
 /*
--
1.8.3.2
