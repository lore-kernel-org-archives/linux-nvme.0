Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265F4C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 05:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKV4FlE+MDVTwx+RZft9uF3aE5eOzhTGFxSym4mL4q0=; b=oEmFkyWAWg8EJqX7ijhjGtp+5x
	9KPcZy7RnJY13psE2VM7B1EPaGWdbxJwfhTZYaSBBOEjmQhsj0rvjyDoWb5I26ZK7icElMunkQOe8
	6t7G/GJ00TLeMeYeBNEwn7wE1WxukBYMKhNTMe+7TsGgGh6T0uBQwc/8chNSw0Iuy+G3wHylEsVHl
	SxoCa/st5PdrE3O9bk+C2uwJ7nnHfUyfnpqbfJYGvcBSh5JZT2hUlJg7gVPquV5V8jFdLl/xSkhoQ
	dLgfXm8YtRwWGee2JnQn0uGuBik2f7O+Jaq1Koqe3EDypvEyxyicWAKsdLkUdgwMTYB+hQ6jQbpc/
	LemYghOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QW-00000001iwo-2aTJ;
	Mon, 01 Jul 2024 05:18:08 +0000
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QV-00000001iwA-2Gnq;
	Mon, 01 Jul 2024 05:18:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] block: don't reduce max_sectors based on io_opt
Date: Mon,  1 Jul 2024 07:17:51 +0200
Message-ID: <20240701051800.1245240-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
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

Don't reduce the max_sectors value below the normal cap when the driver
advertsizes a very low io_opt.  This restores the behavior we had before
the recent changes to the max_sectors calculation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index ff8bbc101fedaa..9fa4eed4df06b0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -276,7 +276,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
-	} else if (lim->io_opt) {
+	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
 		lim->max_sectors =
 			min(max_hw_sectors, lim->io_opt >> SECTOR_SHIFT);
 	} else if (lim->io_min > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
-- 
2.43.0


