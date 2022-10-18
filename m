Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86546C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7pjaExyWx0kiXJ6eN4VqPr9sGFWvL2YnRifHeTdaxw=; b=V5N4aoT2KUTXRL0nIyKGIleQHP
	Zr157nAdFB2KFtncNj9Q8LmcUtQRhOD75eOihB7GG9Q60blBX+V+DpA9Mhpm+YUecT2PScJP6BiNK
	teBlxm0OarzBjaiiPdFbK6E5RVV6+k4gTdM1tbp34nkli3SQuLZvlm1mk04qkav/qnWBvT6tkHE8I
	QXQ8pWxUzAhVMCOqXJpIVaz3tUeKxhQEOAwZwhKKzXBB4w/U13PHKqvq018jz+HFmnIvhZD1tXqLa
	R0k/s6AFtSmEMeY8ANj1QC3k8Nqk3WPmjH/SU4iG0MFM4gwRPLa0d3PAeBq0YseW7jQSe80yQVNRl
	b+phhMTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn6T-007CLO-7f; Tue, 18 Oct 2022 13:57:57 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn69-007C9f-9a; Tue, 18 Oct 2022 13:57:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 4/4] nvme-apple: remove an extra queue reference
Date: Tue, 18 Oct 2022 15:57:20 +0200
Message-Id: <20221018135720.670094-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018135720.670094-1-hch@lst.de>
References: <20221018135720.670094-1-hch@lst.de>
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

Now that blk_mq_destroy_queue does not release the queue reference, there
is no need for a second admin queue reference to be held by the
apple_nvme structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 42b17439dfd57..fe7f0444a8e46 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1505,15 +1505,6 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto put_dev;
 	}
 
-	if (!blk_get_queue(anv->ctrl.admin_q)) {
-		nvme_start_admin_queue(&anv->ctrl);
-		blk_mq_destroy_queue(anv->ctrl.admin_q);
-		blk_put_queue(anv->ctrl.admin_q);
-		anv->ctrl.admin_q = NULL;
-		ret = -ENODEV;
-		goto put_dev;
-	}
-
 	nvme_reset_ctrl(&anv->ctrl);
 	async_schedule(apple_nvme_async_probe, anv);
 
-- 
2.30.2


