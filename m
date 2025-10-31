Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0FCCCF9FF
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jB7cK9HNYMZjlD+mQIPuaLYyooeoXbuwulFzEAU5k/A=; b=tW3yNxoU197m+YBxtI6VTmUUeN
	Jfll0S4o+raThl5haQE4wlghrxYpCo1GBAv53ibLsn/OBVkYHmG8ye0/jJhhbFkm2mAhzea74f9OM
	aQNBmHMGVq4Z41//DCyhdt2qfJy7+5xWq6vZgzXKd6eGIAE08zQNQInFkZbAUSKDymSCtabu09qIo
	uxiH82YTpSR3EDVItjK5saJGbbbez9+bbbz+SbXvtvxpCWu53fuRyreNzfOXF5jMrwsdmMayKoy4J
	kNcoyM2tpWfyGkeHgVB1MHJbdfh8+EqNsNf2R4V+L9jM1dtbZ8DK64MQrT0Eg567B5a/27Yu3ysl7
	Jp31gcTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRY-00000005Rct-0rpK;
	Fri, 31 Oct 2025 06:17:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRV-00000005RcM-1898
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:16:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 01B0E44C33;
	Fri, 31 Oct 2025 06:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66021C4CEE7;
	Fri, 31 Oct 2025 06:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891416;
	bh=duBFtoPw9t/qNc2aCPdlDSxz6a5mXbzd+DjZAQAHWIA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lR9Y8FgTwdR7lPv5dY6s4PqQp/gg4HVPJPOBoBNhILHXuy6X6n61LnyK27zCjEdhZ
	 pGfFmSAxBVGFCHytZeqb3oNrtKL3MN3AHuyJx9q2AAEPqu3bLTeUxRGnCGVc21E/2A
	 eQgkZ4rkVAzZ+PceBJ7SPX9dZmiPun4FMSsY6YDW50rfjJuzIxakVHWIp+AylHZPbB
	 6IDOl5bOukQtXVEXVUvxY7llt7+QV+QZyH0eFSNOroFyPlWq8uea5pIeIbQz25quN5
	 5c69KoyhIMOGNj4M6GM/bZ5SU8c8pp3TzALweLXxl5wyjw9q2BDRaSrN0SMZ13GoEN
	 tw05Af4QykGpg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 01/13] block: freeze queue when updating zone resources
Date: Fri, 31 Oct 2025 15:12:55 +0900
Message-ID: <20251031061307.185513-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231657_387540_EF8C7F08 
X-CRM114-Status: GOOD (  13.62  )
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

Modify disk_update_zone_resources() to freeze the device queue before
updating the number of zones, zone capacity and other zone related
resources. The locking order resulting from the call to
queue_limits_commit_update_frozen() is preserved, that is, the queue
limits lock is first taken by calling queue_limits_start_update() before
freezing the queue, and the queue is unfrozen after executing
queue_limits_commit_update(), which replaces the call to
queue_limits_commit_update_frozen().

This change ensures that there are no in-flights I/Os when the zone
resources are updated due to a zone revalidation.

Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5e2a5788dc3b..f3b371056df4 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1516,8 +1516,13 @@ static int disk_update_zone_resources(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 	unsigned int nr_seq_zones, nr_conv_zones;
-	unsigned int pool_size;
+	unsigned int pool_size, memflags;
 	struct queue_limits lim;
+	int ret;
+
+	lim = queue_limits_start_update(q);
+
+	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1527,11 +1532,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	if (nr_conv_zones >= disk->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, nr_conv_zones, disk->nr_zones);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unfreeze;
 	}
 
-	lim = queue_limits_start_update(q);
-
 	/*
 	 * Some devices can advertize zone resource limits that are larger than
 	 * the number of sequential zones of the zoned block device, e.g. a
@@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	return queue_limits_commit_update_frozen(q, &lim);
+	ret = queue_limits_commit_update(q, &lim);
+
+unfreeze:
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
-- 
2.51.0


