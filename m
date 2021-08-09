Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964DAC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:43:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B51960527
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B51960527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kg3dX+3HqXnb5QC/dxVnACsDf08SPr38LPS2KR0H8yw=; b=nrS/PwWvp3IAwV
	UK/RVNVPQYDb/QiLjKK6Ph8Vtumoy48ADUaSiUj7kp1LaZgfUb3/ZJ+QeF2NvmExleQvySv8RRsXe
	z/rO0E2mq0gnk6ExF+GVe3Ohv6V7v03qAR/RsobKCW/m6cT9d5Q4yeKP48O2mqDK5KCCihXgB4p1f
	lDjdysqZbNrSZYE9oSlQ8QjkwSETiiDP9IXw8P/gbqhq5KU0w5Jb811tGK22Sze3lSs0qrZqgnlTz
	4vRmjmqML1QfGMqebfnuQ+UTrMX5aJXncIAlvPdCH2+B56AlCKzj7lnEKhP6dTY0xL9zuu+7v4qYt
	a2yIERGe0UaLIM0ue2fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCz0X-00HGtW-Cx; Mon, 09 Aug 2021 06:43:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz0V-00HGtG-Mn
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=0bloQM8aoJGa52SS3HQDL44KSv1NQIKRAD/0FDyYHTE=; b=VfrWQfpIl+w2K9PhKi+g/zU9xB
 //KebpYu7wnvOQN7PsIzQE3f9+y2fPZV7LoZ2vwcq97a7r7flef9HPpW6udJiD9n3PA3DTV+zS2Jn
 s5/P2yvl86JHpzVPI9fkVwGFuDRUVgjY0xzEq/0WI/Hzdk5qXTPZBFGj1RcNldlmMFgrvNVSFzkyR
 QkzUpaYXd5Mh2kHWZM1G9NRO2hjE3EUVP2kDh0u/VnlgNN7zL6Mv7EOa33cKi0Vqgk9MrRCb0bQwN
 GcQ62wViBhNQ5psSuFc+kpC6UxWfNwoOGV2CsiW9Q1nyiZvP1xdqke4sFiJk7xk8vw+wduDN23W1u
 N3VrZscw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCyzo-00Aieu-E4; Mon, 09 Aug 2021 06:43:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH 2/8] mmc: block: cleanup gendisk creation
Date: Mon,  9 Aug 2021 08:40:22 +0200
Message-Id: <20210809064028.1198327-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
References: <20210809064028.1198327-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Restructure mmc_blk_probe to avoid a failure path with a half created
disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c | 49 ++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4ac3e1b93e7e..4c11f171e56d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2328,7 +2328,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      sector_t size,
 					      bool default_ro,
 					      const char *subname,
-					      int area_type)
+					      int area_type,
+					      unsigned int part_type)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -2375,6 +2376,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	kref_init(&md->kref);
 
 	md->queue.blkdata = md;
+	md->part_type = part_type;
 
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->minors = perdev_minors;
@@ -2427,6 +2429,10 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		cap_str, md->read_only ? "(ro)" : "");
 
+	/* used in ->open, must be set before add_disk: */
+	if (area_type == MMC_BLK_DATA_AREA_MAIN)
+		dev_set_drvdata(&card->dev, md);
+	device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
 	return md;
 
  err_kfree:
@@ -2456,7 +2462,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	}
 
 	return mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
-					MMC_BLK_DATA_AREA_MAIN);
+					MMC_BLK_DATA_AREA_MAIN, 0);
 }
 
 static int mmc_blk_alloc_part(struct mmc_card *card,
@@ -2470,10 +2476,9 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	struct mmc_blk_data *part_md;
 
 	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname, area_type);
+				    subname, area_type, part_type);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
-	part_md->part_type = part_type;
 	list_add(&part_md->part, &md->part);
 
 	return 0;
@@ -2674,20 +2679,13 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 
 static void mmc_blk_remove_req(struct mmc_blk_data *md)
 {
-	struct mmc_card *card;
-
-	if (md) {
-		/*
-		 * Flush remaining requests and free queues. It
-		 * is freeing the queue that stops new requests
-		 * from being accepted.
-		 */
-		card = md->queue.card;
-		if (md->disk->flags & GENHD_FL_UP)
-			del_gendisk(md->disk);
-		mmc_cleanup_queue(&md->queue);
-		mmc_blk_put(md);
-	}
+	/*
+	 * Flush remaining requests and free queues. It is freeing the queue
+	 * that stops new requests from being accepted.
+	 */
+	del_gendisk(md->disk);
+	mmc_cleanup_queue(&md->queue);
+	mmc_blk_put(md);
 }
 
 static void mmc_blk_remove_parts(struct mmc_card *card,
@@ -2876,7 +2874,7 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 
 static int mmc_blk_probe(struct mmc_card *card)
 {
-	struct mmc_blk_data *md, *part_md;
+	struct mmc_blk_data *md;
 	int ret = 0;
 
 	/*
@@ -2904,19 +2902,6 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (ret)
 		goto out;
 
-	dev_set_drvdata(&card->dev, md);
-
-	device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
-	if (ret)
-		goto out;
-
-	list_for_each_entry(part_md, &md->part, part) {
-		device_add_disk(part_md->parent, part_md->disk,
-				mmc_disk_attr_groups);
-		if (ret)
-			goto out;
-	}
-
 	/* Add two debugfs entries */
 	mmc_blk_add_debugfs(card, md);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
