Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D16C433EC
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0542070E
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bIWmOVVJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="saPSIzft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0542070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QHnDx4T1IQpQVKpHLgHe+MeNOEKoKrH3kqEfeRjDYQc=; b=bIWmOVVJ5FSiAyNdur5VzrrUu
	F2zQsW0yZu68X8wWWmvhF42FE0RGDEysHBJtMAfduiBFTtq0YKXzwnYkDZtMY5fZOcfQ9McwtEnHn
	ymHNyP7Bkal9a9kq2eUbgZ+WKGvoSAEzgnpQyBfLRkTS+JxifKrMA2pUMRCtjX8vNRL1ZXNdwv39c
	ckd4wSRmBCZ8G5zRdj2Pa4xqqYIqgHCVgyGkyLVskKebkh6SeWQCQqjaP9dWQVPhDXF1PCzVKvD9c
	hPR/lD41+KMrHQbiE/Fng/vD+U5YG1p17R34YrmlMGkYG1JnC29/R8HYMLA+Kd+JHJHukVvOV01ja
	XpIQ4yq6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz1Rz-0003hS-6r; Fri, 24 Jul 2020 17:25:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz1Ro-0003cW-Qj
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 17:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2UfxIISUaPeKQG++CK8g3xGqVmbeNNUeZkMHeeWJQ1w=; b=saPSIzftg6ezGmgLjTkCLiv+Ii
 Y7bozgRTJikeP4c0oDmcT01NQYyTCUZLTYCwzwhq86ooCZlZsA+d9bZ7mp4dES09I/8dGPRKQxLh2
 4fSEFPbQLLYQcuS6vtb3vQFNM5hBFtREEmZFTg0EelhRJLIYEzHxbhX8e60X92GMvV5J32gN+jWXl
 /05eqql1qgRmiWNvqRa7oEIjRtZ5e9tAHoczSiu1u4OLMpndSsDkqo8p9QbVkq4LmY4j00L1VPBJ8
 eEdDUQ+KfkstrkMGBR/HJEasXMYWTGp7kQrl52VfgTDjnZiQpZVtJ0YM068/0sOH7k56gfvnYyOR5
 WzP6n4TA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1jz1Rk-0006yn-5m; Fri, 24 Jul 2020 11:25:28 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1jz1Rh-0004G6-VE; Fri, 24 Jul 2020 11:25:22 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 24 Jul 2020 11:25:12 -0600
Message-Id: <20200724172520.16318-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 1/9] nvme-core: Clear any SGL flags in passthru commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_132528_881329_F38DAB5D 
X-CRM114-Status: GOOD (  11.43  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The host driver should decide whether to use SGLs or PRPs and they
currently assume the flags are cleared after the call to
nvme_setup_cmd(). However, passed-through commands may erroneously
set these bits; so clear them for all cases.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d7c7afb1348..6f80bd78eba6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -593,6 +593,14 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
 		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
 }
 
+static void nvme_setup_passthrough(struct request *req,
+		struct nvme_command *cmd)
+{
+	memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
+	/* passthru commands should let the driver set the SGL flags */
+	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
+}
+
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
@@ -758,7 +766,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
 	case REQ_OP_DRV_OUT:
-		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
+		nvme_setup_passthrough(req, cmd);
 		break;
 	case REQ_OP_FLUSH:
 		nvme_setup_flush(ns, cmd);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
