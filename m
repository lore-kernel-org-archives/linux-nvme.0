Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87545C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:05:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3308C2344C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e0Apx2g/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CW2g8R0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3308C2344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=llxmvA0CpVDauzwlbAqi2hcHdOyZMlRyFZQpcaivBFQ=; b=e0Apx2g/UL6aRZozSH4qep5QJ
	Brd8NYqc7eWPO1TSKp0Di8xv0UZ97vJXpNf02ZNEJg1kNPX81NwXTii3o98vXS/gV6OfhWuielCZN
	4mJ8G3q2CnQfZb6ySpRg9XSZwd0qFKZCOxHHYYT4fLVw+MKRV41OiMJnuDdTtpO1Z5ioCZBkWUulR
	WgTdmNGFQbpZ2g/TvpJlC8VLUTK2uc8vPKRDibfAWs90g+pd55cb/RoLC8zmxdSaeLZWpeZ17diw2
	rBq3yo7H9zqX2OeqrlWNeAor+WUafW/Zt+y8AZ00EbWRRyi+0KVnx/w8w/PIxTAfwZND2MRGkSalZ
	aehSnc/Lw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg4R-0000Ma-4Y; Mon, 16 Nov 2020 15:05:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefy9-0003eh-4W
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ceSruCVWzLax0XFB3PV+YChHyJOUoDTFl1AuzUG7uKo=; b=CW2g8R0fi9IlSMs6PB15CroPmB
 VwoaOYD9bMi1DVWfaTM4vlulUe111h2RI3tztOT5WMq0qsSqGFH2pFQe0NOcqNLdex+g9q4BMMVZP
 /6TuwzASGMA1SrkPTvS7l/wvEgTeWNYqEdTqZb/ZtDyfrlGP270HGrcmH7UeWoKasPCt9CokG+QBB
 a2OdxXHzodz4vx5g/ZqCX44oTJtSk/OzRCJ8dKXSw80cEaDg4gDxz1oQY0QautKMW+b4o+TDgBAIv
 i8SHCduCi7NL+7FPVx6mbW4O37u1Dt6jRtYD7qdW2goUC6ahFPGml0cbg+8h8UcWX3F//bKVJttjN
 HevPpOdA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefy7-0003wG-IY; Mon, 16 Nov 2020 14:58:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 35/78] block: cleanup del_gendisk a bit
Date: Mon, 16 Nov 2020 15:57:26 +0100
Message-Id: <20201116145809.410558-36-hch@lst.de>
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
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Merge three hidden gendisk checks into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b0f0b0cac9aa7f..8180195b76634b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -892,6 +892,9 @@ void del_gendisk(struct gendisk *disk)
 
 	might_sleep();
 
+	if (WARN_ON_ONCE(!disk->queue))
+		return;
+
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -914,20 +917,18 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
 
-	if (!(disk->flags & GENHD_FL_HIDDEN))
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-	if (disk->queue) {
+
 		/*
 		 * Unregister bdi before releasing device numbers (as they can
 		 * get reused and we'd get clashes in sysfs).
 		 */
-		if (!(disk->flags & GENHD_FL_HIDDEN))
-			bdi_unregister(disk->queue->backing_dev_info);
-		blk_unregister_queue(disk);
-	} else {
-		WARN_ON(1);
+		bdi_unregister(disk->queue->backing_dev_info);
 	}
 
+	blk_unregister_queue(disk);
+	
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		blk_unregister_region(disk_devt(disk), disk->minors);
 	/*
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
