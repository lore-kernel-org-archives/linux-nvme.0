Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6760BC27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 05:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAwIXqFq8jPbhoH3KNZ2ya0sZoPUVKscbFUCAGHaHt0=; b=l5qCn3thvpx6K26ndNAJ+mgn63
	DSsez9+AKzh5GGZUilfQKES3NT1iQ/tQN1XdVWU1TrZR1c2Zus/gvNfT3+dul+1dAwtp6l1fhFp+o
	EQb4mxc6VYUtR92Xh97k2Cn8pqSmpS0pAL/cCHpI1f0aJbc6X8ql2YR32NaOn/eM60MgWMd6gSkN5
	dwS5cEDOYUOCZpfcFBEfizogjtgVRk+1SHfwwZYpZmSS7R/9hs9aRD4nTMj+g4yxyaT5/ON+PyQRM
	WdSgyg1eGMqt/7Mbp92RC+BWtU7qEyLWZ5oAsbX0wOUAafx+qAW5s+UceX1d1FSzbO5ML2QN0cAh8
	HVbJg+OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdg-0000000Ca7p-4A4a;
	Fri, 07 Jun 2024 05:59:48 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdL-0000000CZzA-3CPY;
	Fri, 07 Jun 2024 05:59:28 +0000
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
	Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 03/11] block: remove the BIP_IP_CHECKSUM flag
Date: Fri,  7 Jun 2024 07:58:57 +0200
Message-ID: <20240607055912.3586772-4-hch@lst.de>
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

Remove the BIP_IP_CHECKSUM as sd can just look at the per-disk
checksum type instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/bio-integrity.c | 3 ---
 drivers/scsi/sd.c     | 6 +++---
 include/linux/bio.h   | 5 ++---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index af7f71d16114de..c69da65759af89 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -488,9 +488,6 @@ bool bio_integrity_prep(struct bio *bio)
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
-	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
-		bip->bip_flags |= BIP_IP_CHECKSUM;
-
 	/* Map it */
 	offset = offset_in_page(buf);
 	for (i = 0; i < nr_pages && len > 0; i++) {
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b477383ccc3b2a..e21b7df5c31b0d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -43,7 +43,7 @@
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/blkdev.h>
+#include <linux/blk-integrity.h>
 #include <linux/blkpg.h>
 #include <linux/blk-pm.h>
 #include <linux/delay.h>
@@ -799,12 +799,12 @@ static unsigned char sd_setup_protect_cmnd(struct scsi_cmnd *scmd,
 					   unsigned int dix, unsigned int dif)
 {
 	struct request *rq = scsi_cmd_to_rq(scmd);
-	struct bio *bio = rq->bio;
+	struct blk_integrity *bi = &rq->q->integrity;
 	unsigned int prot_op = sd_prot_op(rq_data_dir(rq), dix, dif);
 	unsigned int protect = 0;
 
 	if (dix) {				/* DIX Type 0, 1, 2, 3 */
-		if (bio_integrity_flagged(bio, BIP_IP_CHECKSUM))
+		if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
 			scmd->prot_flags |= SCSI_PROT_IP_CHECKSUM;
 		scmd->prot_flags |= SCSI_PROT_GUARD_CHECK;
 	}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ec5dcf8635ac66..3295dd6021659b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,9 +324,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
-	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
-	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
+	BIP_INTEGRITY_USER	= 1 << 2, /* Integrity payload is user address */
+	BIP_COPY_USER		= 1 << 3, /* Kernel bounce buffer in use */
 };
 
 /*
-- 
2.43.0


