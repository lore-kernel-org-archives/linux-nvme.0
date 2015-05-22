From: hch@lst.de (Christoph Hellwig)
Date: Fri, 22 May 2015 11:12:39 +0200
Subject: [PATCH 2/9] nvme: store a struct device pointer in struct nvme_dev
In-Reply-To: <1432285966-31770-1-git-send-email-hch@lst.de>
References: <1432285966-31770-1-git-send-email-hch@lst.de>
Message-ID: <1432285966-31770-3-git-send-email-hch@lst.de>

Most users want the generic device, so store that in struct nvme_dev
instead of the pci_dev.  This also happens to be a nice step towards
making some code reusable for non-PCI transports.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 110 ++++++++++++++++++++++------------------------
 drivers/block/nvme-scsi.c |  63 +++++++++++---------------
 include/linux/nvme.h      |   2 +-
 3 files changed, 79 insertions(+), 96 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e81b205..870a926 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -610,17 +610,17 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 		req->errors = 0;
 
 	if (cmd_rq->aborted)
-		dev_warn(&nvmeq->dev->pci_dev->dev,
+		dev_warn(nvmeq->dev->dev,
 			"completing aborted command with status:%04x\n",
 			status);
 
 	if (iod->nents) {
-		dma_unmap_sg(&nvmeq->dev->pci_dev->dev, iod->sg, iod->nents,
+		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
 			rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		if (blk_integrity_rq(req)) {
 			if (!rq_data_dir(req))
 				nvme_dif_remap(req, nvme_dif_complete);
-			dma_unmap_sg(&nvmeq->dev->pci_dev->dev, iod->meta_sg, 1,
+			dma_unmap_sg(nvmeq->dev->dev, iod->meta_sg, 1,
 				rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		}
 	}
@@ -861,7 +861,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 		if (blk_rq_bytes(req) !=
                     nvme_setup_prps(nvmeq->dev, iod, blk_rq_bytes(req), GFP_ATOMIC)) {
-			dma_unmap_sg(&nvmeq->dev->pci_dev->dev, iod->sg,
+			dma_unmap_sg(nvmeq->dev->dev, iod->sg,
 					iod->nents, dma_dir);
 			goto retry_cmd;
 		}
@@ -1192,8 +1192,7 @@ static void nvme_abort_req(struct request *req)
 		if (work_busy(&dev->reset_work))
 			goto out;
 		list_del_init(&dev->node);
-		dev_warn(&dev->pci_dev->dev,
-			"I/O %d QID %d timeout, reset controller\n",
+		dev_warn(dev->dev, "I/O %d QID %d timeout, reset controller\n",
 							req->tag, nvmeq->qid);
 		dev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &dev->reset_work);
@@ -1362,22 +1361,21 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth)
 {
-	struct device *dmadev = &dev->pci_dev->dev;
 	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
 	if (!nvmeq)
 		return NULL;
 
-	nvmeq->cqes = dma_zalloc_coherent(dmadev, CQ_SIZE(depth),
+	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
 					  &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		goto free_cqdma;
 
-	nvmeq->q_dmadev = dmadev;
+	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
 	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
 			dev->instance, qid);
@@ -1393,7 +1391,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	return nvmeq;
 
  free_cqdma:
-	dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
+	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq->cqes,
 							nvmeq->cq_dma_addr);
  free_nvmeq:
 	kfree(nvmeq);
@@ -1465,7 +1463,7 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
-			dev_err(&dev->pci_dev->dev,
+			dev_err(dev->dev,
 				"Device not ready; aborting %s\n", enabled ?
 						"initialisation" : "reset");
 			return -ENODEV;
@@ -1515,7 +1513,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
-			dev_err(&dev->pci_dev->dev,
+			dev_err(dev->dev,
 				"Device shutdown incomplete; abort shutdown\n");
 			return -ENODEV;
 		}
@@ -1558,7 +1556,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
 		dev->admin_tagset.reserved_tags = 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
-		dev->admin_tagset.numa_node = dev_to_node(&dev->pci_dev->dev);
+		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
 		dev->admin_tagset.driver_data = dev;
 
@@ -1591,14 +1589,14 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
 
 	if (page_shift < dev_page_min) {
-		dev_err(&dev->pci_dev->dev,
+		dev_err(dev->dev,
 				"Minimum device page size (%u) too large for "
 				"host (%u)\n", 1 << dev_page_min,
 				1 << page_shift);
 		return -ENODEV;
 	}
 	if (page_shift > dev_page_max) {
-		dev_info(&dev->pci_dev->dev,
+		dev_info(dev->dev,
 				"Device maximum page size (%u) smaller than "
 				"host (%u); enabling work-around\n",
 				1 << dev_page_max, 1 << page_shift);
@@ -1689,7 +1687,7 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 	sg_mark_end(&sg[i - 1]);
 	iod->nents = count;
 
-	nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
+	nents = dma_map_sg(dev->dev, sg, count,
 				write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	if (!nents)
 		goto free_iod;
@@ -1711,7 +1709,7 @@ void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
 {
 	int i;
 
-	dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
+	dma_unmap_sg(dev->dev, iod->sg, iod->nents,
 				write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 	for (i = 0; i < iod->nents; i++)
@@ -1762,7 +1760,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		goto unmap;
 	}
 	if (meta_len) {
-		meta = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
+		meta = dma_alloc_coherent(dev->dev, meta_len,
 						&meta_dma, GFP_KERNEL);
 		if (!meta) {
 			status = -ENOMEM;
@@ -1801,7 +1799,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 								meta_len))
 				status = -EFAULT;
 		}
-		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta, meta_dma);
+		dma_free_coherent(dev->dev, meta_len, meta, meta_dma);
 	}
 	return status;
 }
@@ -1961,15 +1959,13 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	u16 old_ms;
 	unsigned short bs;
 
-	id = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
-								GFP_KERNEL);
+	id = dma_alloc_coherent(dev->dev, 4096, &dma_addr, GFP_KERNEL);
 	if (!id) {
-		dev_warn(&dev->pci_dev->dev, "%s: Memory alocation failure\n",
-								__func__);
+		dev_warn(dev->dev, "%s: Memory alocation failure\n", __func__);
 		return 0;
 	}
 	if (nvme_identify(dev, ns->ns_id, 0, dma_addr)) {
-		dev_warn(&dev->pci_dev->dev,
+		dev_warn(dev->dev,
 			"identify failed ns:%d, setting capacity to 0\n",
 			ns->ns_id);
 		memset(id, 0, sizeof(*id));
@@ -2014,7 +2010,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 
-	dma_free_coherent(&dev->pci_dev->dev, 4096, id, dma_addr);
+	dma_free_coherent(dev->dev, 4096, id, dma_addr);
 	return 0;
 }
 
@@ -2041,7 +2037,7 @@ static int nvme_kthread(void *data)
 				if (work_busy(&dev->reset_work))
 					continue;
 				list_del_init(&dev->node);
-				dev_warn(&dev->pci_dev->dev,
+				dev_warn(dev->dev,
 					"Failed status: %x, reset controller\n",
 					readl(&dev->bar->csts));
 				dev->reset_workfn = nvme_reset_failed_dev;
@@ -2073,7 +2069,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
-	int node = dev_to_node(&dev->pci_dev->dev);
+	int node = dev_to_node(dev->dev);
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -2156,8 +2152,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	if (status < 0)
 		return status;
 	if (status > 0) {
-		dev_err(&dev->pci_dev->dev, "Could not set queue count (%d)\n",
-									status);
+		dev_err(dev->dev, "Could not set queue count (%d)\n", status);
 		return 0;
 	}
 	return min(result & 0xffff, result >> 16) + 1;
@@ -2171,7 +2166,7 @@ static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
-	struct pci_dev *pdev = dev->pci_dev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, i, vecs, nr_io_queues, size;
 
 	nr_io_queues = num_possible_cpus();
@@ -2251,7 +2246,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
-	struct pci_dev *pdev = dev->pci_dev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int res;
 	unsigned nn, i;
 	struct nvme_id_ctrl *ctrl;
@@ -2259,14 +2254,14 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dma_addr_t dma_addr;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
-	mem = dma_alloc_coherent(&pdev->dev, 4096, &dma_addr, GFP_KERNEL);
+	mem = dma_alloc_coherent(dev->dev, 4096, &dma_addr, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	res = nvme_identify(dev, 0, 1, dma_addr);
 	if (res) {
-		dev_err(&pdev->dev, "Identify Controller failed (%d)\n", res);
-		dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
+		dev_err(dev->dev, "Identify Controller failed (%d)\n", res);
+		dma_free_coherent(dev->dev, 4096, mem, dma_addr);
 		return -EIO;
 	}
 
@@ -2292,12 +2287,12 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		} else
 			dev->max_hw_sectors = max_hw_sectors;
 	}
-	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
+	dma_free_coherent(dev->dev, 4096, mem, dma_addr);
 
 	dev->tagset.ops = &nvme_mq_ops;
 	dev->tagset.nr_hw_queues = dev->online_queues - 1;
 	dev->tagset.timeout = NVME_IO_TIMEOUT;
-	dev->tagset.numa_node = dev_to_node(&dev->pci_dev->dev);
+	dev->tagset.numa_node = dev_to_node(dev->dev);
 	dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
 	dev->tagset.cmd_size = nvme_cmd_size(dev);
@@ -2317,7 +2312,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 {
 	u64 cap;
 	int bars, result = -ENOMEM;
-	struct pci_dev *pdev = dev->pci_dev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (pci_enable_device_mem(pdev))
 		return result;
@@ -2331,8 +2326,8 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (pci_request_selected_regions(pdev, bars, "nvme"))
 		goto disable_pci;
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
 		goto disable;
 
 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
@@ -2373,19 +2368,21 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
-	if (dev->pci_dev->msi_enabled)
-		pci_disable_msi(dev->pci_dev);
-	else if (dev->pci_dev->msix_enabled)
-		pci_disable_msix(dev->pci_dev);
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (pdev->msi_enabled)
+		pci_disable_msi(pdev);
+	else if (pdev->msix_enabled)
+		pci_disable_msix(pdev);
 
 	if (dev->bar) {
 		iounmap(dev->bar);
 		dev->bar = NULL;
-		pci_release_regions(dev->pci_dev);
+		pci_release_regions(pdev);
 	}
 
-	if (pci_is_enabled(dev->pci_dev))
-		pci_disable_device(dev->pci_dev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
 }
 
 struct nvme_delq_ctx {
@@ -2504,7 +2501,7 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 					&worker, "nvme%d", dev->instance);
 
 	if (IS_ERR(kworker_task)) {
-		dev_err(&dev->pci_dev->dev,
+		dev_err(dev->dev,
 			"Failed to create queue del task\n");
 		for (i = dev->queue_count - 1; i > 0; i--)
 			nvme_disable_queue(dev, i);
@@ -2622,14 +2619,13 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
-	struct device *dmadev = &dev->pci_dev->dev;
-	dev->prp_page_pool = dma_pool_create("prp list page", dmadev,
+	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
 						PAGE_SIZE, PAGE_SIZE, 0);
 	if (!dev->prp_page_pool)
 		return -ENOMEM;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dmadev,
+	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
 						256, 256, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
@@ -2693,7 +2689,7 @@ static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
-	pci_dev_put(dev->pci_dev);
+	put_device(dev->dev);
 	put_device(dev->device);
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
@@ -2837,7 +2833,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 static int nvme_remove_dead_ctrl(void *arg)
 {
 	struct nvme_dev *dev = (struct nvme_dev *)arg;
-	struct pci_dev *pdev = dev->pci_dev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (pci_get_drvdata(pdev))
 		pci_stop_and_remove_bus_device_locked(pdev);
@@ -2876,11 +2872,11 @@ static void nvme_dev_reset(struct nvme_dev *dev)
 {
 	nvme_dev_shutdown(dev);
 	if (nvme_dev_resume(dev)) {
-		dev_warn(&dev->pci_dev->dev, "Device failed to resume\n");
+		dev_warn(dev->dev, "Device failed to resume\n");
 		kref_get(&dev->kref);
 		if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
 							dev->instance))) {
-			dev_err(&dev->pci_dev->dev,
+			dev_err(dev->dev,
 				"Failed to start controller remove task\n");
 			kref_put(&dev->kref, nvme_free_dev);
 		}
@@ -2924,7 +2920,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->reset_workfn = nvme_reset_failed_dev;
 	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
-	dev->pci_dev = pci_dev_get(pdev);
+	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
 	if (result)
@@ -2954,7 +2950,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  release:
 	nvme_release_instance(dev);
  put_pci:
-	pci_dev_put(dev->pci_dev);
+	put_device(dev->dev);
  free:
 	kfree(dev->queues);
 	kfree(dev->entry);
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index ba1809f..f1c90f2 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -684,7 +684,7 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	u8 cmdque = 0x01 << 1;
 	u8 fw_offset = sizeof(dev->firmware_rev);
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 				&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -728,8 +728,7 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 
  out_free:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
  out_dma:
 	return res;
 }
@@ -787,7 +786,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int xfer_len;
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -842,7 +841,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		inq_response[6] = 0x00;    /* Rsvd */
 		inq_response[7] = 0x44;    /* Designator Length */
 
-		sprintf(&inq_response[8], "%04x", dev->pci_dev->vendor);
+		sprintf(&inq_response[8], "%04x", to_pci_dev(dev->dev)->vendor);
 		memcpy(&inq_response[12], dev->model, sizeof(dev->model));
 		sprintf(&inq_response[52], "%04x", tmp_id);
 		memcpy(&inq_response[56], dev->serial, sizeof(dev->serial));
@@ -851,8 +850,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 
  out_free:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
  out_dma:
 	return res;
 }
@@ -883,7 +881,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out_mem;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -933,8 +931,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 
  out_free:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
  out_dma:
 	kfree(inq_response);
  out_mem:
@@ -1038,8 +1035,7 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 		goto out_mem;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev,
-					sizeof(struct nvme_smart_log),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_smart_log),
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1077,7 +1073,7 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 	xfer_len = min(alloc_len, LOG_INFO_EXCP_PAGE_LENGTH);
 	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
 
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_smart_log),
+	dma_free_coherent(dev->dev, sizeof(struct nvme_smart_log),
 			  mem, dma_addr);
  out_dma:
 	kfree(log_response);
@@ -1106,8 +1102,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out_mem;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev,
-					sizeof(struct nvme_smart_log),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_smart_log),
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1158,7 +1153,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	xfer_len = min(alloc_len, LOG_TEMP_PAGE_LENGTH);
 	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
 
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_smart_log),
+	dma_free_coherent(dev->dev, sizeof(struct nvme_smart_log),
 			  mem, dma_addr);
  out_dma:
 	kfree(log_response);
@@ -1209,7 +1204,7 @@ static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	else if (llbaa > 0 && len < MODE_PAGE_LLBAA_BLK_DES_LEN)
 		return SNTI_INTERNAL_ERROR;
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1246,8 +1241,7 @@ static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 
  out_dma:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
  out:
 	return res;
 }
@@ -1494,8 +1488,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	unsigned ps_desired = 0;
 
 	/* NVMe Controller Identify */
-	mem = dma_alloc_coherent(&dev->pci_dev->dev,
-				sizeof(struct nvme_id_ctrl),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ctrl),
 				&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1556,8 +1549,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (nvme_sc)
 		res = nvme_sc;
  out_dma:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ctrl), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ctrl), mem, dma_addr);
  out:
 	return res;
 }
@@ -1820,7 +1812,7 @@ static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
 	 */
 
 	if (ns->mode_select_num_blocks == 0 || ns->mode_select_block_len == 0) {
-		mem = dma_alloc_coherent(&dev->pci_dev->dev,
+		mem = dma_alloc_coherent(dev->dev,
 			sizeof(struct nvme_id_ns), &dma_addr, GFP_KERNEL);
 		if (mem == NULL) {
 			res = -ENOMEM;
@@ -1845,7 +1837,7 @@ static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
 						(1 << (id_ns->lbaf[flbas].ds));
 		}
  out_dma:
-		dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+		dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns),
 				  mem, dma_addr);
 	}
  out:
@@ -1928,7 +1920,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_command c;
 
 	/* Loop thru LBAF's in id_ns to match reqd lbaf, put in cdw10 */
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1979,8 +1971,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_sc;
 
  out_dma:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
  out:
 	return res;
 }
@@ -2485,7 +2476,7 @@ static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		resp_size = READ_CAP_16_RESP_SIZE;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -2514,8 +2505,7 @@ static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	kfree(response);
  out_dma:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ns), mem, dma_addr);
  out:
 	return res;
 }
@@ -2548,8 +2538,7 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out;
 	} else {
 		/* NVMe Controller Identify */
-		mem = dma_alloc_coherent(&dev->pci_dev->dev,
-					sizeof(struct nvme_id_ctrl),
+		mem = dma_alloc_coherent(dev->dev, sizeof(struct nvme_id_ctrl),
 					&dma_addr, GFP_KERNEL);
 		if (mem == NULL) {
 			res = -ENOMEM;
@@ -2600,8 +2589,7 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	kfree(response);
  out_dma:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ctrl), mem,
-			  dma_addr);
+	dma_free_coherent(dev->dev, sizeof(struct nvme_id_ctrl), mem, dma_addr);
  out:
 	return res;
 }
@@ -2913,7 +2901,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out;
 	}
 
-	range = dma_alloc_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
+	range = dma_alloc_coherent(dev->dev, ndesc * sizeof(*range),
 							&dma_addr, GFP_KERNEL);
 	if (!range)
 		goto out;
@@ -2934,8 +2922,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 
-	dma_free_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
-							range, dma_addr);
+	dma_free_coherent(dev->dev, ndesc * sizeof(*range), range, dma_addr);
  out:
 	kfree(plist);
 	return res;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 61488b2..de0e49a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -74,7 +74,7 @@ struct nvme_dev {
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
-	struct pci_dev *pci_dev;
+	struct device *dev;
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
 	int instance;
-- 
1.9.1
