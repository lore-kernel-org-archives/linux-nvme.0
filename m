Return-Path: <SRS0=8bm+=4Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A2CC10DCE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2020 10:56:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CD3206D7
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2020 10:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fNDWZPXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OMYtlvi5cgVEklUbUA93AKHSUnKkn3BqX936QhXi5AE=; b=fNDWZPXeQ6+A7s
	J/30CcXU3iKZ9YubIsdtcrvPXEfWxi0KvPCjTzTKZQF2zPiYaKoz1maMQzTRLWV1bzpYB0nHw+Tin
	fu3FLMtb1osCebjypkQqyGiFm8Z07CknvBPJnP/lt1sRKirKgWUmRORj0HWQas9BHKiMTYcMq5STS
	IhnD2lasIs+I6WigVWcHlOP29U73k0TPbMem6qb8qzYB9QSz2jKwivV0DdOekwkIQE1bPv5YFtsWl
	Zw2DHC0Bk1PfCwyKuZMA+7tBNKOhkKuj8X58JJdyj+X+geT9+s1hOlZnQ/4bJz9mZeHP0DZ5YlUPX
	zdIUPvSElO/zdO/UtTqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jAtc0-0002Rl-Mq; Sun, 08 Mar 2020 10:56:48 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jAtaU-0000Oj-CS
 for linux-nvme@lists.infradead.org; Sun, 08 Mar 2020 10:55:17 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 8 Mar 2020 12:55:06 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 028At5GP004210;
 Sun, 8 Mar 2020 12:55:05 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: jgg@mellanox.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org
Subject: [PATCH 3/3] nvmet-rdma: allocate RW ctxs according to mdts
Date: Sun,  8 Mar 2020 12:55:05 +0200
Message-Id: <20200308105505.14305-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200308105505.14305-1-maxg@mellanox.com>
References: <20200308105505.14305-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200308_035514_870255_F6FBF7BD 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: bvanassche@acm.org, vladimirk@mellanox.com, bharat@chelsio.com,
 nirranjan@chelsio.com, shlomin@mellanox.com, krishna2@chelsio.com,
 Max Gurtovoy <maxg@mellanox.com>
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from V2:
 - added "Reviewed-by" signature (Sagi)

changes from V1:
 - added "Reviewed-by" signature (Christoph)

---
 drivers/nvme/target/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f47a79b..9e1b8c6 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -978,7 +978,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 {
 	struct ib_qp_init_attr qp_attr;
 	struct nvmet_rdma_device *ndev = queue->dev;
-	int comp_vector, nr_cqe, ret, i;
+	int comp_vector, nr_cqe, ret, i, factor;
 
 	/*
 	 * Spread the io queues across completion vectors,
@@ -1011,7 +1011,9 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
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
