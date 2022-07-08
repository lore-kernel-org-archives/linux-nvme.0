Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5C8C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 03:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LW6wrraIIrEW3edhMECP18nq0ErN5YeslRJktigN7gc=; b=HzlT+6/ei7pbc5o30BjmLHiclb
	nVzAt02piyGVhiopNo/RvgkBalTyg5OU9lMLrsDf/jv81VxGxzPh5LQ/Z5P1zhzGjS97OPY2OhZNp
	fvYH79zQhJ9XpnVUWnp5SoZHkYNAGMVg/oTqrOEssYNBckn4m/cXkXN8y5WbidS6qn1r68VOb5jyW
	Jl6l/N4kb9uEtY+pZwa/4lkdaXr9ivlEQrKThIp94jqOerfmRW42E9HVjdfoGJ3j0u8q7P0cVXYuu
	BdNsKrWwR+KztFiJzxU2Dc1XSfYKDvx5HvuYfL2zwF1UgOwZJMboTxWpZNByoQdFDqq6jwpRtTKME
	Gi/+dOwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9eIb-001Tqr-GY; Fri, 08 Jul 2022 03:04:57 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9eIY-001TpG-26
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 03:04:56 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIheABE_1657249477;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VIheABE_1657249477)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 11:04:46 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: use nvme core helper to cancel requests in tagset
Date: Fri,  8 Jul 2022 11:04:37 +0800
Message-Id: <1657249477-88304-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_200454_316934_46510DAA 
X-CRM114-Status: UNSURE (   8.04  )
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

Use nvme core helper nvme_cancel_tagset and nvme_cancel_admin_tagset
instead of same logic code.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e7af223..ab4facf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2720,10 +2720,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_pci_disable(dev);
 	nvme_reap_pending_cqes(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_wait_completed_request(&dev->tagset);
-	blk_mq_tagset_wait_completed_request(&dev->admin_tagset);
+	nvme_cancel_tagset(&dev->ctrl);
+	nvme_cancel_admin_tagset(&dev->ctrl);
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
-- 
1.8.3.1


