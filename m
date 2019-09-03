Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3AEC3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 15:14:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB1B2339D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m80bfQmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB1B2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wOeDinEhK0xTD9fYTkKRC5LTsDsYa2Phdhf3GSmlasg=; b=m80bfQmwhC4NN+K96v1b3wQIkH
	f7nx5Kvg2/SxtaLPjRRDxp9X8WM0TRP+y2KxwFnn0jQduXiTk1B17w+2E6+FxgNdzT+qqd87oQxE9
	/RQKfv0eSHDczuYNjf2u5ddZhs0tDXEPDvApe89GsB387DGhGnveAGuAYh0TCsHZFBn3Lh6B4rJPc
	27KsGcha4LMjALP+FXcxYeOUqPlj+4ZbHWnTRHAObfwPLfJArOsEKzWdc5Fm4EPj+UBtkkJzQFhsZ
	hYWhOGL1POafLHkQfXMGe8jWhw1Ua6AgACt9JbK+v1AwvbPK1gorik5UHG7SdR5mKCibfonz0gf9w
	xb11U5TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5AVm-0000Rd-KG; Tue, 03 Sep 2019 15:14:26 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i5AVi-0000PV-L7
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 15:14:24 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 3 Sep 2019 18:14:15 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x83FEFl2016624;
 Tue, 3 Sep 2019 18:14:15 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 2/4] nvme-rdma: simplify error flow in nvme_rdma_queue_rq
Date: Tue,  3 Sep 2019 18:14:13 +0300
Message-Id: <1567523655-23989-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_081423_080922_E5A01380 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <maxg@mellanox.com>, shlomin@mellanox.com,
 israelr@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Make the error flow symmetric to the good flow by moving the call to
nvme_cleanup_cmd from nvme_rdma_unmap_data function.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1a6449b..db4a60f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1149,7 +1149,6 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 			req->nents, rq_data_dir(rq) ==
 				    WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	nvme_cleanup_cmd(rq);
 	sg_free_table_chained(&req->sg_table, SG_CHUNK_SIZE);
 }
 
@@ -1748,7 +1747,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
 			     "Failed to map data (%d)\n", err);
-		nvme_cleanup_cmd(rq);
 		goto err;
 	}
 
@@ -1759,18 +1757,19 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
-	if (unlikely(err)) {
-		nvme_rdma_unmap_data(queue, rq);
-		goto err;
-	}
+	if (unlikely(err))
+		goto err_unmap;
 
 	return BLK_STS_OK;
 
+err_unmap:
+	nvme_rdma_unmap_data(queue, rq);
 err:
 	if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
 	else
 		ret = BLK_STS_IOERR;
+	nvme_cleanup_cmd(rq);
 unmap_qe:
 	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
@@ -1791,6 +1790,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	struct ib_device *ibdev = queue->device->dev;
 
 	nvme_rdma_unmap_data(queue, rq);
+	nvme_cleanup_cmd(rq);
 	ib_dma_unmap_single(ibdev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
 	nvme_complete_rq(rq);
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
