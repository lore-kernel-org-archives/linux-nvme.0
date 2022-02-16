Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7394AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7Uyl7G0unJ9YVGSQZEva2pB8H/CYU1rQkVTcEFAy+k=; b=mvnOIqgxoZtd6Um9+9B/dH3W/9
	4ruRUZ3X5OOdtsM1AVE/Js1BkSVVjdfIQzsytXxPCtjDA5bUMP/zp2TM/deLAb//qNkJBbaw9PYoK
	dHvrepuyAjn64wLYKUjt4Dr8m5KebyaBWm3E44losksTWPke8DTDAZRbh505L1B/XyM3jR078nmEK
	rhJNGCoFFzkRvhbr5tiMsNmrVzeqVJHOb2sjlBR0C9V1Dh3uHm0yojeIVbkyxJ8witbw+SYWQuA6W
	meM4M/OvxfI8mFBsulrjR2iQK9VgyDfzw5aAl1MRx8JYAcEhKyGry0VEt0CyiR2BpGc19musrVtbJ
	XlHkBYqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLvf-007ROs-6O; Wed, 16 Feb 2022 15:09:15 +0000
Received: from [2001:4bb8:184:543c:6e8c:bf25:364a:5dde] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLvW-007RN4-AZ; Wed, 16 Feb 2022 15:09:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Date: Wed, 16 Feb 2022 16:09:01 +0100
Message-Id: <20220216150901.4166235-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216150901.4166235-1-hch@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
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

For surprise removals that have already marked the disk dead, there is
no point in calling fsync_bdev as all I/O will fail anyway, so skip it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a6..f68bdfe4f883b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -584,7 +584,14 @@ void del_gendisk(struct gendisk *disk)
 	blk_drop_partitions(disk);
 	mutex_unlock(&disk->open_mutex);
 
-	fsync_bdev(disk->part0);
+	/*
+	 * If this is not a surprise removal see if there is a file system
+	 * mounted on this device and sync it (although this won't work for
+	 * partitions).  For surprise removals that have already marked the
+	 * disk dead skip this call as no I/O is possible anyway.
+	 */
+	if (!test_bit(GD_DEAD, &disk->state))
+		fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
 	/*
-- 
2.30.2


