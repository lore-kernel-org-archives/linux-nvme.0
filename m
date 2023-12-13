Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3E4C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kv09BG5nH+yHmFiJZJYk/0Oxzzp7zwKkWQh29SIiOno=; b=OzFTWP72JYzXPppPNGOAha3xyO
	/J8MMLy26bbJT5PZcBw09OkjOi2SndvT76OwEzguvER0cF6OjCyu4NmMV8zVm/Qrr1X39VAVlxJFO
	pyOWBUwqtLE2ISPtnCX4J9xxloS4JxC5k1PGf1TJ+UaJd1GI57Nebz1iWM+B/fcjImscOiNhHCYQ1
	ywkRqBHDVW2EEHK5GbwagMfZVgtmOpgVeIotdu3WN9QpBqxiWkfZuJs/VjDk0iIDOeihnQ4m/SMuy
	tTiT2pW+vqrUqKyY7f2j/YnqCciOerkvb1WvzyClHRwwQXyAbCIPs1WBwZ+blEZYkrKtqadUGpYdr
	KIROxhnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIo4-00Dn8w-2i;
	Wed, 13 Dec 2023 06:33:20 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIo2-00Dn6L-1r
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 06:33:19 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyP5LD0_1702449190;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyP5LD0_1702449190)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 14:33:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/5] nvmet: remove cntlid_min and cntlid_max check in nvmet_alloc_ctrl
Date: Wed, 13 Dec 2023 14:32:50 +0800
Message-Id: <1702449172-8920-4-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_223318_765216_BF817027 
X-CRM114-Status: UNSURE (   7.16  )
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

The cntlid_min and cntlid_max are checked in configfs, don't check
again in nvmet_alloc_ctrl().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165..d26aa30 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1425,9 +1425,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_changed_ns_list;
 
-	if (subsys->cntlid_min > subsys->cntlid_max)
-		goto out_free_sqs;
-
 	ret = ida_alloc_range(&cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
-- 
1.8.3.1


