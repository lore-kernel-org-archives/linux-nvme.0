Return-Path: <SRS0=zMYu=ZQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF971C432C0
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 16:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5D92075E
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 16:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bpriDppn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5D92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vZWyPNopcOXTQll4amCsbofMxEU/oxFf1bVpXY9Vffg=; b=bpriDppnP4uOguYSIiLtu5/nLt
	I4XpAvrM6JjqHdbHldWrhzYOZp6AZRKC/t7Mu96g5fIXsxvPMN/qEkd9n775TPJJv/lqx6b7ei1HM
	g/HEafC38XCx86F6iE1xK7W0b5FDjRY2EZDIzirYYc/aiUJvjzCV3lYyyjrWKb7Wxg3aq1tcPcBhN
	eTddrBRAVuQzC4A3aD2W0Nyjhq+xRYTUc+CZG4O7ek1mvCHYo+ZgOUhbPsNqsKQm5OjI9ZC8CoNdY
	pHToGJw1CaLgPyatKJPDKPdjzkvdXl3XkXX8SWLQqbMhx/oaJ7cV19xyP0Fz3LSm/bf8PDE4xW9Dw
	TAXitMKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYuui-0005t6-UW; Sun, 24 Nov 2019 16:39:08 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYuuc-0005pK-PB
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 16:39:04 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 24 Nov 2019 18:38:49 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xAOGcm6L029897;
 Sun, 24 Nov 2019 18:38:49 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 James Smart <jsmart2021@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] nvmet-loop: Avoid preallocating big SGL for data
Date: Sun, 24 Nov 2019 18:38:32 +0200
Message-Id: <1574613512-5943-4-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1574613512-5943-1-git-send-email-israelr@mellanox.com>
References: <1574613512-5943-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_083903_225737_A51E7FE4 
X-CRM114-Status: UNSURE (   9.99  )
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
Cc: Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_loop_create_io_queues() preallocates a big buffer for the IO SGL based
on SG_CHUNK_SIZE.

Modern DMA engines are often capable of dealing with very big segments so
the SG_CHUNK_SIZE is often too big. SG_CHUNK_SIZE results in a static 4KB
SGL allocation per command.

If a controller has lots of deep queues, preallocation for the sg list can
consume substantial amounts of memory. For nvmet-loop, nr_hw_queues can be
128 and each queue's depth 128. This means the resulting preallocation
for the data SGL is 128*128*4K = 64MB per controller.

Switch to runtime allocation for SGL for lists longer than 2 entries. This
is the approach used by NVMe PCI so it should be reasonable for NVMeOF as
well. Runtime SGL allocation has always been the case for the legacy I/O
path so this is nothing new.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 856eb06..dae31bf 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -76,7 +76,7 @@ static void nvme_loop_complete_rq(struct request *req)
 {
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 
-	sg_free_table_chained(&iod->sg_table, SG_CHUNK_SIZE);
+	sg_free_table_chained(&iod->sg_table, NVME_INLINE_SG_CNT);
 	nvme_complete_rq(req);
 }
 
@@ -156,7 +156,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		iod->sg_table.sgl = iod->first_sgl;
 		if (sg_alloc_table_chained(&iod->sg_table,
 				blk_rq_nr_phys_segments(req),
-				iod->sg_table.sgl, SG_CHUNK_SIZE))
+				iod->sg_table.sgl, NVME_INLINE_SG_CNT))
 			return BLK_STS_RESOURCE;
 
 		iod->req.sg = iod->sg_table.sgl;
@@ -340,7 +340,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
 	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
@@ -514,7 +514,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	ctrl->tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
 	ctrl->tag_set.driver_data = ctrl;
 	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
 	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
