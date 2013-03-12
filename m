From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Mar 2013 15:32:42 -0600
Subject: [PATCH v2] NVMe: Suspend/resume
Message-ID: <1363123962-11530-1-git-send-email-keith.busch@intel.com>

Adds suspend and resume power management callbacks. On suspend, the
controller is disabled, IO queues are flagged as suspended, and all new
IO requests are queued for later submission. The resume, the same queues
are recreated after clearing any potential command id's that may have
slipped through while the controller was being disabled, and the queues
are free to continue IO. The device is removed if on error or for any
reason we can't create the same queues as previously existed.

Some of the initialization steps are moved into their own functions in
this patch to avoid duplication between suspend/resume and remove/probe.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |  325 +++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 243 insertions(+), 82 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 993c014..dfd729f 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -111,6 +111,7 @@ struct nvme_queue {
 	wait_queue_head_t sq_full;
 	wait_queue_t sq_cong_wait;
 	struct bio_list sq_cong;
+	bool q_suspended;
 	u32 __iomem *q_db;
 	u16 q_depth;
 	u16 cq_vector;
@@ -628,7 +629,7 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	int result = -EBUSY;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (bio_list_empty(&nvmeq->sq_cong))
+	if (!nvmeq->q_suspended && bio_list_empty(&nvmeq->sq_cong))
 		result = nvme_submit_bio_queue(nvmeq, ns, bio);
 	if (unlikely(result)) {
 		if (bio_list_empty(&nvmeq->sq_cong))
@@ -930,6 +931,16 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 	nvme_free_queue_mem(nvmeq);
 }
 
+static void nvme_init_queue(struct nvme_queue *nvmeq, int qid)
+{
+	struct nvme_dev *dev = nvmeq->dev;
+	nvmeq->sq_tail = 0;
+	nvmeq->cq_head = 0;
+	nvmeq->cq_phase = 1;
+	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
+	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+}
+
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth, int vector)
 {
@@ -944,7 +955,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 					&nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
-	memset((void *)nvmeq->cqes, 0, CQ_SIZE(depth));
 
 	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr, GFP_KERNEL);
@@ -954,14 +964,12 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_dmadev = dmadev;
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->q_lock);
-	nvmeq->cq_head = 0;
-	nvmeq->cq_phase = 1;
 	init_waitqueue_head(&nvmeq->sq_full);
 	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
-	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
+	nvme_init_queue(nvmeq, qid);
 
 	return nvmeq;
 
@@ -985,18 +993,14 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
 }
 
-static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
-					int qid, int cq_size, int vector)
+static int nvme_adapter_alloc_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	int result;
-	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector);
-
-	if (!nvmeq)
-		return ERR_PTR(-ENOMEM);
+	struct nvme_dev *dev = nvmeq->dev;
 
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-		goto free_nvmeq;
+		return result;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
@@ -1006,12 +1010,30 @@ static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
 	if (result < 0)
 		goto release_sq;
 
-	return nvmeq;
+	return result;
 
  release_sq:
 	adapter_delete_sq(dev, qid);
  release_cq:
 	adapter_delete_cq(dev, qid);
+	return result;
+}
+
+static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
+					int qid, int cq_size, int vector)
+{
+	int result;
+	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector);
+
+	if (!nvmeq)
+		return ERR_PTR(-ENOMEM);
+
+	result = nvme_adapter_alloc_queue(nvmeq, qid);
+	if (result < 0)
+		goto free_nvmeq;
+
+	return nvmeq;
+
  free_nvmeq:
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
@@ -1021,19 +1043,34 @@ static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
 	return ERR_PTR(result);
 }
 
-static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_dev_disable(struct nvme_dev *dev)
+{
+	u64 cap = readq(&dev->bar->cap);
+	unsigned long timeout;
+	
+	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+	writel(0, &dev->bar->cc);
+	while (readl(&dev->bar->csts) & NVME_CSTS_RDY) {
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(&dev->pci_dev->dev,
+				"Device still ready; abort initialisation\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static int __devinit nvme_configure_admin_queue(struct nvme_queue *nvmeq)
 {
 	int result = 0;
 	u32 aqa;
 	u64 cap;
 	unsigned long timeout;
-	struct nvme_queue *nvmeq;
-
-	dev->dbs = ((void __iomem *)dev->bar) + 4096;
-
-	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
-	if (!nvmeq)
-		return -ENOMEM;
+	struct nvme_dev *dev = nvmeq->dev;
 
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
@@ -1043,7 +1080,10 @@ static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
-	writel(0, &dev->bar->cc);
+	result = nvme_dev_disable(dev);
+	if (result)
+		return result;
+
 	writel(aqa, &dev->bar->aqa);
 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
@@ -1053,24 +1093,18 @@ static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
 	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
 	dev->db_stride = NVME_CAP_STRIDE(cap);
 
-	while (!result && !(readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
+	while (!(readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
 		msleep(100);
 		if (fatal_signal_pending(current))
-			result = -EINTR;
+			return -EINTR;
 		if (time_after(jiffies, timeout)) {
 			dev_err(&dev->pci_dev->dev,
 				"Device not ready; aborting initialisation\n");
-			result = -ENODEV;
+			return -ENODEV;
 		}
 	}
 
-	if (result) {
-		nvme_free_queue_mem(nvmeq);
-		return result;
-	}
-
 	result = queue_request_irq(dev, nvmeq, "nvme admin");
-	dev->queues[0] = nvmeq;
 	return result;
 }
 
@@ -1303,7 +1337,7 @@ static int nvme_kthread(void *data)
 			int i;
 			for (i = 0; i < dev->queue_count; i++) {
 				struct nvme_queue *nvmeq = dev->queues[i];
-				if (!nvmeq)
+				if (!nvmeq || nvmeq->q_suspended)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
 				if (nvme_process_cq(nvmeq))
@@ -1423,6 +1457,28 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
+static int nvme_enable_msix(struct nvme_dev *dev, int nr_io_queues)
+{
+	int i, result;
+	for (i = 0; i < nr_io_queues; i++)
+		dev->entry[i].entry = i;
+	for (;;) {
+		result = pci_enable_msix(dev->pci_dev, dev->entry,
+								nr_io_queues);
+		if (result == 0) {
+			break;
+		} else if (result > 0) {
+			nr_io_queues = result;
+			continue;
+		} else {
+			nr_io_queues = 1;
+			break;
+		}
+	}
+
+	return nr_io_queues;
+}
+
 static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
@@ -1446,22 +1502,7 @@ static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 		dev->queues[0]->q_db = dev->dbs;
 	}
 
-	for (i = 0; i < nr_io_queues; i++)
-		dev->entry[i].entry = i;
-	for (;;) {
-		result = pci_enable_msix(dev->pci_dev, dev->entry,
-								nr_io_queues);
-		if (result == 0) {
-			break;
-		} else if (result > 0) {
-			nr_io_queues = result;
-			continue;
-		} else {
-			nr_io_queues = 1;
-			break;
-		}
-	}
-
+	nr_io_queues = nvme_enable_msix(dev, nr_io_queues);
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	/* XXX: handle failure here */
 
@@ -1634,10 +1675,49 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_dev_unmap(struct nvme_dev *dev)
+{
+	pci_disable_msix(dev->pci_dev);
+	iounmap(dev->bar);
+	pci_disable_device(dev->pci_dev);
+	pci_release_regions(dev->pci_dev);
+}
+
+static int nvme_dev_map(struct nvme_dev *dev)
+{
+	int bars, db_bar_size, result = -ENOMEM;
+	if (pci_enable_device_mem(dev->pci_dev))
+		return result;
+
+	pci_set_master(dev->pci_dev);
+	bars = pci_select_bars(dev->pci_dev, IORESOURCE_MEM);
+	if (pci_request_selected_regions(dev->pci_dev, bars, "nvme"))
+		goto disable_pci;
+
+	dma_set_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
+	dma_set_coherent_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
+	dev->entry[0].vector = dev->pci_dev->irq;
+	pci_set_drvdata(dev->pci_dev, dev);
+
+	db_bar_size = max(8192, 4096 + ((dev->queue_count) << (dev->db_stride + 3)));
+	dev->bar = ioremap(pci_resource_start(dev->pci_dev, 0), db_bar_size);
+	if (!dev->bar)
+		goto disable;
+
+	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+	return 0;
+
+ disable:
+	pci_release_regions(dev->pci_dev);
+ disable_pci:
+	pci_disable_device(dev->pci_dev);
+	return result;
+}
+
 static int __devinit nvme_probe(struct pci_dev *pdev,
 						const struct pci_device_id *id)
 {
-	int bars, result = -ENOMEM;
+	int result = -ENOMEM;
 	struct nvme_dev *dev;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1652,37 +1732,29 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	if (!dev->queues)
 		goto free;
 
-	if (pci_enable_device_mem(pdev))
-		goto free;
-	pci_set_master(pdev);
-	bars = pci_select_bars(pdev, IORESOURCE_MEM);
-	if (pci_request_selected_regions(pdev, bars, "nvme"))
-		goto disable;
-
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->pci_dev = pdev;
-	pci_set_drvdata(pdev, dev);
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 	result = nvme_set_instance(dev);
 	if (result)
-		goto disable;
-
-	dev->entry[0].vector = pdev->irq;
+		goto free;
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-		goto disable_msix;
+		goto release;
+
+	result = nvme_dev_map(dev);
+	if (result)
+		goto release_pools;
 
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar) {
+	dev->queues[0] = nvme_alloc_queue(dev, 0, 64, 0);
+	if (!dev->queues[0]) {
 		result = -ENOMEM;
-		goto disable_msix;
+		goto unmap;
 	}
 
-	result = nvme_configure_admin_queue(dev);
+	result = nvme_configure_admin_queue(dev->queues[0]);
 	if (result)
-		goto unmap;
+		goto del_queue;
 	dev->queue_count++;
 
 	spin_lock(&dev_list_lock);
@@ -1699,17 +1771,14 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 	spin_lock(&dev_list_lock);
 	list_del(&dev->node);
 	spin_unlock(&dev_list_lock);
-
+ del_queue:
 	nvme_free_queues(dev);
  unmap:
-	iounmap(dev->bar);
- disable_msix:
-	pci_disable_msix(pdev);
-	nvme_release_instance(dev);
+ 	nvme_dev_unmap(dev);
+ release_pools:
 	nvme_release_prp_pools(dev);
- disable:
-	pci_disable_device(pdev);
-	pci_release_regions(pdev);
+ release:
+	nvme_release_instance(dev);
  free:
 	kfree(dev->queues);
 	kfree(dev->entry);
@@ -1721,25 +1790,116 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_remove(dev);
-	pci_disable_msix(pdev);
-	iounmap(dev->bar);
+	nvme_dev_unmap(dev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
-	pci_disable_device(pdev);
-	pci_release_regions(pdev);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
 }
 
+static int nvme_dev_suspend(struct nvme_dev *dev)
+{
+	int i;
+
+	spin_lock(&dev_list_lock);
+	list_del(&dev->node);
+	spin_unlock(&dev_list_lock);
+
+	nvme_dev_disable(dev);
+	for (i = dev->queue_count - 1; i >= 0; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+		int vector = dev->entry[nvmeq->cq_vector].vector;
+
+		nvmeq->q_suspended = true;
+		synchronize_irq(vector);
+ 		irq_set_affinity_hint(vector, NULL);
+ 		free_irq(vector, nvmeq);
+
+		spin_lock_irq(&nvmeq->q_lock);
+		nvme_process_cq(nvmeq);
+		nvme_cancel_ios(nvmeq, false);
+		spin_unlock_irq(&nvmeq->q_lock);
+	}
+
+	nvme_dev_unmap(dev);
+	return 0;
+}
+
+static int nvme_dev_resume(struct nvme_dev *dev)
+{
+	int i, result, nr_io_queues = dev->queue_count - 1;
+
+	result = nvme_dev_map(dev);
+	if (result)
+		return result;
+
+	spin_lock(&dev_list_lock);
+	list_add(&dev->node, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	result = -ENODEV;
+	if (nvme_enable_msix(dev, nr_io_queues) != nr_io_queues)
+		goto remove;
+
+	for (i = 0; i < dev->queue_count; i++) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+		int depth = nvmeq->q_depth - 1;
+		unsigned extra = DIV_ROUND_UP(depth, 8) + (depth *
+					sizeof(struct nvme_cmd_info));
+
+		/* clear commands sent prior to the controller re-enabling */
+		spin_lock_irq(&nvmeq->q_lock);
+		nvme_cancel_ios(nvmeq, false);
+		memset (nvmeq->cmdid_data, 0, extra);
+		spin_unlock_irq(&nvmeq->q_lock);
+
+		nvme_init_queue(nvmeq, i);
+		if (!i)
+			result = nvme_configure_admin_queue(nvmeq);
+		else
+			result = nvme_adapter_alloc_queue(nvmeq, i);
+
+		if (result)
+			goto remove;
+		nvmeq->q_suspended = false;
+	}
+
+	return 0;
+
+ remove:
+	nvme_dev_remove(dev);
+	nvme_dev_unmap(dev);
+	return result;
+}
+
 /* These functions are yet to be implemented */
 #define nvme_error_detected NULL
 #define nvme_dump_registers NULL
 #define nvme_link_reset NULL
 #define nvme_slot_reset NULL
 #define nvme_error_resume NULL
+
+#ifdef CONFIG_PM
+static int nvme_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	return nvme_dev_suspend(ndev);
+}
+
+static int nvme_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	return nvme_dev_resume(ndev);
+}
+#else
 #define nvme_suspend NULL
 #define nvme_resume NULL
+#endif
+
+UNIVERSAL_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume, NULL);
 
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
@@ -1763,8 +1923,9 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= __devexit_p(nvme_remove),
-	.suspend	= nvme_suspend,
-	.resume		= nvme_resume,
+	.driver 	= {
+		.pm  	= &nvme_dev_pm_ops,
+	},
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
1.7.0.4
