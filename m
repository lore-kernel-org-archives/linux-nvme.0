Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57FAC27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 05:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcS17019swi+eot3hQXZLSEBmFN0nZ0zcexqseGp7yk=; b=xs1NW7sjpun6VPH10LgWCbbJqJ
	jseB8fIv1e5AK6Yoj09QRsGNKtHu8p/GRcUnb5aIMER/jqEw8yu/sGj9ztK/LbGM0odDi1KLYKTrx
	wNOGWaLJvxzYPyfqTe7mSlKbPu3QY1w0PRBlaJw6VlxBQA6AlCrqs2Lzs90YZJp+MIUC+IhBxaw8L
	c6JFgnNqAzZA1LlyRJIPp/RzIrCuo2Y934x9fOPomr4vR39dJYwzJhqHUd7rXBruGm476ujiL/vJ6
	VAhHKPOjHe9hTDfjgHhPKRdrsk5lA+lE8++MuDj9zIUtPtjikUkC0Usk/JWx8SqWeBQ2zJf31I4z8
	iWt6WZ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdR-0000000CZzT-1fs6;
	Fri, 07 Jun 2024 05:59:33 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdF-0000000CZyO-1Bpl;
	Fri, 07 Jun 2024 05:59:22 +0000
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
	Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 01/11] dm-integrity: use the nop integrity profile
Date: Fri,  7 Jun 2024 07:58:55 +0200
Message-ID: <20240607055912.3586772-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607055912.3586772-1-hch@lst.de>
References: <20240607055912.3586772-1-hch@lst.de>
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


