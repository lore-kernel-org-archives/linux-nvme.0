Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EBBC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=++KLZ1sY/CWAMutihCtwPhkvNB7oEVFJk3Up/NOCaO4=; b=mGZ0VZQtbV0LcQHTUIuaEuGmVF
	4LQ2UVJhtgrf8GR+vMm8KlFkFFzkJDcPO8TjPE9rshBYw1IKWDDJk6jzM85Sn7RO+mWwruXXjyfrm
	2qlP4ZOsHZXh/GzqFGpRbg0RJusv2N8jkvmW8qTmj0UWdpJ+zDUbWLqT7vt8If5mJWkmXWwCZUMlL
	lhwaP0RaOXugm/HCi1jQdmiGNhspMPBLX1Oe/WmimW4zGqwggUtGF3q73xNTG9E4Uf4ZrnW5t5kjh
	qr4Qq2NX8JYcW8dNnZYn/TPmGPNe6kN5fk8DikMwZr5Vu3KiiJEyJ81jjeN52JjhwZyfgBEKd7goU
	Dms5rHgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rms7C-0000000GS55-0AdC;
	Wed, 20 Mar 2024 09:20:06 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rms79-0000000GS36-07aX
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 09:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710926398; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=++KLZ1sY/CWAMutihCtwPhkvNB7oEVFJk3Up/NOCaO4=;
	b=otyy06C9aU7jO02E92uZcQOIBT6SEhWrrvn81+WzCmnxEHqA6fEqvQH6UDcGWUaxvurchynhcyEkNFhwbudCDc3nJb9zK+vxnoOq9mlMZ7OZZhtjc4xjkLR+81olKHbs9Jd4cvZZ7bW+RDr47qc8c6J4Bdu4A+luVFfOPVipVsE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2ws3k5_1710926389;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2ws3k5_1710926389)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 17:19:54 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: remove redundant BUILD_BUG_ON check
Date: Wed, 20 Mar 2024 17:19:49 +0800
Message-ID: <20240320091949.20791-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_022003_555624_2628BEBC 
X-CRM114-Status: UNSURE (   6.35  )
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

Remove redundant BUILD_BUG_ON check of struct nvme_dsm_range, it's
already checked in nvme_init_ctrl().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00864a634470..04abcda5b12a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1807,9 +1807,6 @@ static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
-	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
-			NVME_DSM_MAX_RANGES);
-
 	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
 		lim->max_hw_discard_sectors =
 			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
-- 
2.43.0


