Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4045C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rDZ4qt3AoqoPcKWZiGxU0EtuQJXHPorwNNYlCF4FSTc=; b=jFGCydGtoOA4P6smqQEygTsofg
	s/XszJMRQ9wZQwmi/Lqp3+HJtj8qIHhJDTED7gNbKS/iLgXnAXPyTaHEB/gzif6OyuvI1TFXxM6IK
	xYkIKxf/K2LPvPiwcFOe0bj6XKn/9eCL/BusPTr73bs+T5s3tyZQOdSSZ32gDxEbRxJEQ/mOjneec
	nJ/pUPrKjyeN3AUbU9tyNUGOeYO5Ybo8o+bMWi2g8UC7Sc4Q9ZLBGQebmZh5MmECu9hiFQJECqEjU
	T9+saLd3BniCMZjLYgx5FCDQFkS220E0Do5e5tgRPug8pfqnd9ihaSejAkc2hhgKozX/xuex/dh3U
	pXVEup7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8f-0000000Fn93-0tlZ;
	Thu, 13 Jun 2024 08:48:57 +0000
Received: from 2a02-8389-2341-5b80-034b-6bc2-b258-c831.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:34b:6bc2:b258:c831] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8b-0000000Fn60-3mbI;
	Thu, 13 Jun 2024 08:48:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Milan Broz <gmazyland@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/12] dm-integrity: use the nop integrity profile
Date: Thu, 13 Jun 2024 10:48:14 +0200
Message-ID: <20240613084839.1044015-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
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

Use the block layer built-in nop profile instead of duplicating it.

Tested by:

$ dd if=/dev/urandom of=key.bin bs=512 count=1

$ cryptsetup luksFormat -q --type luks2 --integrity hmac-sha256 \
 	--integrity-no-wipe /dev/nvme0n1 key.bin
$ cryptsetup luksOpen /dev/nvme0n1 luks-integrity --key-file key.bin

and then doing mkfs.xfs and simple I/O on the mount file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Milan Broz <gmazyland@gmail.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm-crypt.c     |  4 ++--
 drivers/md/dm-integrity.c | 20 --------------------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1b7a97cc377943..1dfc462f29cd6f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1176,8 +1176,8 @@ static int crypt_integrity_ctr(struct crypt_config *cc, struct dm_target *ti)
 	struct blk_integrity *bi = blk_get_integrity(cc->dev->bdev->bd_disk);
 	struct mapped_device *md = dm_table_get_md(ti->table);
 
-	/* From now we require underlying device with our integrity profile */
-	if (!bi || strcasecmp(bi->profile->name, "DM-DIF-EXT-TAG")) {
+	/* We require an underlying device with non-PI metadata */
+	if (!bi || strcmp(bi->profile->name, "nop")) {
 		ti->error = "Integrity profile not supported.";
 		return -EINVAL;
 	}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 417fddebe367a2..c1cc27541673c7 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -350,25 +350,6 @@ static struct kmem_cache *journal_io_cache;
 #define DEBUG_bytes(bytes, len, msg, ...)	do { } while (0)
 #endif
 
-static void dm_integrity_prepare(struct request *rq)
-{
-}
-
-static void dm_integrity_complete(struct request *rq, unsigned int nr_bytes)
-{
-}
-
-/*
- * DM Integrity profile, protection is performed layer above (dm-crypt)
- */
-static const struct blk_integrity_profile dm_integrity_profile = {
-	.name			= "DM-DIF-EXT-TAG",
-	.generate_fn		= NULL,
-	.verify_fn		= NULL,
-	.prepare_fn		= dm_integrity_prepare,
-	.complete_fn		= dm_integrity_complete,
-};
-
 static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map);
 static void integrity_bio_wait(struct work_struct *w);
 static void dm_integrity_dtr(struct dm_target *ti);
@@ -3656,7 +3637,6 @@ static void dm_integrity_set(struct dm_target *ti, struct dm_integrity_c *ic)
 	struct blk_integrity bi;
 
 	memset(&bi, 0, sizeof(bi));
-	bi.profile = &dm_integrity_profile;
 	bi.tuple_size = ic->tag_size;
 	bi.tag_size = bi.tuple_size;
 	bi.interval_exp = ic->sb->log2_sectors_per_block + SECTOR_SHIFT;
-- 
2.43.0


