Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496EBC83F17
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jul 2025 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BSn8Bd39ksWSgUbfWXSqX94WHuL7Oip1GIx5eltpRYk=; b=qOl/xrVN9v/8W2OsopCI7nWrnD
	+MRLFsfVA2+sbaNYDDLiyhv39gKEahv0XnCfqCB5jA3/gcfFXwWikL4dnBp6FAxAj+w6OOreHFmyg
	Y7NGNE2SVVYmV6BOwyZeZK6C7k/9x03Hzd+eP6E990I9FuaBTdnmQwbGHpF/R2vc9MVIPvZGoz0hs
	3BGbEvrsmJIu2Tnqp8V9WiBCu0/J2vMQoDvNYinfaFelkwK6h+j7zfl2+iDG+8vNBkq2oSdtFGYZD
	JEUV8Dv2IFiO0Rq1cRz96Dq1cO1FY4fYd5/wGsVnFX1tFR3ciUseCS0hUBRtQsMhHCx2L4QIdHR8I
	ukPm6eaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueg4P-00000005tcO-1OxK;
	Wed, 23 Jul 2025 20:28:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueg4N-00000005tcB-2Km9
	for linux-nvme@lists.infradead.org;
	Wed, 23 Jul 2025 20:28:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 03F1C6113A;
	Wed, 23 Jul 2025 20:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB2C4CEFA;
	Wed, 23 Jul 2025 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302486;
	bh=4G0qJWXzTgIhzJCFR5AflLsD2rnqsd9gHV06wB10rD8=;
	h=From:To:Cc:Subject:Date:From;
	b=WX4MBjuNZODHCR3kOaNx/hisUTqk1u8BcE8ZY2eJ3W5fSye/uEgJtjEfAxBz51AKy
	 uKsdwD0E7SXKGIIV8vz6eiF+C6Mxt9/pSKxDu/xhWLuOy6uSofwz9QPkQi0omOxTJi
	 dmhQhR798LARp0i/mxS9DV0Ov/yg1AlFrRQ5WBp/9iZCiehTzR9ncK4hzKUi6DX4pS
	 JHXhLvmxw4b8nOGGnmkxLqHq+Wwn+AbfRPd0b0YQY+dipNGruC5xeE2f5YjBrnZ++t
	 Q+95S7nPdWZRzAVpVKdO095uwPM/13d3VxGP/lyu0WDsxY9PMkt2FwImAEHwT9jc+8
	 hHoWDIGWy+qOw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] nvme: Fix typos
Date: Wed, 23 Jul 2025 15:27:51 -0500
Message-ID: <20250723202801.2909506-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in comments.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/nvme/host/apple.c  |  2 +-
 drivers/nvme/host/fc.c     | 10 +++++-----
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/fc.c   |  6 +++---
 drivers/nvme/target/rdma.c |  6 +++---
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1fddfa33ab9..c60f8a5e07a5 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -302,7 +302,7 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 
 	/*
 	 * This lock here doesn't make much sense at a first glace but
-	 * removing it will result in occasional missed completetion
+	 * removing it will result in occasional missed completion
 	 * interrupts even though the commands still appear on the CQ.
 	 * It's unclear why this happens but our best guess is that
 	 * there is a bug in the firmware triggered when a new command
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 014b387f1e8b..2034dd70389a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1363,7 +1363,7 @@ nvme_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
  * down, and the related FC-NVME Association ID and Connection IDs
  * become invalid.
  *
- * The behavior of the fc-nvme initiator is such that it's
+ * The behavior of the fc-nvme initiator is such that its
  * understanding of the association and connections will implicitly
  * be torn down. The action is implicit as it may be due to a loss of
  * connectivity with the fc-nvme target, so you may never get a
@@ -1955,8 +1955,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	/*
-	 * For the linux implementation, if we have an unsucceesful
-	 * status, they blk-mq layer can typically be called with the
+	 * For the linux implementation, if we have an unsuccessful
+	 * status, the blk-mq layer can typically be called with the
 	 * non-zero status and the content of the cqe isn't important.
 	 */
 	if (status)
@@ -2622,7 +2622,7 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
  * as part of the exchange.  The CQE is the last thing for the io,
  * which is transferred (explicitly or implicitly) with the RSP IU
  * sent on the exchange. After the CQE is received, the FC exchange is
- * terminaed and the Exchange may be used on a different io.
+ * terminated and the Exchange may be used on a different io.
  *
  * The transport to LLDD api has the transport making a request for a
  * new fcp io request to the LLDD. The LLDD then allocates a FC exchange
@@ -2777,7 +2777,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
 	 * there is no actual payload to be transferred.
 	 * To get it right, key data transmission on there being 1 or
-	 * more physical segments in the sg list. If there is no
+	 * more physical segments in the sg list. If there are no
 	 * physical segments, there is no payload.
 	 */
 	if (blk_rq_nr_phys_segments(rq)) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..f902bae348f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2548,7 +2548,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	/*
 	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
-	 * from set to unset. If there is a window to it is truely freed,
+	 * from set to unset. If there is a window to it is truly freed,
 	 * pci_free_irq_vectors() jumping into this window will crash.
 	 * And take lock to avoid racing with pci_free_irq_vectors() in
 	 * nvme_dev_disable() path.
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9bd3646568d0..190a4cfa8a5e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -877,7 +877,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..71e3a50d1ff7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2174,7 +2174,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 25598a46bf0d..a9b18c051f5b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -459,7 +459,7 @@ nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
  * down, and the related FC-NVME Association ID and Connection IDs
  * become invalid.
  *
- * The behavior of the fc-nvme target is such that it's
+ * The behavior of the fc-nvme target is such that its
  * understanding of the association and connections will implicitly
  * be torn down. The action is implicit as it may be due to a loss of
  * connectivity with the fc-nvme host, so the target may never get a
@@ -2313,7 +2313,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
 	ret = tgtport->ops->fcp_op(&tgtport->fc_target_port, fod->fcpreq);
 	if (ret) {
 		/*
-		 * should be ok to set w/o lock as its in the thread of
+		 * should be ok to set w/o lock as it's in the thread of
 		 * execution (not an async timer routine) and doesn't
 		 * contend with any clearing action
 		 */
@@ -2629,7 +2629,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
  * and the api of the FC LLDD which may issue a hw command to send the
  * response, but the LLDD may not get the hw completion for that command
  * and upcall the nvmet_fc layer before a new command may be
- * asynchronously received - its possible for a command to be received
+ * asynchronously received - it's possible for a command to be received
  * before the LLDD and nvmet_fc have recycled the job structure. It gives
  * the appearance of more commands received than fits in the sq.
  * To alleviate this scenario, a temporary queue is maintained in the
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 67f61c67c167..0485e25ab797 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1731,7 +1731,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
  * We registered an ib_client to handle device removal for queues,
  * so we only need to handle the listening port cm_ids. In this case
  * we nullify the priv to prevent double cm_id destruction and destroying
- * the cm_id implicitely by returning a non-zero rc to the callout.
+ * the cm_id implicitly by returning a non-zero rc to the callout.
  */
 static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
@@ -1742,7 +1742,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		/*
 		 * This is a queue cm_id. we have registered
 		 * an ib_client to handle queues removal
-		 * so don't interfear and just return.
+		 * so don't interfere and just return.
 		 */
 		return 0;
 	}
@@ -1760,7 +1760,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 
 	/*
 	 * We need to return 1 so that the core will destroy
-	 * it's own ID.  What a great API design..
+	 * its own ID.  What a great API design..
 	 */
 	return 1;
 }
-- 
2.43.0


