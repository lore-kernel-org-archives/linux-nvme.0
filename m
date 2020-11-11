Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35FC388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:31:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9D2206F1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UPFNFZJL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INZhS6je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9D2206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xUxIdJBOSNetejuh4algqAcG1cK6C+CSoleVuPhdNU0=; b=UPFNFZJLZT9+6CZXlQx+eox/r
	sjm3icZGH2+uluOUPR5EgEaoHM+iiQntbmb3A41/tAv7Fkjk3F/lQSa3uSXwbDuQ1lmvkp0p6iikP
	/aw2WCSzNwREfyb4qzkqQToLlFnYyj1DtAoDPlSTaCe0AD0VuvVEWJxnyCNOiCHcWaTN1Dxnz3zqV
	hKLeE7SyE+xctDzbMg5L0DF5LOSLELqMxwngRFomknvacCBrfvQCp6gtw6Zu2O1rAb6YKG3MKfrmh
	iO3e+mYynVGYljggJMKAsNgKE7JJcGgzG6Spx3PcTTPuC8eFmOvNMaJsaudbL5WkhHRMQwKZoeoDr
	WCf+w8bfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kclWp-0005J8-Jb; Wed, 11 Nov 2020 08:31:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kclTM-00045m-Li
 for linux-nvme@merlin.infradead.org; Wed, 11 Nov 2020 08:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7eiDjQ8ZjozXig6+m+V2Nb2yhyFiCm1kEOIxzxYYgzo=; b=INZhS6jek7sGzfAIL6nzYXyeXs
 SsycI2Wi/bh4Pu9HbXbPFzDNdHlSwDosG0AcMwQMMm1UOxdqMl11eyvFrWr8b8z0IrJsEn0H42AYn
 qK9iedvHnlhvSRdKVleqXJmjQGFSSkaIdxmnABppoi7MGvBdw70K6g4OEqXr8kkf1cCEWQ716tM5I
 V+Aj8IGwwwfmE/a75KkaqAmHB6T6imPjEjCW+u7gRuoO7i2YL9fXBfMlWqCYSOkvaP4efehVbn86F
 I/pA5x8OW7h9U9vg1qyAB+518eTm0anOOLvxsYmd8D9ABdtIXycMKu8rH3KJ32rwjG+GfPfEUHYEs
 jyKDZgiw==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kclTL-0007cU-2G; Wed, 11 Nov 2020 08:27:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/24] nvme: use set_capacity_and_notify in
 nvme_set_queue_dying
Date: Wed, 11 Nov 2020 09:26:49 +0100
Message-Id: <20201111082658.3401686-16-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
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

Use the block layer helper to update both the disk and block device
sizes.  Contrary to the name no notification is sent in this case,
as a size 0 is special cased.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 445274b28518fb..cc771c70047a96 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -93,16 +93,6 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
-static void nvme_update_bdev_size(struct gendisk *disk)
-{
-	struct block_device *bdev = bdget_disk(disk, 0);
-
-	if (bdev) {
-		bd_set_nr_sectors(bdev, get_capacity(disk));
-		bdput(bdev);
-	}
-}
-
 /*
  * Prepare a queue for teardown.
  *
@@ -119,8 +109,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	blk_set_queue_dying(ns->queue);
 	blk_mq_unquiesce_queue(ns->queue);
 
-	set_capacity(ns->disk, 0);
-	nvme_update_bdev_size(ns->disk);
+	set_capacity_and_notify(ns->disk, 0);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
