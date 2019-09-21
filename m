Return-Path: <SRS0=1PCA=XQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80381C4360D
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2019 20:58:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A01720C01
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2019 20:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATLevrGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A01720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=pN+EzHsOVF9YqMBErbyj//KjsnglSAVLx80TvRjZlgo=; b=ATL
	evrGS+VDg4qgwe0Il1qvptdFz2mW37t8Cbm/2MaazSDfngEXuYesahRrgrQEOhl2XiThinjyklXgm
	Zwh/KZuCzTwYOxgN/ZRLXQrgKgnswdDP0+DoOQvZk8IF6AAXdJ8tj8YXsClQpvqjdgw/fYinsxZvG
	HZUcqV6wlQOO+RBEFwUxJBbsBvutfdLVGQRcPyAlRwYXeL9lj41CvoCGMkNyRawVmAvA0uIdmMf/J
	mRkY5Q8SsMycDUDMCYr+Lac6duk4MhpKvcK9wHp93ph6xxT/ZTZBvIR3hBP6zn44zOWLK+GaIS3x1
	4K11YRQQtgxf3pVa+tODwjHP1uH764g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBmSh-0007df-O2; Sat, 21 Sep 2019 20:58:35 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBmSc-0007dE-Nn
 for linux-nvme@lists.infradead.org; Sat, 21 Sep 2019 20:58:34 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 21 Sep 2019 23:58:20 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8LKwKiW024633;
 Sat, 21 Sep 2019 23:58:20 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH v2 1/1] nvme-rdma: Fix max_hw_sectors calculation
Date: Sat, 21 Sep 2019 23:58:19 +0300
Message-Id: <1569099499-24017-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190921_135832_822671_F9E53C52 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: keith.busch@intel.com, shlomin@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

By default, the NVMe/RDMA driver should support max io_size of 1MiB (or
upto the maximum supported size by the HCA). Currently, one will see that
/sys/class/block/<bdev>/queue/max_hw_sectors_kb is 1020 instead of 1024.

A non power of 2 value can cause performance degradation due to
unnecessary splitting of IO requests and unoptimized allocation units.

The number of pages per MR has been fixed here, so there is no longer any
need to reduce max_sectors by 1.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v1:
 - added Reviewed-by signature
 - rebase over nvme-5.4

---
 drivers/nvme/host/rdma.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5e30bcf..fb02986 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -427,7 +427,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
 {
 	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		     ibdev->attrs.max_fast_reg_page_list_len);
+		     ibdev->attrs.max_fast_reg_page_list_len - 1);
 }
 
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
@@ -437,7 +437,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	const int cq_factor = send_wr_factor + 1;	/* + RECV */
 	int comp_vector, idx = nvme_rdma_queue_idx(queue);
 	enum ib_poll_context poll_ctx;
-	int ret;
+	int ret, pages_per_mr;
 
 	queue->device = nvme_rdma_find_get_device(queue->cm_id);
 	if (!queue->device) {
@@ -479,10 +479,16 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		goto out_destroy_qp;
 	}
 
+	/*
+	 * Currently we don't use SG_GAPS MR's so if the first entry is
+	 * misaligned we'll end up using two entries for a single data page,
+	 * so one additional entry is required.
+	 */
+	pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev) + 1;
 	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
 			      queue->queue_size,
 			      IB_MR_TYPE_MEM_REG,
-			      nvme_rdma_get_max_fr_pages(ibdev), 0);
+			      pages_per_mr, 0);
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
@@ -814,8 +820,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_stop_queue;
 
-	ctrl->ctrl.max_hw_sectors =
-		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
+	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
+	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
