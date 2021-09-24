Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 21:09:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9786140F
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 21:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC9786140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=miEs+m45ERk3r+kfyDkC/ehLX1QkzxeeMdjsVMBodaU=; b=VaXFJR4dxFLlMf
	cp04W5DPk5b9dZIC1HlWkApaG0h9LORB1IyII7uA48IxExkvpIhAT7aV06JWLWrMIG1wg+tOGTvDr
	6aRaUkOHWUUo6YVPSebn++0bpjkuECCSEMxR9xyuMSlpo6yCGCWPkpz2xXw2PBGu7bRfS7xikK0ns
	5VjE+MFmusSGyOOEfnGqiluO6QeoAsaG/ckZ5b+4jJU3xY///ua8vpJe5JMJGQ8Ez3/uvNFuYyqIx
	V1KJSF30vDs4Duz118ZV7r2xEQEOh9MOIJy9GEZ33V61TlATV5aoXH/xpV8GMisHY59aS72x3Poer
	wxZuImE7SdhFM9IjUKKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTsRK-00FXQ9-6U; Fri, 24 Sep 2021 21:09:02 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTsQl-00FXGQ-Et
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 21:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1632517707; x=1664053707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oVUhj6eDK6fsHl9cG3O92vuW4CiVg5liRZ2ixDWLg7E=;
 b=p4xGhckTbLYyvl806Saa4Vp+JH1pCtLJQ656X1rDlG6BlYo1KePGZXHl
 cxt4ugZY2KehlNRDGHIF8jKxT4GaYsQjINdTt9SM1oLii/nwALNIpEVbJ
 pzZZBKKrD/lfGz7DmOlb/v9KZwickXnITlwdXs5U/rQC7e0XqXfxBH/L4 c=;
X-IronPort-AV: E=Sophos;i="5.85,321,1624320000"; d="scan'208";a="144508881"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2a-39fdda15.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 24 Sep 2021 21:08:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2a-39fdda15.us-west-2.amazon.com (Postfix) with
 ESMTPS id 1110741AD9; Fri, 24 Sep 2021 21:08:22 +0000 (UTC)
Received: from EX13D04UWA003.ant.amazon.com (10.43.160.212) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Fri, 24 Sep 2021 21:08:21 +0000
Received: from dev-dsk-nikitina-1d-36de5be9.us-east-1.amazon.com
 (10.43.162.216) by EX13D04UWA003.ant.amazon.com (10.43.160.212) with
 Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 24 Sep 2021 21:08:20 +0000
From: Andrey Nikitin <nikitina@amazon.com>
To: <linux-nvme@lists.infradead.org>
CC: <benh@kernel.crashing.org>, <davebuch@amazon.com>, Andrey Nikitin
 <nikitina@amazon.com>
Subject: [RFC PATCH 1/3] nvme: split admin queue in pci
Date: Fri, 24 Sep 2021 21:08:07 +0000
Message-ID: <20210924210809.14536-2-nikitina@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210924210809.14536-1-nikitina@amazon.com>
References: <20210924210809.14536-1-nikitina@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.43.162.216]
X-ClientProxiedBy: EX13D44UWC003.ant.amazon.com (10.43.162.138) To
 EX13D04UWA003.ant.amazon.com (10.43.160.212)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210924_140827_673504_A7667121 
X-CRM114-Status: GOOD (  23.78  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To determine the number of required IO queues it may be needed to
send admin commands. To facilitate that process admin queue is split
from the array of IO queues and allocation of IO queues is moved to
reset routine.

Signed-off-by: Andrey Nikitin <nikitina@amazon.com>
---
 drivers/nvme/host/pci.c | 162 +++++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 69 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..37de7ac79b3f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -108,12 +108,47 @@ struct nvme_queue;
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
+/*
+ * An NVM Express queue.  Each device has at least two (one for admin
+ * commands and one for I/O commands).
+ */
+struct nvme_queue {
+	struct nvme_dev *dev;
+	spinlock_t sq_lock;
+	void *sq_cmds;
+	 /* only used for poll queues: */
+	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
+	struct nvme_completion *cqes;
+	dma_addr_t sq_dma_addr;
+	dma_addr_t cq_dma_addr;
+	u32 __iomem *q_db;
+	u32 q_depth;
+	u16 cq_vector;
+	u16 sq_tail;
+	u16 last_sq_tail;
+	u16 cq_head;
+	u16 qid;
+	u8 cq_phase;
+	u8 sqes;
+	unsigned long flags;
+#define NVMEQ_ENABLED		0
+#define NVMEQ_SQ_CMB		1
+#define NVMEQ_DELETE_ERROR	2
+#define NVMEQ_POLLED		3
+	u32 *dbbuf_sq_db;
+	u32 *dbbuf_cq_db;
+	u32 *dbbuf_sq_ei;
+	u32 *dbbuf_cq_ei;
+	struct completion delete_done;
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
 struct nvme_dev {
 	struct nvme_queue *queues;
 	struct blk_mq_tag_set tagset;
+	struct nvme_queue admin_queue;
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
 	struct device *dev;
@@ -181,40 +216,6 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
-/*
- * An NVM Express queue.  Each device has at least two (one for admin
- * commands and one for I/O commands).
- */
-struct nvme_queue {
-	struct nvme_dev *dev;
-	spinlock_t sq_lock;
-	void *sq_cmds;
-	 /* only used for poll queues: */
-	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
-	struct nvme_completion *cqes;
-	dma_addr_t sq_dma_addr;
-	dma_addr_t cq_dma_addr;
-	u32 __iomem *q_db;
-	u32 q_depth;
-	u16 cq_vector;
-	u16 sq_tail;
-	u16 last_sq_tail;
-	u16 cq_head;
-	u16 qid;
-	u8 cq_phase;
-	u8 sqes;
-	unsigned long flags;
-#define NVMEQ_ENABLED		0
-#define NVMEQ_SQ_CMB		1
-#define NVMEQ_DELETE_ERROR	2
-#define NVMEQ_POLLED		3
-	u32 *dbbuf_sq_db;
-	u32 *dbbuf_cq_db;
-	u32 *dbbuf_sq_ei;
-	u32 *dbbuf_cq_ei;
-	struct completion delete_done;
-};
-
 /*
  * The nvme_iod describes the data in an I/O.
  *
@@ -235,9 +236,14 @@ struct nvme_iod {
 	struct scatterlist *sg;
 };
 
+static struct nvme_queue *nvme_get_queue(struct nvme_dev *dev, unsigned int qid)
+{
+	return qid == 0 ? &dev->admin_queue : &dev->queues[qid - 1];
+}
+
 static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
 {
-	return dev->nr_allocated_queues * 8 * dev->db_stride;
+	return dev->ctrl.queue_count * 8 * dev->db_stride;
 }
 
 static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
@@ -322,7 +328,7 @@ static void nvme_dbbuf_set(struct nvme_dev *dev)
 		nvme_dbbuf_dma_free(dev);
 
 		for (i = 1; i <= dev->online_queues; i++)
-			nvme_dbbuf_free(&dev->queues[i]);
+			nvme_dbbuf_free(nvme_get_queue(dev, i));
 	}
 }
 
@@ -396,7 +402,7 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
 	struct nvme_dev *dev = data;
-	struct nvme_queue *nvmeq = &dev->queues[0];
+	struct nvme_queue *nvmeq = &dev->admin_queue;
 
 	WARN_ON(hctx_idx != 0);
 	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
@@ -409,19 +415,34 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 			  unsigned int hctx_idx)
 {
 	struct nvme_dev *dev = data;
-	struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];
+	struct nvme_queue *nvmeq = &dev->queues[hctx_idx];
 
 	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
 	hctx->driver_data = nvmeq;
 	return 0;
 }
 
+static int nvme_admin_init_request(struct blk_mq_tag_set *set, struct request *req,
+		unsigned int hctx_idx, unsigned int numa_node)
+{
+	struct nvme_dev *dev = set->driver_data;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = &dev->admin_queue;
+
+	BUG_ON(!nvmeq);
+	iod->nvmeq = nvmeq;
+
+	nvme_req(req)->ctrl = &dev->ctrl;
+	nvme_req(req)->cmd = &iod->cmd;
+	return 0;
+}
+
 static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 		unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct nvme_dev *dev = set->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	int queue_idx = (set == &dev->tagset) ? hctx_idx + 1 : 0;
+	int queue_idx = hctx_idx;
 	struct nvme_queue *nvmeq = &dev->queues[queue_idx];
 
 	BUG_ON(!nvmeq);
@@ -1109,7 +1130,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
-	struct nvme_queue *nvmeq = &dev->queues[0];
+	struct nvme_queue *nvmeq = &dev->admin_queue;
 	struct nvme_command c = { };
 
 	c.common.opcode = nvme_admin_async_event;
@@ -1377,7 +1398,7 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 
 	for (i = dev->ctrl.queue_count - 1; i >= lowest; i--) {
 		dev->ctrl.queue_count--;
-		nvme_free_queue(&dev->queues[i]);
+		nvme_free_queue(nvme_get_queue(dev, i));
 	}
 }
 
@@ -1406,12 +1427,12 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
-		nvme_suspend_queue(&dev->queues[i]);
+		nvme_suspend_queue(nvme_get_queue(dev, i));
 }
 
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
-	struct nvme_queue *nvmeq = &dev->queues[0];
+	struct nvme_queue *nvmeq = &dev->admin_queue;
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
@@ -1432,9 +1453,11 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
-		spin_lock(&dev->queues[i].cq_poll_lock);
-		nvme_process_cq(&dev->queues[i]);
-		spin_unlock(&dev->queues[i].cq_poll_lock);
+		struct nvme_queue *nvmeq = nvme_get_queue(dev, i);
+
+		spin_lock(&nvmeq->cq_poll_lock);
+		nvme_process_cq(nvmeq);
+		spin_unlock(&nvmeq->cq_poll_lock);
 	}
 }
 
@@ -1491,7 +1514,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 
 static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 {
-	struct nvme_queue *nvmeq = &dev->queues[qid];
+	struct nvme_queue *nvmeq = nvme_get_queue(dev, qid);
 
 	if (dev->ctrl.queue_count > qid)
 		return 0;
@@ -1631,7 +1654,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
-	.init_request	= nvme_init_request,
+	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
 
@@ -1746,7 +1769,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 
 	dev->ctrl.numa_node = dev_to_node(dev->dev);
 
-	nvmeq = &dev->queues[0];
+	nvmeq = &dev->admin_queue;
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
@@ -1793,7 +1816,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	for (i = dev->online_queues; i <= max; i++) {
 		bool polled = i > rw_queues;
 
-		ret = nvme_create_queue(&dev->queues[i], i, polled);
+		ret = nvme_create_queue(nvme_get_queue(dev, i), i, polled);
 		if (ret)
 			break;
 	}
@@ -2245,7 +2268,7 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	struct nvme_queue *adminq = &dev->queues[0];
+	struct nvme_queue *adminq = &dev->admin_queue;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	unsigned int nr_io_queues;
 	unsigned long size;
@@ -2258,7 +2281,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 
-	nr_io_queues = dev->nr_allocated_queues - 1;
+	nr_io_queues = nvme_max_io_queues(dev);
+	if (nr_io_queues != dev->nr_allocated_queues) {
+		dev->nr_allocated_queues = nr_io_queues;
+
+		kfree(dev->queues);
+		dev->queues = kcalloc_node(dev->nr_allocated_queues,
+				sizeof(struct nvme_queue), GFP_KERNEL,
+				dev_to_node(dev->dev));
+		if (!dev->queues)
+			return -ENOMEM;
+	}
+
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
@@ -2404,13 +2438,13 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
  retry:
 	timeout = NVME_ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
-		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
+		if (nvme_delete_queue(nvme_get_queue(dev, nr_queues), opcode))
 			break;
 		nr_queues--;
 		sent++;
 	}
 	while (sent) {
-		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
+		struct nvme_queue *nvmeq = nvme_get_queue(dev, nr_queues + sent);
 
 		timeout = wait_for_completion_io_timeout(&nvmeq->delete_done,
 				timeout);
@@ -2606,7 +2640,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_suspend_io_queues(dev);
-	nvme_suspend_queue(&dev->queues[0]);
+	nvme_suspend_queue(&dev->admin_queue);
 	nvme_pci_disable(dev);
 	nvme_reap_pending_cqes(dev);
 
@@ -2779,6 +2813,10 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto out;
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
 		result = nvme_dbbuf_dma_alloc(dev);
 		if (result)
@@ -2792,10 +2830,6 @@ static void nvme_reset_work(struct work_struct *work)
 			goto out;
 	}
 
-	result = nvme_setup_io_queues(dev);
-	if (result)
-		goto out;
-
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
@@ -2970,14 +3004,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->nr_write_queues = write_queues;
-	dev->nr_poll_queues = poll_queues;
-	dev->nr_allocated_queues = nvme_max_io_queues(dev) + 1;
-	dev->queues = kcalloc_node(dev->nr_allocated_queues,
-			sizeof(struct nvme_queue), GFP_KERNEL, node);
-	if (!dev->queues)
-		goto free;
-
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
@@ -3041,8 +3067,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_unmap(dev);
  put_pci:
 	put_device(dev->dev);
- free:
-	kfree(dev->queues);
 	kfree(dev);
 	return result;
 }
-- 
2.32.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
