Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F9C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:48:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF3560E78
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FF3560E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XyHbcBGR/krQNWN9MNnA+mzkSvA5yDG/dICdgeOCJDg=; b=Fa3qsUhOWH3La2
	EPTNIB8YjNKUxaH0dNdKtwfPnhnvk8H9GSTY/QMyM5iTK89RMb2DlT0Iy1jP+BkhdPyo+gi0AElKE
	SZKKLpmJU9K8/q5mLCt7RghszFFXyMJyeKC5rf/gTJYy8WR4Bd4HF4LjXu5ynVr4qy0krk/24Cx3V
	kGJi2fkHDzUn9iJUkbfw2D4Y30FleEaA1PGgucgcoUd4xJ/WJgIy8nXU6QtjeNZTWI7T0B0Wz4FFz
	nGv8a+cu8gGeXPVa32PYu9uyel6Kf76DEUkqqKQMzdjdMjz+O/GCZoFNnnRIxSL64zmP9ljw3vvBq
	8ajVLJU1PGFz9PyYq2AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCz52-00HIAQ-Oq; Mon, 09 Aug 2021 06:48:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz50-00HI9U-To
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AZuLPYkl9A2TXa8srNWxLAXsGFr2mUQNc5qPxoXeO+o=; b=p+Kqgs8Q9em5vJFdvVXwzlx4Qu
 Wk301OPqqjb4quMM61zs0a44piuBoqarMJKmJyKrY5e1CUsFMSMMqwfWN0eD0LZ3QNHHwyeo3r461
 3W8UrzS7Evc5AVef/20lL69MRpaodg+KRuq1IJbIoKfQAdr54YOfv10nHtBRX2nBoZFMGvF2jOGv4
 fFS99XeZe2uxrfYucpsf/QVKMCLVY2q6jZSOU1OR+4vyUgEtvjZDprBgbv6z8houTwu9FT8AQXwzR
 WrgXBeR5z2r4Cc00+e5Jyt3trR2wc1NXlw67L/n7Ug/JTjwd1j3rkXuphd422Tui0IqTwBRByVims
 N6pMuQDQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz4A-00AizF-Lt; Mon, 09 Aug 2021 06:47:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH 7/8] bcache: move the del_gendisk call out of
 bcache_device_free
Date: Mon,  9 Aug 2021 08:40:27 +0200
Message-Id: <20210809064028.1198327-8-hch@lst.de>
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

Let the callers call del_gendisk so that we can check if add_disk
has been called properly for the cached device case instead of relying
on the block layer internal GENHD_FL_UP flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index d0f08e946453..f2874c77ff79 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -885,11 +885,6 @@ static void bcache_device_free(struct bcache_device *d)
 		bcache_device_detach(d);
 
 	if (disk) {
-		bool disk_added = (disk->flags & GENHD_FL_UP) != 0;
-
-		if (disk_added)
-			del_gendisk(disk);
-
 		blk_cleanup_disk(disk);
 		ida_simple_remove(&bcache_device_idx,
 				  first_minor_to_idx(disk->first_minor));
@@ -1371,8 +1366,10 @@ static void cached_dev_free(struct closure *cl)
 
 	mutex_lock(&bch_register_lock);
 
-	if (atomic_read(&dc->running))
+	if (atomic_read(&dc->running)) {
 		bd_unlink_disk_holder(dc->bdev, dc->disk.disk);
+		del_gendisk(dc->disk.disk);
+	}
 	bcache_device_free(&dc->disk);
 	list_del(&dc->list);
 
@@ -1518,6 +1515,7 @@ static void flash_dev_free(struct closure *cl)
 	mutex_lock(&bch_register_lock);
 	atomic_long_sub(bcache_dev_sectors_dirty(d),
 			&d->c->flash_dev_dirty_sectors);
+	del_gendisk(d->disk);
 	bcache_device_free(d);
 	mutex_unlock(&bch_register_lock);
 	kobject_put(&d->kobj);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
