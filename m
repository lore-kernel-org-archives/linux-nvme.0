Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665BDC25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 06:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VRqsmzSPX+ptDZscjhdtBL0MV6B8FyDyGhjgYc+fFkc=; b=0WJNDQknQo8ddB1TrpYWC672iO
	MxYvasEu+TN0BEkf1Ye6AUHi8t2OFQUkjqRVlBO7Ono0eYMtTChdNoD0qca+4rjS1iHuO+svcV2LK
	eToq8rry6LJxRQQZSJPqfxFw1+MRCsdNcQjTw9rhfr5mmLAuLKcEg4qR3mwXSwC/KQeMJVD/sug6E
	/shHJYP8a5HSHwQ0OiYKDg3WhVxWN0G/H00LJer8KNRok3J0dWU56S1ys2VCKLq8xpXl2HRtQVokD
	negfr3gNU87a24sJwxUuu4xuq+klTdnKco+Myk3vLDlnu+0ccgiEblZRmo6HrdNM7R33CRgYV7ci9
	SvHmFWOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAW-00000004mZQ-42ww;
	Wed, 05 Jun 2024 06:30:44 +0000
Received: from 2a02-8389-2341-5b80-5bcb-678a-c0a8-08fe.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5bcb:678a:c0a8:8fe] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAU-00000004mXb-2Xdl;
	Wed, 05 Jun 2024 06:30:43 +0000
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
	linux-scsi@vger.kernel.org
Subject: [PATCH 03/12] block: remove the BIP_IP_CHECKSUM flag
Date: Wed,  5 Jun 2024 08:28:32 +0200
Message-ID: <20240605063031.3286655-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605063031.3286655-1-hch@lst.de>
References: <20240605063031.3286655-1-hch@lst.de>
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
---
 block/bio-integrity.c | 3 ---
 drivers/scsi/sd.c     | 6 +++---
 include/linux/bio.h   | 5 ++---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961eae..43f112ec8b59fe 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -479,9 +479,6 @@ bool bio_integrity_prep(struct bio *bio)
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


