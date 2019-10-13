Return-Path: <SRS0=ek/0=YG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41576C4CECE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Oct 2019 16:58:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8CF20679
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Oct 2019 16:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C8XlARER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8CF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/V1sgHet5oLpdo81PWNRUv4wuz7x4gkFdBmJd2LHBAI=; b=C8XlARERWqLaCkziiGClNx8oiQ
	Cy9MR8Bft+/44uamw4pFprUroEJEYiq/EUAb76U/Zd59IYYkUqZ3osLSjOK4bjUC7qgEXTijUla13
	DPjNaM5gnNTtmCK2DbNq9P0YPaWMrEcUEXDm9NGEOBuBNrJOF/mo8M3T/ym5SjkI5cYr4k/k7eXzJ
	yPXs/iqii1YHklQ+jfTzDvb3cQEYKbraecYXvmLxXZBJOe7rtIyOSO+R4xWAiWuqQ8DbnHYsm/Ujr
	LVIinISl3W9dY6jH5aQ8qZCiYpL7S6rCHBCg1HFP1OtgXtZVE+qoahxr+UIu6Bz7Pxd9huHcvm7rQ
	I83jpU2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iJhCi-0005k5-AO; Sun, 13 Oct 2019 16:58:48 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iJhBp-0004u4-09
 for linux-nvme@lists.infradead.org; Sun, 13 Oct 2019 16:57:56 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 13 Oct 2019 18:57:40 +0200
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9DGvdoP005965;
 Sun, 13 Oct 2019 19:57:39 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Subject: [PATCH 4/8] nvmet-rdma: add unlikely check at nvmet_rdma_map_sgl_keyed
Date: Sun, 13 Oct 2019 19:57:34 +0300
Message-Id: <1570985858-26805-5-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
References: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191013_095753_459907_628C8B8B 
X-CRM114-Status: UNSURE (   7.94  )
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
Cc: israelr@mellanox.com, james.smart@broadcom.com, shlomin@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

The calls to nvmet_req_alloc_sgl and rdma_rw_ctx_init should usually
succeed, so add this simple optimization to the fast path.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 36d906a..ccf9821 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -672,13 +672,13 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 		return 0;
 
 	ret = nvmet_req_alloc_sgl(&rsp->req);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		goto error_out;
 
 	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
 			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
 			nvmet_data_dir(&rsp->req));
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		goto error_out;
 	rsp->n_rdma += ret;
 
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
