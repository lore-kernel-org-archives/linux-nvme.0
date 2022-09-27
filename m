Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2F9C07E9D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tofF3W9eVoM8EKprY/3kK6o1sERsn9VFuilBHET7joc=; b=46FjfWCRmNSIGa4UZ0CQFlmuVb
	DvTmyAAcWBOEdLKQH5dtXDzcFjfdouTl7dE7XkNc9j+TW3wGSlTxdagfmjqBEhjPKc1apMdYAwUHl
	x1mK4L1YR260t7SIL2LXlAsNjRtM2JB0+rN7ohi5BOoITVjlbbXp3ixrPWpey1bfUWaBBNMp7cn86
	puQ3FOIeu9+jCdcfWg5fj0KoAz48Po49fldBP9gSF9VXU5A8NKoB1+jTv/7SK4hZkZz8GhTszuLsF
	5gI+WSauD/S7PjjENMfyrJYI1OK4JKZDHrLfv8z15Ibh2vtFaASUAax2nlVF8cqhJWMDkNvTc9Fn+
	oTrpDA5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Ot-00APFm-I0; Tue, 27 Sep 2022 12:09:23 +0000
Received: from [2001:4bb8:180:b903:ade8:c5dc:3782:5ee0] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Oq-00APDg-4U; Tue, 27 Sep 2022 12:09:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet: don't look at the request_queue in nvmet_bdev_zone_mgmt_emulate_all
Date: Tue, 27 Sep 2022 14:09:14 +0200
Message-Id: <20220927120915.280166-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927120915.280166-1-hch@lst.de>
References: <20220927120915.280166-1-hch@lst.de>
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

nvmet is a consumer of the block layer and should not directly look at
the request_queue.  Just use the NUMA node ID from the gendisk instead of
the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/zns.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4e..7e89056cc4116 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -387,7 +387,6 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 {
 	struct block_device *bdev = req->ns->bdev;
 	unsigned int nr_zones = bdev_nr_zones(bdev);
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = NULL;
 	sector_t sector = 0;
 	int ret;
@@ -396,7 +395,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 	};
 
 	d.zbitmap = kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(*(d.zbitmap)),
-				 GFP_NOIO, q->node);
+				 GFP_NOIO, bdev->bd_disk->node_id);
 	if (!d.zbitmap) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.30.2


