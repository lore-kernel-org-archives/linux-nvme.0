Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FA2C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 08:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q1cLvrTcZUprlxPErtndCbzhW70UICoQe1+wCr2ZPTk=; b=HWMalZOMOfvUekL+1oyNQyqbuZ
	8tVIcI/kBRqg3601+N8miKx8+HcBRi8eNz7t3h+b6r7gygxC53aTMiu3r3b1lNCaV3cC1NcSHJdVv
	YeBD35BMU57B+KIPLYHVArAvIxNdobbH9Gl8s8fZNtX8hcYBbkAiFO+L7mKADELs6WoAuR2VBKGPr
	hdZ70nHVR5FtNt1bhjC1X2pGLvp9mYU5RidwNF5u95wucjJZ7q4GyNd5jk3dHTh0f7JujoLXss5sd
	Aj74RLhjOfd45zyYi28ThQHzfMQ1e7Mf+fjim/mGRI6DQv6jOSURmgk34Ye8IhZGeso1XnLq7Uuwy
	Hm6yUnDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGEjg-0025BD-1i;
	Thu, 21 Dec 2023 08:48:56 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGEjc-00257z-2f;
	Thu, 21 Dec 2023 08:48:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: marcan@marcan.st,
	sven@svenpeter.dev,
	kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	james.smart@broadcom.com
Cc: alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com
Subject: [PATCH] nvme: don't set a virt_boundary unless needed
Date: Thu, 21 Dec 2023 09:48:53 +0100
Message-Id: <20231221084853.1175482-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

NVMe PRPs are a pain and force the expensive virt_boundary checking on
block layer, prevent secure passthrough and require scatter/gather I/O
to be split into multiple commands which is problematic for the upcoming
atomic write support.

Fix the NVMe core to require an opt-in from the drivers for it.

For nvme-apple it is always required as the driver only supports PRPs.

For nvme-pci when SGLs are supported we'll always use them for data I/O
that would require a virt_boundary.

For nvme-rdma the virt boundary is always required, as RMDA MRs are just
as dumb as NVMe PRPs.

For nvme-tcp and nvme-fc I set the flags for now because I don't
understand the drivers fully, but I suspect the flags could be lifted.

For nvme-loop the flag is never set as it doesn't have any requirements
on the I/O format.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c |  6 +++++
 drivers/nvme/host/core.c  | 11 ++++++++-
 drivers/nvme/host/fc.c    |  3 +++
 drivers/nvme/host/nvme.h  |  4 +++
 drivers/nvme/host/pci.c   | 52 ++++++++++++++++++++++-----------------
 drivers/nvme/host/rdma.c  |  6 +++++
 drivers/nvme/host/tcp.c   |  3 +++
 7 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5a9..a1afb54e3b4da8 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1116,6 +1116,12 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+	/*
+	 * nvme-apple always uses PRPs and thus needs to set a virt boundary.
+	 */
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &anv->ctrl.flags);
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &anv->ctrl.flags);
+
 	ret = nvme_init_ctrl_finish(&anv->ctrl, false);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 22dae2a26ba493..e2816c588c65d1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1872,6 +1872,14 @@ static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
+static bool nvme_need_virt_boundary(struct nvme_ctrl *ctrl,
+		struct request_queue *q)
+{
+	if (q == ctrl->admin_q)
+		return test_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &ctrl->flags);
+	return test_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &ctrl->flags);
+}
+
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
@@ -1885,7 +1893,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
+	if (nvme_need_virt_boundary(ctrl, q))
+		blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 3);
 	blk_queue_write_cache(q, vwc, vwc);
 }
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9f9a3b35dc64d3..b4540fb31a0d0b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3112,6 +3112,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	set_bit(NVME_FC_Q_LIVE, &ctrl->queues[0].flags);
 
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &ctrl->ctrl.flags);
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &ctrl->ctrl.flags);
+
 	/*
 	 * Check controller capabilities
 	 *
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3dbd187896d8d8..dac000291a09ae 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -252,6 +252,10 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STOPPED		= 3,
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
+	/* set the virt_boundary on the admin queue */
+	NVME_CTRL_VIRT_BOUNDARY_ADMIN	= 6,
+	/* set the virt_boundary on the I/O queues */
+	NVME_CTRL_VIRT_BOUNDARY_IO	= 7,
 };
 
 struct nvme_ctrl {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046dc8..6be2e827c426ba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,8 +60,7 @@ MODULE_PARM_DESC(max_host_mem_size_mb,
 static unsigned int sgl_threshold = SZ_32K;
 module_param(sgl_threshold, uint, 0644);
 MODULE_PARM_DESC(sgl_threshold,
-		"Use SGLs when average request segment size is larger or equal to "
-		"this size. Use 0 to disable SGLs.");
+		"Use SGLs when > 0. Use 0 to disable SGLs.");
 
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
@@ -504,23 +503,6 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
-				     int nseg)
-{
-	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	unsigned int avg_seg_size;
-
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
-
-	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
-		return false;
-	if (!nvmeq->qid)
-		return false;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return false;
-	return true;
-}
-
 static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
 {
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
@@ -769,12 +751,20 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	bool sgl_supported;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
+	/*
+	 * Check the NVME_CTRL_VIRT_BOUNDARY_IO flag to see if the controller
+	 * supports SGLs, as the sgl_threshold module paramter can be changed
+	 * at runtime.
+	 */
+	sgl_supported = nvmeq->qid &&
+		test_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &dev->ctrl.flags);
 	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -782,8 +772,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
+			if (sgl_supported)
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
 		}
@@ -806,7 +795,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (sgl_supported)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
@@ -3019,10 +3008,27 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_disable;
 	}
 
+	/*
+	 * The admin queue alwyas uses PRPs and thus needs to set the
+	 * virt_boundary to avoid offsets into subsequent PRPs.
+	 */
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &dev->ctrl.flags);
+
 	result = nvme_init_ctrl_finish(&dev->ctrl, false);
 	if (result)
 		goto out_disable;
 
+	/*
+	 * If the controller supports SGLs we'll always use them for non-trivial
+	 * I/O on the I/O queues unless they were explicitly disabled using the
+	 * module paramater. 
+	 *
+	 * This removes the need for the virt_boundary and thus expensive
+	 * checking in the block layer.
+	 */
+	if (!nvme_ctrl_sgl_supported(&dev->ctrl) || !sgl_threshold)
+		set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &dev->ctrl.flags);
+
 	nvme_dbbuf_dma_alloc(dev);
 
 	result = nvme_setup_host_mem(dev);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bc90ec3c51b078..7f017b54cc7fd0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -822,6 +822,12 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_remove_admin_tag_set;
 
+	/*
+	 * RDMA MRs don't allow offsets into subsequent pages, just like PRPs.
+	 */
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &ctrl->ctrl.flags);
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &ctrl->ctrl.flags);
+
 	error = nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
 		goto out_stop_queue;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d79811cfa0ce88..cc29c7899e805a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2097,6 +2097,9 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_cleanup_tagset;
 
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &ctrl->flags);
+	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &ctrl->flags);
+
 	error = nvme_enable_ctrl(ctrl);
 	if (error)
 		goto out_stop_queue;
-- 
2.39.2


