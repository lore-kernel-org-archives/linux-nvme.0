Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92866C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:13:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE97216C4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="miVTnCh3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KMc7aGpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE97216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y3eSApcV4zVe/+IODwz7n5AFQr10MFI+oMsju52Ng+4=; b=miVTnCh3R9Uc5PKGrRCEXWwur
	P41XLMcmHsFEyHHe7q+ZYKyQMWlA3FLWYRB+2g/naAivHQDW3bJqssMraGmC6OPR4UeAOZE5gKo7d
	KDQ3o8MmIAQjbSkJVw9qwYu/cXjL1zwpXuo+WNcKbbI+Co5XJ9ITSJU/YREQeRi6N/PGKQsJinAYv
	+26tg94yi3sWOGO3q2bqe9NJykcOMMtUaxeih1dzfDkrBZo711ukmTD9h6gTjacGhb8rqJzupur57
	CheHyp2I/ehYHaxp0TeBI4GX9WjyV7SJuDBygVDKs+JufOVcj/Mv1wAYDUAwqmQHhpz9oPqDdB515
	+yh4yrF4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kegBq-0003I4-Db; Mon, 16 Nov 2020 15:13:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyt-00043o-IB
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=zd1S9ob6uvhOklVRkrOeSjqFIX0gjs8FIGa+SnPo4cs=; b=KMc7aGpwgD+lz4Ap0QfJBSwvVZ
 iRElJGYPaXtvm2l9EE0QgJGZsLEMjMUI0TNdT5TzgHVBvn7Zkv6OmXwKmUcW5NNi2zdVuHdJ996Ac
 OwvmfOLIphJ8QVS1fk75k9Alf/HM3+yte1sC2Cw0u4ljnVUY+8L5tiyT4eYi4wo/A+Hc0PUaBTH0m
 JjNk8TEGb2obEe56crgiqesbff6AXgdDuyaMinswXcIOBb/Qar6Y3kJ12qgYT1OQ66sP9wZekpAU1
 SHqAycA5BdeglD3wmyoPmCAafo1AzTrZyURw0bkbcfVj6u7/3WjF0X4AlPQXPGdveo8XwIrYcJs7A
 LRojdTPA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyq-0004E0-6d; Mon, 16 Nov 2020 14:59:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 65/78] dm: remove the block_device reference in struct
 mapped_device
Date: Mon, 16 Nov 2020 15:57:56 +0100
Message-Id: <20201116145809.410558-66-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Get rid of the long-lasting struct block_device reference in
struct mapped_device.  The only remaining user is the freeze code,
where we can trivially look up the block device at freeze time
and release the reference at thaw time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-core.h |  2 --
 drivers/md/dm.c      | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index d522093cb39dda..b1b400ed76fe90 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -107,8 +107,6 @@ struct mapped_device {
 	/* kobject and completion */
 	struct dm_kobject_holder kobj_holder;
 
-	struct block_device *bdev;
-
 	struct dm_stats stats;
 
 	/* for blk-mq request-based DM support */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6d7eb72d41f9ea..c789ffea2badde 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1744,11 +1744,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
 
 	cleanup_srcu_struct(&md->io_barrier);
 
-	if (md->bdev) {
-		bdput(md->bdev);
-		md->bdev = NULL;
-	}
-
 	mutex_destroy(&md->suspend_lock);
 	mutex_destroy(&md->type_lock);
 	mutex_destroy(&md->table_devices_lock);
@@ -1840,10 +1835,6 @@ static struct mapped_device *alloc_dev(int minor)
 	if (!md->wq)
 		goto bad;
 
-	md->bdev = bdget_disk(md->disk, 0);
-	if (!md->bdev)
-		goto bad;
-
 	dm_stats_init(&md->stats);
 
 	/* Populate the mapping, nobody knows we exist yet */
@@ -2384,12 +2375,17 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
  */
 static int lock_fs(struct mapped_device *md)
 {
+	struct block_device *bdev;
 	int r;
 
 	WARN_ON(md->frozen_sb);
 
-	md->frozen_sb = freeze_bdev(md->bdev);
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev)
+		return -ENOMEM;
+	md->frozen_sb = freeze_bdev(bdev);
 	if (IS_ERR(md->frozen_sb)) {
+		bdput(bdev);
 		r = PTR_ERR(md->frozen_sb);
 		md->frozen_sb = NULL;
 		return r;
@@ -2402,10 +2398,14 @@ static int lock_fs(struct mapped_device *md)
 
 static void unlock_fs(struct mapped_device *md)
 {
+	struct block_device *bdev;
+
 	if (!test_bit(DMF_FROZEN, &md->flags))
 		return;
 
-	thaw_bdev(md->bdev, md->frozen_sb);
+	bdev = md->frozen_sb->s_bdev;
+	thaw_bdev(bdev, md->frozen_sb);
+	bdput(bdev);
 	md->frozen_sb = NULL;
 	clear_bit(DMF_FROZEN, &md->flags);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
