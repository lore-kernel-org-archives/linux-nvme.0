Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65335C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/qwG5mBxv+OXltfnBhULUp12d0aCunl1R+WxXEqsVM=; b=qD93fzyVbcYwTwKpuWR0ojhvOp
	1PZzvikP6V21/7ppbU0RjL4zcamTlDbH3TUhnajOkDCJOW/y6+1UCBmiN1au8bM78CLZYWf/L47Ai
	a8wCBIsvx5i5MnZCyTo3V6b8kLslmu2uoTK3WGmY6sHdx8fw5tJrQXoW49uM5uj8zFGd/pZOQ7UdO
	mLiw4cG8O0W/cUCklSKCqKPz7Q2PCEJ7LkXDDv7+Rkh4UWrQ6pKgNOmyVtdE79tQsAoXrJ9A2KyWM
	ZQ2BP+uHHKDi5TTyDIa8RjEFJ3Tnbor/XkpyD0uDxl7gth6n1p+XkIfAqg/nXcIN47pGah2eVJPLh
	r3SJNFow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagvJ-005O1r-SG; Tue, 20 Sep 2022 17:20:42 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaguL-005NPw-MW; Tue, 20 Sep 2022 17:19:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: improve the NVME_CONNECT_AUTHREQ* definitions
Date: Tue, 20 Sep 2022 19:19:30 +0200
Message-Id: <20220920171931.1289669-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171931.1289669-1-hch@lst.de>
References: <20220920171931.1289669-1-hch@lst.de>
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

Mark them as unsigned so that we don't need extra casts, and define
them relative to cdword0 instead of requiring extra shifts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fabrics-cmd.c | 6 ++----
 include/linux/nvme.h              | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index c7e903589d377..618f7adca70fd 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -272,8 +272,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 	if (nvmet_has_auth(ctrl))
-		req->cqe->result.u32 |=
-			cpu_to_le32((u32)NVME_CONNECT_AUTHREQ_ATR << 16);
+		req->cqe->result.u32 |= cpu_to_le32(NVME_CONNECT_AUTHREQ_ATR);
 out:
 	kfree(d);
 complete:
@@ -334,8 +333,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 	if (nvmet_has_auth(ctrl))
-		req->cqe->result.u32 |=
-			cpu_to_le32((u32)NVME_CONNECT_AUTHREQ_ATR << 16);
+		req->cqe->result.u32 |= cpu_to_le32(NVME_CONNECT_AUTHREQ_ATR);
 
 out:
 	kfree(d);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ae53d74f3696a..050d7d0cd81b0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1482,8 +1482,8 @@ struct nvmf_connect_command {
 };
 
 enum {
-	NVME_CONNECT_AUTHREQ_ASCR	= (1 << 2),
-	NVME_CONNECT_AUTHREQ_ATR	= (1 << 1),
+	NVME_CONNECT_AUTHREQ_ASCR	= (1U << 18),
+	NVME_CONNECT_AUTHREQ_ATR	= (1U << 17),
 };
 
 struct nvmf_connect_data {
-- 
2.30.2


