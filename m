Return-Path: <SRS0=cJ6X=ZA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A7FA372C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 03:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E1C20869
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 03:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fZDruoEx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqs8GtRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E1C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L0FXDA4/Fg5/tJWU1qc/TVfXb+UHVDi8w+5Xnp0e4iY=; b=fZDruoEx35zs1D
	r3NkaG5zeEH7cend0ZcPxEnKxcX12NJGZN3Sb9uatAFq2161YNJi5B+2h2VwFdMs61qp+wjnRp4Q9
	06KiCjR4oC9XbBKFbvYTJerczmGvzNl1oavtKHrT8RMtdpZeBzIO+RWokh4wk2y8BdBPNd89wyHVo
	nHBKUX0dMKA6GvL1C8SB2WE3LFpQyp4E+fRFHwlb7aDNINIzEMa2ndmoeBzY85/4ugvicHEAurdQZ
	8L5IW/fb0y7RK5uVx3hAnuxJKK9v33LUUE5WkrTfHNPUqHD0RmTakUvcbCcg2/2NRnmlzyYeN56kV
	uQUfNWGbQCaedy6ZBkYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSvNF-0005Bw-TR; Fri, 08 Nov 2019 03:55:49 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSvN4-0004wW-2s
 for linux-nvme@lists.infradead.org; Fri, 08 Nov 2019 03:55:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573185336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDQESITFtKRriQSjUrJk3N8iJeSPk+oMknv9T+1HX9E=;
 b=Rqs8GtRKncvKDfLOfZ/5Px6wxims2XDY2czHFYP7Iq3FHM9mczCjWuU6cb413QDDEgnyYq
 /a2ftqSpYso67W90D0V10dV4t5f4hCDVrVfTHQi2NFmwuO6waXSZ4IXGJ7HHH3TcetRQq8
 IxCRZb+ijUKvR2RUpe7odn1E54zvh2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-fFZ2DA5-OB-JUk88jD5L2Q-1; Thu, 07 Nov 2019 22:55:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1F9B477;
 Fri,  8 Nov 2019 03:55:31 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE3260BE2;
 Fri,  8 Nov 2019 03:55:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Date: Fri,  8 Nov 2019 11:55:08 +0800
Message-Id: <20191108035508.26395-3-ming.lei@redhat.com>
In-Reply-To: <20191108035508.26395-1-ming.lei@redhat.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fFZ2DA5-OB-JUk88jD5L2Q-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_195538_229932_F6845867 
X-CRM114-Status: GOOD (  15.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

f9dde187fa92("nvme-pci: remove cq check after submission") removes
cq check after submission, this change actually causes performance
regression on some NVMe drive in which single nvmeq handles requests
originated from more than one blk-mq sw queues(call it multi-mapping
queue).

Actually polling IO after submission can handle IO more efficiently,
especially for multi-mapping queue:

1) the poll itself is very cheap, and lockless check on cq is enough,
see nvme_cqe_pending(). Especially the check can be done after batch
submission is done.

2) when IO completion is observed via the poll in submission, the requst
may be completed without interrupt involved, or the interrupt handler
overload can be decreased.

3) when single sw queue is submiting IOs to this hw queue, if IOs completion
is observed via this poll, the IO can be completed locally, which is
cheaper than remote completion.

Follows test result done on Azure L80sv2 guest with NVMe drive(
Microsoft Corporation Device b111). This guest has 80 CPUs and 10
numa nodes, and each NVMe drive supports 8 hw queues.

1) test script:
fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1 \
	--iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
	--direct=1 --runtime=30 --numjobs=1 --rw=randread \
	--name=test --group_reporting --gtod_reduce=1

2) test result:
     | v5.3       | v5.3 with this patchset
-------------------------------------------
IOPS | 130K       | 424K

Given IO is handled more efficiently in this way, the original report
of CPU lockup[1] on Hyper-V can't be observed any more after this patch
is applied. This issue is usually triggered when running IO from all
CPUs concurrently.

I also run test on Optane(32 hw queues) in big machine(96 cores, 2 numa
nodes), small improvement is observed on running the above fio over two
NVMe drive with batch 1.

[1] https://lore.kernel.org/lkml/1566281669-48212-1-git-send-email-longli@linuxonhyperv.com

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Long Li <longli@microsoft.com>
Fixes: f9dde187fa92("nvme-pci: remove cq check after submission")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 90 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b20ab4d21d3..880376f43897 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -83,6 +83,7 @@ struct nvme_queue;
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
+static void nvme_poll_in_submission(struct nvme_queue *nvmeq);
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -165,7 +166,10 @@ struct nvme_queue {
 	spinlock_t sq_lock;
 	void *sq_cmds;
 	 /* only used for poll queues: */
-	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
+	union {
+		spinlock_t cq_poll_lock;
+		spinlock_t cq_lock;
+	}____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
@@ -185,6 +189,7 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_MULTI_MAPPING	4
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -911,6 +916,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
+
+	if (bd->last)
+		nvme_poll_in_submission(nvmeq);
+
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -1016,6 +1025,19 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
 	return found;
 }
 
+static inline irqreturn_t
+nvme_update_cq(struct nvme_queue *nvmeq, u16 *start, u16 *end)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	if (nvmeq->cq_head != nvmeq->last_cq_head)
+		ret = IRQ_HANDLED;
+	nvme_process_cq(nvmeq, start, end, -1);
+	nvmeq->last_cq_head = nvmeq->cq_head;
+
+	return ret;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
@@ -1027,10 +1049,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	 * the irq handler, even if that was on another CPU.
 	 */
 	rmb();
-	if (nvmeq->cq_head != nvmeq->last_cq_head)
-		ret = IRQ_HANDLED;
-	nvme_process_cq(nvmeq, &start, &end, -1);
-	nvmeq->last_cq_head = nvmeq->cq_head;
+	ret = nvme_update_cq(nvmeq, &start, &end);
 	wmb();
 
 	if (start != end) {
@@ -1041,6 +1060,24 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return ret;
 }
 
+static irqreturn_t nvme_irq_multi_mapping(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	irqreturn_t ret = IRQ_NONE;
+	u16 start, end;
+
+	spin_lock(&nvmeq->cq_lock);
+	ret = nvme_update_cq(nvmeq, &start, &end);
+	spin_unlock(&nvmeq->cq_lock);
+
+	if (start != end) {
+		nvme_complete_cqes(nvmeq, start, end);
+		return IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
@@ -1049,6 +1086,24 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
+static void nvme_poll_in_submission(struct nvme_queue *nvmeq)
+{
+	if (test_bit(NVMEQ_MULTI_MAPPING, &nvmeq->flags) &&
+			nvme_cqe_pending(nvmeq)) {
+		unsigned long flags;
+
+		if (spin_trylock_irqsave(&nvmeq->cq_lock, flags)) {
+			u16 start, end;
+
+			nvme_update_cq(nvmeq, &start, &end);
+			spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
+
+			if (start != end)
+				nvme_complete_cqes(nvmeq, start, end);
+		}
+	}
+}
+
 /*
  * Poll for completions any queue, including those not dedicated to polling.
  * Can be called from any context.
@@ -1499,12 +1554,14 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
+	irq_handler_t handler = test_bit(NVMEQ_MULTI_MAPPING, &nvmeq->flags) ?
+		nvme_irq_multi_mapping : nvme_irq;
 
 	if (use_threaded_interrupts) {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+				handler, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+		return pci_request_irq(pdev, nvmeq->cq_vector, handler,
 				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	}
 }
@@ -1514,7 +1571,13 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	struct nvme_dev *dev = nvmeq->dev;
 
 	spin_lock_init(&nvmeq->sq_lock);
-	spin_lock_init(&nvmeq->cq_poll_lock);
+
+	if (test_bit(NVMEQ_MULTI_MAPPING, &nvmeq->flags)) {
+		WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
+		spin_lock_init(&nvmeq->cq_lock);
+	} else {
+		spin_lock_init(&nvmeq->cq_poll_lock);
+	}
 
 	nvmeq->sq_tail = 0;
 	nvmeq->last_sq_tail = 0;
@@ -1534,15 +1597,22 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	u16 vector = 0;
 
 	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
+	clear_bit(NVMEQ_MULTI_MAPPING, &nvmeq->flags);
 
 	/*
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
 	 */
-	if (!polled)
+	if (!polled) {
+		struct pci_dev *pdev = to_pci_dev(dev->dev);
+
 		vector = dev->num_vecs == 1 ? 0 : qid;
-	else
+		if (vector && cpumask_weight(pci_irq_get_affinity(pdev,
+						vector)) > 1)
+			set_bit(NVMEQ_MULTI_MAPPING, &nvmeq->flags);
+	} else {
 		set_bit(NVMEQ_POLLED, &nvmeq->flags);
+	}
 
 	result = adapter_alloc_cq(dev, qid, nvmeq, vector);
 	if (result)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
