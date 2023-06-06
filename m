Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC9EC7EE2A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 07:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4vTkM88Q4vOnIk7RWnBk9kClYM+gvOSK7rFbMW2koP8=; b=K66aIRbL3VtFEB6IprhiRgJsPY
	cCUQCTDMm846i/9WjybjK9TfRKPHDRyAcw/LJIkxDu2okidGfILPBQd8Dbl3WhqI26zOHX0S6GuV/
	eliP9wjBjFHNnN7met3wtMTRnUdOX4Tl+B3V9l1LYIXGTmIXrhHNuD3F7b/bpPUoOR0q5LSJ4NEOB
	wWNaEKR1UrwUv771TlmPYfPZ8sJzwO9ktNlVekyBEQz/zsVvKFwRiZP1Pdy4MJfenXg5ooFIOuMY0
	pk/cpOgHpUYUBz5CtzVy4Q2aHqvtab+dof057kAnKMbdIsRNrFIA0EZ1adRjR3t54A45crvz2GZlF
	Ii7NVVsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RIP-000Ych-0k;
	Tue, 06 Jun 2023 07:40:01 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RIK-000YaI-16;
	Tue, 06 Jun 2023 07:39:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 01/31] block: also call ->open for incremental partition opens
Date: Tue,  6 Jun 2023 09:39:20 +0200
Message-Id: <20230606073950.225178-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
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

For whole devices ->open is called for each open, but for partitions it
is only called on the first open of a partition.  This is problematic
as various block drivers look at open flags and might not do all setup
for ioctl only or NDELAY opens.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 5c46ff10770638..981f6135795138 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -683,9 +683,6 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	struct gendisk *disk = part->bd_disk;
 	int ret;
 
-	if (atomic_read(&part->bd_openers))
-		goto done;
-
 	ret = blkdev_get_whole(bdev_whole(part), mode);
 	if (ret)
 		return ret;
@@ -694,9 +691,10 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	if (!bdev_nr_sectors(part))
 		goto out_blkdev_put;
 
-	disk->open_partitions++;
-	set_init_blocksize(part);
-done:
+	if (!atomic_read(&part->bd_openers)) {
+		disk->open_partitions++;
+		set_init_blocksize(part);
+	}
 	atomic_inc(&part->bd_openers);
 	return 0;
 
@@ -709,10 +707,10 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 {
 	struct block_device *whole = bdev_whole(part);
 
-	if (!atomic_dec_and_test(&part->bd_openers))
-		return;
-	blkdev_flush_mapping(part);
-	whole->bd_disk->open_partitions--;
+	if (atomic_dec_and_test(&part->bd_openers)) {
+		blkdev_flush_mapping(part);
+		whole->bd_disk->open_partitions--;
+	}
 	blkdev_put_whole(whole, mode);
 }
 
-- 
2.39.2


