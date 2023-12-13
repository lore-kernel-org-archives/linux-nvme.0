Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46054C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdgSwDZnwdtcYW2qQcEA3qeP8czNBbc/Eeap5JjHris=; b=B2hXVtFTi5dyUAX/mpLEtdbcIR
	LjwgpetYiIPAOpd51fZH/8Eb1cQOuTQq0CqwB63hg/nqxgVQdEg3vhkJRvx6NEQWdYJqebbE+BegX
	EslZ5Lkp25IfYy+8THKy3BHFI7kaDNs8+rVKfJOFqVQ60HhHuys5NJa4j5TyV0v/vl5a5uTVPW93x
	FviSdj1Bnv9H+csUhyJazS/By8Sw8Hz5XMwhZI9puFK5P/Q5qbjLYUM6iwHvk60rVQwRZONKDQVn3
	m905EvstC565BKwckT2IX6SUFP9NGnE+RIxkv2X6teePBJRtNiZ2mt3ok8zTyzbHN/fc13095IPbr
	G8MnHGyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIny-00Dn5Z-10;
	Wed, 13 Dec 2023 06:33:14 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDInv-00Dn1T-1H
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 06:33:12 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyP5L6h_1702449179;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyP5L6h_1702449179)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 14:33:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/5] nvmet: fix wrong error handling approach in nvmet_install_queue
Date: Wed, 13 Dec 2023 14:32:48 +0800
Message-Id: <1702449172-8920-2-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_223311_620493_A3FB956F 
X-CRM114-Status: UNSURE (   8.84  )
X-CRM114-Notice: Please train this message.
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

In the nvmet_install_queue() function, do not set the ctrl pointer
to NULL if the sqsize check fails.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840..9cffb64 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -147,8 +147,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
-		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
-		goto err;
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	}
 
 	if (ctrl->sqs[qid] != NULL) {
-- 
1.8.3.1


