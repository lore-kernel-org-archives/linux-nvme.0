Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE9C28B28
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ku8EyD+NwFJuBHOkTwVv7nZmRfQkB61QCF/kuQJ9ELo=; b=n0nsmFVkV8nU9sghxW6b8NMv4o
	uhXnKx8qgSBB0VARHBDtEo7rajKwmt5we5lYqJCuQUzIHxZOVwek2da3KB8+LyrQD201VBzsmWkRZ
	uj4O2du+4ebC/JZbsDXX+gDi6QSpgulwDQSs1CEVOUX3nfA2r+4ASzQj6abIocqXIXJT4CIOJecy8
	jrt53EoXGh3IvFnAMW45lXF6ZqDcMbVO0T6lJQuQ1My/WeV5PMDj0hnd/ylF2evMSzsZAfgcq/M6r
	f650/TwS8NyIl7bmurcBgfh+Qm0f98TSths2v9hLTR8Bk7HCvnDT8chaXoTPFk2Vbwa0BQzhdCoV7
	9Sue8P/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdSb-0000000AU35-0t1W;
	Thu, 13 Mar 2025 07:58:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdSY-0000000AU1w-3FU9
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 07:58:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 844A7A45A52;
	Thu, 13 Mar 2025 07:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D82AC4CEE9;
	Thu, 13 Mar 2025 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741852709;
	bh=i6OWKC+HZNsSQiPOZc0CNzLvTYKoMbGi9DLhMjLDB98=;
	h=From:To:Subject:Date:From;
	b=SjDqOQ1GnziQfrqUff2b9JzL0fjWmptc2lnSNBSC5TdUSKmxIcta087HDAuD1ixrr
	 TGKqwEWl4GV4sF+LM6KKaciDiZR0b9yMBKXi4c34sdMKQ3S7O0FI4zcJjBhHoqxWB4
	 ga+r9kyuZxsEzDIw86RSmX3HABz4xB8ZsCz84iP9XgqjRE6Fwmo2NZ4RJzFH6Ri2Bq
	 qHuMDdTUnEyfu83nZmAhvz20oN+LlnWG5s+oD33bDocClRzJ8z9YzgqA3VODJvKyaF
	 fv+EgFkZ1rUxF0fOmGMFBaTa4J9+JqyTj5jn2Gmv56vHMlZ7mbIdanXk+fFTrs3dTJ
	 TRJ/DDBDvlCuw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvmet: pci-epf: Remove nvmet_pci_epf_[un]map_queue()
Date: Thu, 13 Mar 2025 16:58:14 +0900
Message-ID: <20250313075814.1442096-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_005830_954755_F67C70D9 
X-CRM114-Status: GOOD (  12.95  )
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

The functions nvmet_pci_epf_map_queue() and nvmet_pci_epf_unmap_queue()
are called respectively only from nvmet_pci_epf_create_cq() and
nvmet_pci_epf_delete_cq(). Remove these functions and open-code them in
their call site.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---

Note: this goes on top of the patch "nvmet: pci-epf: Keep completion
queues mapped". I can squash these 2 patches together if preferred.

 drivers/nvme/target/pci-epf.c | 54 +++++++++++++----------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 6272cd013136..f56994a78066 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -271,36 +271,6 @@ static inline void nvmet_pci_epf_mem_unmap(struct nvmet_pci_epf *nvme_epf,
 	pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no, map);
 }
 
-static int nvmet_pci_epf_map_queue(struct nvmet_pci_epf_ctrl *ctrl,
-				   struct nvmet_pci_epf_queue *queue)
-{
-	struct nvmet_pci_epf *nvme_epf = ctrl->nvme_epf;
-	int ret;
-
-	ret = nvmet_pci_epf_mem_map(nvme_epf, queue->pci_addr,
-				    queue->pci_size, &queue->pci_map);
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
 struct nvmet_pci_epf_dma_filter {
 	struct device *dev;
 	u32 dma_mask;
@@ -1329,10 +1299,22 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	if (status != NVME_SC_SUCCESS)
 		goto err;
 
-	ret = nvmet_pci_epf_map_queue(ctrl, cq);
+	/*
+	 * Map the CQ PCI address space and since PCI endpoint controllers may
+	 * return a partial mapping, check that the mapping is large enough.
+	 */
+	ret = nvmet_pci_epf_mem_map(ctrl->nvme_epf, cq->pci_addr, cq->pci_size,
+				    &cq->pci_map);
 	if (ret) {
-		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
-		goto err;
+		dev_err(ctrl->dev, "Failed to map CQ %u (err=%d)\n",
+			cq->qid, ret);
+		goto err_internal;
+	}
+
+	if (cq->pci_map.pci_size < cq->pci_size) {
+		dev_err(ctrl->dev, "Invalid partial mapping of queue %u\n",
+			cq->qid);
+		goto err_unmap_queue;
 	}
 
 	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
@@ -1342,6 +1324,10 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 
 	return NVME_SC_SUCCESS;
 
+err_unmap_queue:
+	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
+err_internal:
+	status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 err:
 	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
 		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
@@ -1359,7 +1345,7 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 	cancel_delayed_work_sync(&cq->work);
 	nvmet_pci_epf_drain_queue(cq);
 	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
-	nvmet_pci_epf_unmap_queue(ctrl, cq);
+	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 
 	return NVME_SC_SUCCESS;
 }
-- 
2.48.1


