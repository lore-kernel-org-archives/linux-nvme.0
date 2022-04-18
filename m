Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97EC4167D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJDfNJ+noyJ0aQwSxPjfuM0bukOLXIlZdKOCCRo7UC0=; b=SWJ5cJFxnKSCf8Bo+650+AR52w
	QBx7GAQscSZfc2QH+gF0cUYODB2MtzQWnzuxCNGDzqQ2Hz7dwoyKPRSlWumIDUQw5OMYd2Fn/AOo9
	pqnssnnuJDJBeX1Ss0P4TO9j32FcTTY9/4Gfz3d4ssS/5GIcewgZlzhdXnl57mGV16UXb1OHVbxeZ
	xbR3UhAX2UNH9Qkk32t3TX/fK83KP3yIrBmM1ymIf3qz5n57yc7xydVyUebdZ1YuOix99VYLF1RoK
	xUbTOstHLHDboy6PGUy0CH0xvdTWhUtTZsXWil279NyBjxKTE0BhqCG1J1g2TmZ2GTxvPcBicH1Jo
	2jTzAYqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngJOe-00FZ4O-02; Mon, 18 Apr 2022 04:53:56 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJOE-00FYjt-Uc; Mon, 18 Apr 2022 04:53:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 dm-devel@redhat.com
Subject: [PATCH 05/11] dm-zoned: don't set the discard_alignment queue limit
Date: Mon, 18 Apr 2022 06:53:08 +0200
Message-Id: <20220418045314.360785-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
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

The discard_alignment queue limit is named a bit misleading means the
offset into the block device at which the discard granularity starts.
Setting it to the discard granularity as done by dm-zoned is mostly
harmless but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-zoned-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index cac295cc8840e..0ec5d8b9b1a4e 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1001,7 +1001,7 @@ static void dmz_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	blk_limits_io_min(limits, DMZ_BLOCK_SIZE);
 	blk_limits_io_opt(limits, DMZ_BLOCK_SIZE);
 
-	limits->discard_alignment = DMZ_BLOCK_SIZE;
+	limits->discard_alignment = 0;
 	limits->discard_granularity = DMZ_BLOCK_SIZE;
 	limits->max_discard_sectors = chunk_sectors;
 	limits->max_hw_discard_sectors = chunk_sectors;
-- 
2.30.2


