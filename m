Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C542AC3F2D7
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:55:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB0C208CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NL0/Jc09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB0C208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvKs2m08UunBet2AAQEtdvu1iPfnnCmHdSn0yeR5qxE=; b=NL0/Jc09uIGHwC
	U3KPmZ0AgL/fCZEcP5MdsyMWHW9VMScZIenwF/U44LEd+C8K/RQxenNxFc5mhSrKA/S40Q7lbbMCs
	Ranw9501DqjVu6Qsv4SlNLYaIOFONhk6hLGQDYF/lDoCVWiIDq51rNKjmk0qWtN7bKHEpUbXC9ssu
	RFvgfQgcUq0yakgutOsk2cg77Tmim9CxiVAeW5vnK4LjfeYt++eDYb495c1q9DHgB1RxPO4Q01SpO
	Ufw9XWMb/27KsZE7AOiCyGmsTYPBO/0ShewvbkWaVbcSUde7bnIqGJ1pIj8Zv7uq573RwW86E37zn
	LboK0RRqCUr6vv3JJKDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9nEH-0001As-AD; Thu, 05 Mar 2020 09:55:45 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9nEB-00012S-7m
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 09:55:41 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Mar 2020 11:55:31 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0259tUhQ020720;
 Thu, 5 Mar 2020 11:55:30 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: jgg@mellanox.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com
Subject: [PATCH V2 3/3] nvmet-rdma: allocate RW ctxs according to mdts
Date: Thu,  5 Mar 2020 11:55:30 +0200
Message-Id: <20200305095530.132858-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200305095530.132858-1-maxg@mellanox.com>
References: <20200305095530.132858-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_015539_680525_56F5BF78 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: krishna2@chelsio.com, Max Gurtovoy <maxg@mellanox.com>, bharat@chelsio.com,
 nirranjan@chelsio.com, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Current nvmet-rdma code allocates MR pool budget based on queue size,
assuming both host and target use the same "max_pages_per_mr" count.
After limiting the mdts value for RDMA controllers, we know the factor
of maximum MR's per IO operation. Thus, make sure MR pool will be
sufficient for the required IO depth and IO size.

That is, say host's SQ size is 100, then the MR pool budget allocated
currently at target will also be 100 MRs. But 100 IO WRITE Requests
with 256 sg_count(IO size above 1MB) require 200 MRs when target's
"max_pages_per_mr" is 128.

Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from V1:
 - added "Reviewed-by" signature (Christoph)

---
 drivers/nvme/target/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index d12ef0d..daab656 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -976,7 +976,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 {
 	struct ib_qp_init_attr qp_attr;
 	struct nvmet_rdma_device *ndev = queue->dev;
-	int comp_vector, nr_cqe, ret, i;
+	int comp_vector, nr_cqe, ret, i, factor;
 
 	/*
 	 * Spread the io queues across completion vectors,
@@ -1009,7 +1009,9 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	qp_attr.qp_type = IB_QPT_RC;
 	/* +1 for drain */
 	qp_attr.cap.max_send_wr = queue->send_queue_size + 1;
-	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size;
+	factor = rdma_rw_mr_factor(ndev->device, queue->cm_id->port_num,
+				   1 << NVMET_RDMA_MAX_MDTS);
+	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size * factor;
 	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
 					ndev->device->attrs.max_send_sge);
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
