Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE52C10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D3420757
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnehtmmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D3420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/fVGGwpvJ34wT0lX1OPO3aJDH8Toj+J1imrbomtBZg=; b=jnehtmmbyHJGCU
	CYomTcIqnYA1ptPLPwpAyMlRV70eFOmYdCzEjqQXKPcCSgM4VPeRV/R9bQQFuV0Xh9bCAZ7zZtiHM
	z5oBaOxM2faCg6rJuiGCY3a/Y1vF0H7iLXUjSKqGTLA8F7TMO9jlpAxeb+E9ZE+owZDrO6wc9H7Qk
	orAgssz/mnKBgWQAX/wExkkrbwku+Y2RBXAk9jWAUdIzfgZtii/S/TfP+8KkvcKHyq+1Z5Ql6Kq2z
	c+8O39t85/gR5JrsrqsBav2jsKdocpEhsGeGTCa8VznqqLR8iEOtimm/xMBynniYkFJ3DWUqXIq0c
	x1KCPsTIBq+UHqbRpNlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEaDt-0001yw-K4; Wed, 18 Mar 2020 15:03:09 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEaDp-0001wF-Ow
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 15:03:07 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 18 Mar 2020 17:02:57 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02IF2vEM008733;
 Wed, 18 Mar 2020 17:02:57 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Date: Wed, 18 Mar 2020 17:02:54 +0200
Message-Id: <20200318150257.198402-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_080306_233378_AB5F4745 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: rgirase@redhat.com, vladimirk@mellanox.com, shlomin@mellanox.com,
 leonro@mellanox.com, dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>, idanb@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparetion patch for the SRQ per completion vector feature.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..04062af 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -38,6 +38,7 @@ struct nvmet_rdma_cmd {
 	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
 	struct nvme_command     *nvme_cmd;
 	struct nvmet_rdma_queue	*queue;
+	struct ib_srq		*srq;
 };
 
 enum {
@@ -461,8 +462,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		cmd->sge[0].addr, cmd->sge[0].length,
 		DMA_FROM_DEVICE);
 
-	if (ndev->srq)
-		ret = ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
+	if (cmd->srq)
+		ret = ib_post_srq_recv(cmd->srq, &cmd->wr, NULL);
 	else
 		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
 
@@ -882,6 +883,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	ndev->srq_size = srq_size;
 
 	for (i = 0; i < srq_size; i++) {
+		ndev->srq_cmds[i].srq = srq;
 		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
 		if (ret)
 			goto out_free_cmds;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
