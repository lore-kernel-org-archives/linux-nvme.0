Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9776DC55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:03:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C263820882
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wMZ8WzlU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kl8AxnoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C263820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K16chbKesg+/gSbo9dqDzESOKo/WB1QhGZkQQRhKL/c=; b=wMZ8WzlU214pd9hFAgC+K3BwY
	9qdA7AltoXx6lQ4u5WQz20cNSn46CsTOxDm8tJmGV2pevPAU1/3VDl4UzTlgLch64iLAoR+iZfHDj
	h4mGUTiLK8TaPPi5A0SJRVqcIT/twWK+DQ9zShNvmIkNFuph+hUCmHbVOaQgiLCySJSuFQeKgLR4C
	Qo0OZGMW0DnvvJUdQU13PgHwXbw32RLGV8mw6gou39qW43lpiX4SZcsnhJWtsKCiZap6AvzJUlgh8
	slSXbBqeITNcz+SIa8Ud7B8dY6H1TXDMO6EBr0TWwHJ7CoQ9J6hWWSLpFhnU4pEM1oOTevcpisvYq
	aiUYLDXIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb71f-00011W-GT; Fri, 06 Nov 2020 19:03:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb71d-00010p-Mg
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:03:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=GTpuLBfYyo8TaeZo/z07ad7aIfYXt5VjexG6J+Un22Y=; b=kl8AxnoJUKENxdqbmGjtDUBKGr
 4VvvwsWDbIWXpjZUE80AyVmG5Pw1VqJDYsJwtH7NNnxp0mOGVXqwKxHaePcIX2QLEgCS8sFueGPzE
 AiTGABB6Xp+kXJg8ish427RVP/SfCFu0d17IOJ1V1HiYBELRoZFB92ZTq6pCfkW0lsJkkJrifhsmZ
 pmg+34MTaZP2+QSox6FaZ3V/B2bz9YfsUA2FysiawKz4wfLjLQFNhJ856xgqwRX1KDIB3yvZOlRbF
 NcZ4l5avCx+EDEjbrxqOm6DFPEMZDdVeorTynAxTtJLBiF/5eE5hDbP4cAerzfFjspBXGft5tkdz/
 xM4wPyUw==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb71b-0000th-31; Fri, 06 Nov 2020 19:03:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/24] loop: remove loop_set_size
Date: Fri,  6 Nov 2020 20:03:14 +0100
Message-Id: <20201106190337.1973127-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
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

Just use set_capacity_revalidate_and_notify directly, as this function
can update the block device size as well when the last parameter is set
to true.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb1191d6e945f2..86eb7e0691eef5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -241,23 +241,6 @@ loop_validate_block_size(unsigned short bsize)
 	return 0;
 }
 
-/**
- * loop_set_size() - sets device size and notifies userspace
- * @lo: struct loop_device to set the size for
- * @size: new size of the loop device
- *
- * Callers must validate that the size passed into this function fits into
- * a sector_t, eg using loop_validate_size()
- */
-static void loop_set_size(struct loop_device *lo, loff_t size)
-{
-	struct block_device *bdev = lo->lo_device;
-
-	bd_set_nr_sectors(bdev, size);
-
-	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
-}
-
 static inline int
 lo_do_transfer(struct loop_device *lo, int cmd,
 	       struct page *rpage, unsigned roffs,
@@ -1076,7 +1059,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	struct address_space *mapping;
 	struct block_device *claimed_bdev = NULL;
 	int		error;
-	loff_t		size;
 	bool		partscan;
 	unsigned short  bsize;
 
@@ -1164,9 +1146,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-	size = get_loop_size(lo, file);
-	loop_set_size(lo, size);
-
+	set_capacity_revalidate_and_notify(lo->lo_disk, get_loop_size(lo, file),
+			true);
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
 
@@ -1402,9 +1383,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
 
 	if (size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
-		loop_set_size(lo, new_size);
+		set_capacity_revalidate_and_notify(lo->lo_disk,
+				get_size(lo->lo_offset, lo->lo_sizelimit,
+					 lo->lo_backing_file), true);
 	}
 
 	loop_config_discard(lo);
@@ -1580,14 +1561,10 @@ loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 
 static int loop_set_capacity(struct loop_device *lo)
 {
-	loff_t size;
-
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
-
-	size = get_loop_size(lo, lo->lo_backing_file);
-	loop_set_size(lo, size);
-
+	set_capacity_revalidate_and_notify(lo->lo_disk,
+			get_loop_size(lo, lo->lo_backing_file), true);
 	return 0;
 }
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
