Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B284C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yaRN5+PCP9FnwrW5Cfxk6+qx193aA2C/dlliCkOfmmk=; b=pP7f/6BTBeSc32d5K0HutawohX
	OgFV8kINvXSM6HytkJ2Y7+1YaPK3WiSM9ZSY//HrJUzZnpwy/azSFYoox3qI5GXJRKUQatoZdiaze
	hhOEjBjOflxU1QE4hpAlnSp8jrSifg5lB931iq9aROAFlcUseDT0E6TGXTh7EHZJ+BPGHQUPUHwKi
	kUmpWox145SbJ0MoNMLRF2OQq3lyTCzkXcPlJfA6GI9mvD85hPRINCVfHPMXQ42UqCgI/NwdhUacp
	jRDw3/+EIA31JasV9uU/G0UXyas5D+sm+sjOOfqCc8ufzKX257v/aiHloUku7KEb60rqHb++ndUDK
	rw0lQsIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdrJ-0000000AXJx-038k;
	Thu, 13 Mar 2025 08:24:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdpp-0000000AXAI-1mMv
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 08:22:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DB1675C594A;
	Thu, 13 Mar 2025 08:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE492C4CEDD;
	Thu, 13 Mar 2025 08:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741854152;
	bh=DDtW3gec1ux3utAzHfbT9jNBA6Mn0dyNe46J8rAV/rU=;
	h=From:To:Subject:Date:From;
	b=Pt9GUr7xGDxx10sq8XD6ysXjvDOucERXca4Ox9YtUG2gdX+ZCP7CpRLhEOseW3MCr
	 v0ASriYgUNXQBMLDHSqkRSlNxhEe+WY4PN1+PfZ+toU/8on05/9D7rJseBDmd6h3ms
	 vF8R02BGgsgvdr3aiE0rIUiI/nZp8CdWlc7pQgjosxYbPX9FE7nIfCISAEe6ropLUi
	 BrR/PekfiL4KejGLn+moKDOuPXvJpr7AUYaYgvd0khwt6lpzTfPHY9kszG2CXxPccB
	 goJSwDgW6BiNchwmhGf7iXXn7tzcdFqVyv10wsSA6OaFmVVxVI28YO7bf0kpmgUKcR
	 DHwddrCkI/l6A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2] nvmet: pci-epf: Keep completion queues mapped
Date: Thu, 13 Mar 2025 17:22:18 +0900
Message-ID: <20250313082218.1444073-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_012233_607149_D1705575 
X-CRM114-Status: GOOD (  15.66  )
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

Since the functions nvmet_pci_epf_map_queue() and
nvmet_pci_epf_unmap_queue() are called respectively only from
nvmet_pci_epf_create_cq() and nvmet_pci_epf_delete_cq(), these functions
are removed and open-coded in their respective call sites.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---

Changes from v1:
 - Remove and open code the functions nvmet_pci_epf_map_queue() and
   nvmet_pci_epf_unmap_queue().

 drivers/nvme/target/pci-epf.c | 63 ++++++++++++++---------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index b1e31483f157..f56994a78066 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1264,6 +1264,7 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
 	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
 	u16 status;
+	int ret;
 
 	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
@@ -1298,6 +1299,24 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	if (status != NVME_SC_SUCCESS)
 		goto err;
 
+	/*
+	 * Map the CQ PCI address space and since PCI endpoint controllers may
+	 * return a partial mapping, check that the mapping is large enough.
+	 */
+	ret = nvmet_pci_epf_mem_map(ctrl->nvme_epf, cq->pci_addr, cq->pci_size,
+				    &cq->pci_map);
+	if (ret) {
+		dev_err(ctrl->dev, "Failed to map CQ %u (err=%d)\n",
+			cq->qid, ret);
+		goto err_internal;
+	}
+
+	if (cq->pci_map.pci_size < cq->pci_size) {
+		dev_err(ctrl->dev, "Invalid partial mapping of queue %u\n",
+			cq->qid);
+		goto err_unmap_queue;
+	}
+
 	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
 
 	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
@@ -1305,6 +1324,10 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 
 	return NVME_SC_SUCCESS;
 
+err_unmap_queue:
+	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
+err_internal:
+	status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 err:
 	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
 		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
@@ -1322,6 +1345,7 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 	cancel_delayed_work_sync(&cq->work);
 	nvmet_pci_epf_drain_queue(cq);
 	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
+	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 
 	return NVME_SC_SUCCESS;
 }
@@ -1554,36 +1578,6 @@ static void nvmet_pci_epf_free_queues(struct nvmet_pci_epf_ctrl *ctrl)
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
@@ -1747,11 +1741,7 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
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
 
@@ -1798,8 +1788,6 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 		n++;
 	}
 
-	nvmet_pci_epf_unmap_queue(ctrl, cq);
-
 	/*
 	 * We do not support precise IRQ coalescing time (100ns units as per
 	 * NVMe specifications). So if we have posted completion entries without
@@ -1808,7 +1796,6 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 	if (n)
 		nvmet_pci_epf_raise_irq(ctrl, cq, true);
 
-again:
 	if (ret < 0)
 		queue_delayed_work(system_highpri_wq, &cq->work,
 				   NVMET_PCI_EPF_CQ_RETRY_INTERVAL);
-- 
2.48.1


