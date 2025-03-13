Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE72C28B28
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 01:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oFhw2e3bFKhZO7W+nVt6fkbKXgSjH0ygJFKVjt7+WyA=; b=yJ8jD5HcVkNNh+6znuyVYwLB8V
	2yMLUnQdOma0RLLiik1OA6UTBJzX7IKagYrXH3RyAZtYmxUfonQ9W3qo7MqjysjRIgG36yOkXjVqD
	AseGLyZhnxJ3ex7Tp/aci18VDwwWrMMcjnXMlQdUUZ5EdWc8XOqzSGN4M2nNv9qsapp+6YmP6m8vj
	gENrNq+1BYjO+dm+PxtD42m5CuRph2yTjjnRGnFh92NSsSueFT9zpUb1IVAuiw6ZNxcrvYn3FmKir
	hyYZHDWiPAzqheLdZlSSM6efbMzbcSoJR7p6VMPTgd5nL9c3WYN/FwfOhmAlfNY+FuHfJJeE2JDub
	EBgRhc3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsX7a-00000009qy4-2MpR;
	Thu, 13 Mar 2025 01:12:26 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsX7X-00000009qxV-3R1i
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 01:12:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EE12FA4541F;
	Thu, 13 Mar 2025 01:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785CC4CEDD;
	Thu, 13 Mar 2025 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741828342;
	bh=HdmeTIFDJxXFcEI22ln4SgtMqL8o1PnKwo4XZGbtjvE=;
	h=From:To:Subject:Date:From;
	b=sF6/WP1uWdMiK8Zw7G+Xw/5zNFZg9DQ79FEdUs3zdnkoXSOgllsoHqlQXD7Br6TrQ
	 Git6h+HyV7LdjI8a26oSCB9KUcyykeIaXDtOgmlOVPHvxTlc+4wPihoB1Y5DOhp087
	 g5j4/oriCxxgAYcQFajtis9gh6wl40+FMOQtMTErYjggLAof1Q6C+bbWT7eX+7+IiU
	 5kmaX6yLDzjAfYaWwsAGW/96S0SQWhA1zUBtDmYLDVcgCfGWvXua2LXCAtK7n6QSP2
	 +mBy7aq7eFP3HXwPg008ZN9R6oX67oe9PeBE0TaPulachrMhVIWxBstKoCdFPp3Qkc
	 Y0KRficicBJFw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvmet: pci-epf: Keep completion queues mapped
Date: Thu, 13 Mar 2025 10:12:06 +0900
Message-ID: <20250313011206.1410530-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_181223_987016_28A88C85 
X-CRM114-Status: GOOD (  15.49  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of mapping and unmapping the completion queues memory to the
host PCI address space whenever nvmet_pci_epf_cq_work() is called, map
a completion queue to the host PCI address space when the completion
queue is created with nvmet_pci_epf_create_cq() and unmap it when the
completion queue is deleted with nvmet_pci_epf_delete_cq().

This removes the completion queue mapping/unmapping from
nvmet_pci_epf_cq_work() and significantly increases performance. For
a single job 4K random read QD=1 workload, the IOPS is increased from
23 KIOPS to 25 KIOPS. Some significant throughput increasde for high
queue depth and large IOs workloads can also be seen.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 77 ++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index b1e31483f157..6272cd013136 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -271,6 +271,36 @@ static inline void nvmet_pci_epf_mem_unmap(struct nvmet_pci_epf *nvme_epf,
 	pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no, map);
 }
 
+static int nvmet_pci_epf_map_queue(struct nvmet_pci_epf_ctrl *ctrl,
+				   struct nvmet_pci_epf_queue *queue)
+{
+	struct nvmet_pci_epf *nvme_epf = ctrl->nvme_epf;
+	int ret;
+
+	ret = nvmet_pci_epf_mem_map(nvme_epf, queue->pci_addr,
+				    queue->pci_size, &queue->pci_map);
+	if (ret) {
+		dev_err(ctrl->dev, "Failed to map queue %u (err=%d)\n",
+			queue->qid, ret);
+		return ret;
+	}
+
+	if (queue->pci_map.pci_size < queue->pci_size) {
+		dev_err(ctrl->dev, "Invalid partial mapping of queue %u\n",
+			queue->qid);
+		nvmet_pci_epf_mem_unmap(nvme_epf, &queue->pci_map);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline void nvmet_pci_epf_unmap_queue(struct nvmet_pci_epf_ctrl *ctrl,
+					     struct nvmet_pci_epf_queue *queue)
+{
+	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &queue->pci_map);
+}
+
 struct nvmet_pci_epf_dma_filter {
 	struct device *dev;
 	u32 dma_mask;
@@ -1264,6 +1294,7 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
 	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
 	u16 status;
+	int ret;
 
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
@@ -1298,6 +1329,12 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	if (status != NVME_SC_SUCCESS)
 		goto err;
 
+	ret = nvmet_pci_epf_map_queue(ctrl, cq);
+	if (ret) {
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+		goto err;
+	}
+
 	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
 
 	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
@@ -1322,6 +1359,7 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 	cancel_delayed_work_sync(&cq->work);
 	nvmet_pci_epf_drain_queue(cq);
 	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
+	nvmet_pci_epf_unmap_queue(ctrl, cq);
 
 	return NVME_SC_SUCCESS;
 }
@@ -1554,36 +1592,6 @@ static void nvmet_pci_epf_free_queues(struct nvmet_pci_epf_ctrl *ctrl)
 	ctrl->cq = NULL;
 }
 
-static int nvmet_pci_epf_map_queue(struct nvmet_pci_epf_ctrl *ctrl,
-				   struct nvmet_pci_epf_queue *queue)
-{
-	struct nvmet_pci_epf *nvme_epf = ctrl->nvme_epf;
-	int ret;
-
-	ret = nvmet_pci_epf_mem_map(nvme_epf, queue->pci_addr,
-				      queue->pci_size, &queue->pci_map);
-	if (ret) {
-		dev_err(ctrl->dev, "Failed to map queue %u (err=%d)\n",
-			queue->qid, ret);
-		return ret;
-	}
-
-	if (queue->pci_map.pci_size < queue->pci_size) {
-		dev_err(ctrl->dev, "Invalid partial mapping of queue %u\n",
-			queue->qid);
-		nvmet_pci_epf_mem_unmap(nvme_epf, &queue->pci_map);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static inline void nvmet_pci_epf_unmap_queue(struct nvmet_pci_epf_ctrl *ctrl,
-					     struct nvmet_pci_epf_queue *queue)
-{
-	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &queue->pci_map);
-}
-
 static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 {
 	struct nvmet_pci_epf_iod *iod =
@@ -1747,11 +1755,7 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 	struct nvme_completion *cqe;
 	struct nvmet_pci_epf_iod *iod;
 	unsigned long flags;
-	int ret, n = 0;
-
-	ret = nvmet_pci_epf_map_queue(ctrl, cq);
-	if (ret)
-		goto again;
+	int ret = 0, n = 0;
 
 	while (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags) && ctrl->link_up) {
 
@@ -1798,8 +1802,6 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 		n++;
 	}
 
-	nvmet_pci_epf_unmap_queue(ctrl, cq);
-
 	/*
 	 * We do not support precise IRQ coalescing time (100ns units as per
 	 * NVMe specifications). So if we have posted completion entries without
@@ -1808,7 +1810,6 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 	if (n)
 		nvmet_pci_epf_raise_irq(ctrl, cq, true);
 
-again:
 	if (ret < 0)
 		queue_delayed_work(system_highpri_wq, &cq->work,
 				   NVMET_PCI_EPF_CQ_RETRY_INTERVAL);
-- 
2.48.1


