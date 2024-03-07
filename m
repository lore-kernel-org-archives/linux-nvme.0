Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E34C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6dAOpH3HfvroaSB45ET9VQSXQtJU2v4720kk0k4xZk=; b=4FTJCYsJxyO2ASmOABc+A+BQX5
	gXdl4ofzXLeQfYlZvIbiwh8TKA16XmvGCPGfZ75pXDYToR+YsPstY+6o7Un/SPmE3nMjYo2yXUFsk
	sTwtI1thp2B0CGlwlP/lPogcr5wE+bdggmM0LwVXKmCQrIUNyrxd0mgomgxvGFsUx7BTB0fnfNX0k
	irCU3JEDgMbo/vLRgIPFDOLsG2DmgMX26O59UPZ3VBREzFUOS6FMevK+tGtP11PM9ffKJsh902QpH
	3FlVi9k6ayvcIMpkF+tjoDYMPml/xDKmYbtqSpukOw6xuNnqvAn18VZnR4sXPZMXSHOKHrNlPclyC
	TsmEquQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPs-00000005DIx-2Ufm;
	Thu, 07 Mar 2024 15:12:16 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPi-00000005DA8-0s2Q;
	Thu, 07 Mar 2024 15:12:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/10] nvmet: switch to using blk_next_discard_bio directly
Date: Thu,  7 Mar 2024 08:11:54 -0700
Message-Id: <20240307151157.466013-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307151157.466013-1-hch@lst.de>
References: <20240307151157.466013-1-hch@lst.de>
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

This fixes fatal signals getting into the way and corrupting the bio
chain and removes the need to handle synchronous errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/io-cmd-bdev.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f11400a908f269..c1345aaf837d93 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -363,17 +363,13 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
 static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
-	struct nvmet_ns *ns = req->ns;
-	int ret;
+	sector_t sector = nvmet_lba_to_sect(req->ns, range->slba);
+	sector_t nr_sects = le32_to_cpu(range->nlb) <<
+		(req->ns->blksize_shift - SECTOR_SHIFT);
 
-	ret = __blkdev_issue_discard(ns->bdev,
-			nvmet_lba_to_sect(ns, range->slba),
-			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
-			GFP_KERNEL, bio);
-	if (ret && ret != -EOPNOTSUPP) {
-		req->error_slba = le64_to_cpu(range->slba);
-		return errno_to_nvme_status(req, ret);
-	}
+	while (blk_next_discard_bio(req->ns->bdev, bio, &sector, &nr_sects,
+			GFP_KERNEL))
+		;
 	return NVME_SC_SUCCESS;
 }
 
-- 
2.39.2


