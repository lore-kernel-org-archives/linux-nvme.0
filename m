Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA81C82542
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:01:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1837620578
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cE8lxsF/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qaAfbB35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1837620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CXBUcJ1ONVpZ8qCL5K+RmMwXgbuJjR0N2L4sipcnDtc=; b=cE8lxsF/xVeRi6Hhlh8NX+/AF
	EwjD5nX/tdVMHH+VUGu9yu2tyJdMRxYx3NMyeHOwQGjrQTuSHw/u/vFym1Vqlv8vDwujBg3nRxlYN
	8/nm90/NsurrpPb8RG22JoHJOzfnwQwblq01RzKs6LKikgpQoZiSAukKu20C+Baccrv8Wo5dhJmyQ
	lwZO6zpLikzd2d4bluTsBxMrGpXMCJIkLj81YL439qrHWFP0EAvMUZ7w0mDsKqrFZCcClRv0MszmK
	VcCU5ew/0U4DuNuMmIRdyji/KBG/8CT8U+ph3Z/orVi03UNRbEx2KGnVwVsi8R2n/6PK2E1BbBatS
	9BL8JzECg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg0T-0004qk-Ey; Mon, 16 Nov 2020 15:01:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxl-0003T2-A1
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=pTUA48t42+HHCJV8On6c5azUAuBD9lzCSJPspjiep2g=; b=qaAfbB35avsytGqpNEWytrYnG3
 Gzj30W9piDTxClPGcKhQyC+7xWVJuzk1wqdaEoOD9LirlO1oU4d+8MQk8YOX9kwzJ7YvxhfCYVwqV
 R1dvaVAuFO/bc6xYy1Ev4vzKAgcI+bbNKPs2o+tMhgBNzFFqOC/Cs3j9//Uol04948xLm+DnqHaQV
 JmjjR/YVKAVJHjcogeCp9WMAO/bNvPQrjfn23UtbJYTihH9NKGBOQhYu6ZZR0Bj/S8oBjTDj9QxIb
 xdoFbJTJepAHEgsdxqO7JMl+zv8FirGSWZmdep8SDJQcE2TlUZhGVyxST/B+EptdxxxLsqlXBn1sz
 2IVCtD9Q==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxi-0003ph-Re; Mon, 16 Nov 2020 14:58:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/78] zram: use set_capacity_and_notify
Date: Mon, 16 Nov 2020 15:57:09 +0100
Message-Id: <20201116145809.410558-19-hch@lst.de>
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

Use set_capacity_and_notify to set the size of both the disk and block
device.  This also gets the uevent notifications for the resize for free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1b697208d66157..6d15d51cee2b7e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1695,7 +1695,7 @@ static void zram_reset_device(struct zram *zram)
 	disksize = zram->disksize;
 	zram->disksize = 0;
 
-	set_capacity(zram->disk, 0);
+	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(&zram->disk->part0, 0);
 
 	up_write(&zram->init_lock);
@@ -1741,9 +1741,7 @@ static ssize_t disksize_store(struct device *dev,
 
 	zram->comp = comp;
 	zram->disksize = disksize;
-	set_capacity(zram->disk, zram->disksize >> SECTOR_SHIFT);
-
-	revalidate_disk_size(zram->disk, true);
+	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
 
 	return len;
@@ -1790,7 +1788,6 @@ static ssize_t reset_store(struct device *dev,
 	/* Make sure all the pending I/O are finished */
 	fsync_bdev(bdev);
 	zram_reset_device(zram);
-	revalidate_disk_size(zram->disk, true);
 	bdput(bdev);
 
 	mutex_lock(&bdev->bd_mutex);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
