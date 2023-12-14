Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF4AC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DmrzEFB8s8PeKQeuKNNWPl0mUDFCnEXWxD6UvA8A1bM=; b=gSSilt3oKQ/ByBVADrC3JVKle7
	WiJIiGZAvx9zWUgU+Dnq9afO0XvQR/MaXoHSeP/7jjnmYIfmz6z2Co/26twX0F8uJGpDbkxNn1HLI
	ceR0C/skTK6V71Owkjy4ZDColVDOgXjqnSYTu2ZTrFHdBQmroY9jMB78FLgZlacr5cR0sLlJh9t1s
	lK5GeYohEQ0lUMVsK40eLDZ88/nt02vutf//OqNx6mBeWOgNZR7LEGPpqjGeX92X3Mkx7QRJkbn40
	yRJL8/GP4vubQEDBYnoeQG2IW65OY5BbEkumUU89ugc4IiCui2dL0v4CZvgFCb61OH24IJw7sdbSZ
	VtKkwNKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDmq4-000Z15-1s;
	Thu, 14 Dec 2023 14:37:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDmq1-000Z07-2t
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 14:37:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CA3968AFE; Thu, 14 Dec 2023 15:37:09 +0100 (CET)
Date: Thu, 14 Dec 2023 15:37:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231214143708.GA5331@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_063722_241159_17754C05 
X-CRM114-Status: GOOD (  19.23  )
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

On Wed, Dec 13, 2023 at 04:27:35PM +0000, John Garry wrote:
>>> Are there any patches yet for the change to always use SGLs for transfers
>>> larger than a single PRP?
>> No.

Here is the WIP version.  With that you'd need to make atomic writes
conditional on !ctrl->need_virt_boundary.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f78..e04faffd6551fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1889,7 +1889,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
+	if (q == ctrl->admin_q || ctrl->need_virt_boundary)
+		blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 3);
 	blk_queue_write_cache(q, vwc, vwc);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f725..aa98794a3ec53d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -262,6 +262,7 @@ enum nvme_ctrl_flags {
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
+	bool need_virt_boundary;
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61af7ff1a9d6ba..a8d273b475cb40 100644
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
@@ -769,12 +751,14 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	bool sgl_supported = nvme_ctrl_sgl_supported(&dev->ctrl) &&
+			nvmeq->qid && sgl_threshold;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -782,8 +766,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
+			if (sgl_supported)
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
 		}
@@ -806,7 +789,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (sgl_supported)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
@@ -3036,6 +3019,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = nvme_init_ctrl_finish(&dev->ctrl, false);
 	if (result)
 		goto out_disable;
+	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
+		dev->ctrl.need_virt_boundary = true;
 
 	nvme_dbbuf_dma_alloc(dev);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 81e2621169e5d3..416a9fbcccfc74 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -838,6 +838,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
 		goto out_quiesce_queue;
+	ctrl->ctrl.need_virt_boundary = true;
 
 	return 0;
 

