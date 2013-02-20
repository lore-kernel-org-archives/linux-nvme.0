From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:39 -0700
Subject: [PATCH 2/8] NVMe: Controller reset from user
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-2-git-send-email-keith.busch@intel.com>

Allow a user to issue a controller reset. A reset does not delete the
gendisks so that IO may continue, or the namespaces may be mounted. This
may be done by a user if they need to reset the controller for any reason,
like if it is required as part of an activate firmware operation.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |  155 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 0a25765..28e014e 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -111,6 +111,7 @@ struct nvme_queue {
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	wait_queue_head_t sq_full;
+	atomic_t busy;
 	u32 __iomem *q_db;
 	u16 q_depth;
 	u16 cq_vector;
@@ -265,11 +266,18 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 
 static struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-	return dev->queues[get_cpu() + 1];
+	struct nvme_queue *nvmeq;
+	spin_lock(&dev->dev_lock);
+	nvmeq = dev->queues[get_cpu() + 1];
+	if (nvmeq)
+		atomic_inc(&nvmeq->busy);
+	spin_unlock(&dev->dev_lock);
+	return nvmeq;
 }
 
 static void put_nvmeq(struct nvme_queue *nvmeq)
 {
+	atomic_dec(&nvmeq->busy);
 	put_cpu();
 }
 
@@ -629,6 +637,11 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	struct nvme_queue *nvmeq = get_nvmeq(dev);
 	int result;
 
+	if (!nvmeq) {
+		requeue_bio(dev, bio);
+		return;
+	}
+
 	spin_lock_irq(&nvmeq->q_lock);
 	result = nvme_submit_bio_queue(nvmeq, ns, bio);
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -909,10 +922,15 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 	struct nvme_queue *nvmeq = dev->queues[qid];
 	int vector = dev->entry[nvmeq->cq_vector].vector;
 
-	spin_lock_irq(&nvmeq->q_lock);
-	nvme_cancel_ios(nvmeq, false);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_lock(&dev->dev_lock);
+	dev->queues[qid] = NULL;
+	spin_unlock(&dev->dev_lock);
+
+	while (atomic_read(&nvmeq->busy))
+		msleep(10);
+
 
+	synchronize_irq(vector);
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
@@ -922,6 +940,11 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 		adapter_delete_cq(dev, qid);
 	}
 
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	nvme_cancel_ios(nvmeq, false);
+	spin_unlock_irq(&nvmeq->q_lock);
+
 	nvme_free_queue_mem(nvmeq);
 }
 
@@ -1014,7 +1037,7 @@ static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
 	return ERR_PTR(result);
 }
 
-static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result = 0;
 	u32 aqa;
@@ -1177,6 +1200,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	length = nvme_setup_prps(dev, &c.common, iod, length, GFP_KERNEL);
 
 	nvmeq = get_nvmeq(dev);
+	if (!nvmeq) {
+		status = -EFAULT;
+		goto unmap_pages;
+	}
+
 	/*
 	 * Since nvme_submit_sync_cmd sleeps, we can't keep preemption
 	 * disabled.  We may be preempted at any point, and be rescheduled
@@ -1189,6 +1217,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	else
 		status = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
 
+ unmap_pages:
 	nvme_unmap_user_pages(dev, io.opcode & 1, iod);
 	nvme_free_iod(dev, iod);
 	return status;
@@ -1419,7 +1448,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
-static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
+static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
 
@@ -1490,6 +1519,7 @@ static void nvme_free_queues(struct nvme_dev *dev)
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_free_queue(dev, i);
+	dev->queue_count = 0;
 }
 
 static int __devinit nvme_dev_add(struct nvme_dev *dev)
@@ -1630,6 +1660,108 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+static int nvme_shutdown_controller(struct nvme_dev *dev)
+{
+	int i;
+	unsigned long timeout;
+
+	spin_lock(&dev_list_lock);
+	list_del(&dev->node);
+	spin_unlock(&dev_list_lock);
+
+	spin_lock(&dev->dev_lock);
+	for (i = dev->queue_count; i < num_possible_cpus(); i++)
+		dev->queues[i] = NULL;
+	spin_unlock(&dev->dev_lock);
+	nvme_free_queues(dev);
+
+	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
+	writel(dev->ctrl_config, &dev->bar->cc);
+	timeout = HZ + jiffies;
+
+	while (!(readl(&dev->bar->csts) & NVME_CSTS_SHST_CMPLT)) {
+		msleep(5);
+		if (fatal_signal_pending(current))
+			break;
+		if (time_after(jiffies, timeout)) {
+			dev_err(&dev->pci_dev->dev,
+				"Device still ready; aborting shutdown\n");
+			break;
+		}
+	}
+
+	pci_disable_msix(dev->pci_dev);
+	iounmap(dev->bar);
+	pci_disable_device(dev->pci_dev);
+	pci_release_regions(dev->pci_dev);
+
+	return 0;
+}
+
+static int nvme_restart_controller(struct nvme_dev *dev)
+{
+	int bars, result = -ENOMEM;
+
+	if (pci_enable_device_mem(dev->pci_dev))
+		return -ENOMEM;
+
+	pci_set_master(dev->pci_dev);
+	bars = pci_select_bars(dev->pci_dev, IORESOURCE_MEM);
+	if (pci_request_selected_regions(dev->pci_dev, bars, "nvme"))
+		goto disable_pci;
+
+	dma_set_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
+	dma_set_coherent_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
+	dev->entry[0].vector = dev->pci_dev->irq;
+	dev->bar = ioremap(pci_resource_start(dev->pci_dev, 0), 8192);
+	if (!dev->bar)
+		goto disable;
+
+	result = nvme_configure_admin_queue(dev);
+	if (result)
+		goto unmap;
+	dev->queue_count++;
+
+	spin_lock(&dev_list_lock);
+	list_add(&dev->node, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto remove;
+
+	return 0;
+
+ remove:
+	nvme_dev_remove(dev);
+ unmap:
+	iounmap(dev->bar);
+ disable:
+	pci_release_regions(dev->pci_dev);
+ disable_pci:
+	pci_disable_device(dev->pci_dev);
+	return result;
+}
+
+static int nvme_reset_controller(struct nvme_dev *dev)
+{
+	int ret = nvme_shutdown_controller(dev);
+	if (ret)
+		return ret;
+	ret = nvme_restart_controller(dev);
+	return ret;
+}
+
+static ssize_t reset_controller(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct pci_dev  *pdev = container_of(dev, struct pci_dev, dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	nvme_reset_controller(ndev);
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, reset_controller);
+
 static int __devinit nvme_probe(struct pci_dev *pdev,
 						const struct pci_device_id *id)
 {
@@ -1686,13 +1818,19 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	list_add(&dev->node, &dev_list);
 	spin_unlock(&dev_list_lock);
 
-	result = nvme_dev_add(dev);
+	result = device_create_file(&pdev->dev, &dev_attr_reset_controller);
 	if (result)
 		goto delete;
 
+	result = nvme_dev_add(dev);
+	if (result)
+		goto del_sysfs;
+
 	return 0;
 
- delete:
+ del_sysfs:
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
+delete:
 	spin_lock(&dev_list_lock);
 	list_del(&dev->node);
 	spin_unlock(&dev_list_lock);
@@ -1718,6 +1856,7 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_remove(dev);
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
 	pci_disable_msix(pdev);
 	iounmap(dev->bar);
 	nvme_release_instance(dev);
-- 
1.7.0.4
