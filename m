Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75957C27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 06:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVlPq2/3UP6xOrwmHdGKzgza9gCdhisKIqS2joU6Vdc=; b=4UezzR40wn3ULJ9htYe07V73g3
	vRcBP4W7Zox5VItP2kEMpVUguV0You2hqVxAA9fv9E1hLtoVqgbrQ7sNdge7TJAfrhYXKPDroTheE
	/KAzq9RWwMpDsjrjyjkE+bXjUcfjwVbc4/zG6YdzJjRYIrsrcOX7a+4xHg3a2gzBTAcPOVWnUhks+
	530st8I4uP4+Yvf4ZzoKQzWumcbtWHLtfvN71hfhWJ7fWuUoMHRTkTrdvQ7tJWLD8PhnZj0srOJS6
	MM9iqbIImt6oepB5z+WnUx45gZqD3QU0TC586ZKWfqjY9Q7sKdONT0zzbRhaVuekhxlYivgpBMAMA
	ai0Z+4AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAU-00000004mYE-2wt4;
	Wed, 05 Jun 2024 06:30:42 +0000
Received: from 2a02-8389-2341-5b80-5bcb-678a-c0a8-08fe.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5bcb:678a:c0a8:8fe] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAR-00000004mVx-2c34;
	Wed, 05 Jun 2024 06:30:40 +0000
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
Subject: [PATCH 02/12] block: remove the unused BIP_{CTRL,DISK}_NOCHECK flags
Date: Wed,  5 Jun 2024 08:28:31 +0200
Message-ID: <20240605063031.3286655-3-hch@lst.de>
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

Both flags are only checked, but never set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c   | 14 +++-----------
 include/linux/bio.h |  2 --
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d957e29b17a98a..b477383ccc3b2a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -806,25 +806,17 @@ static unsigned char sd_setup_protect_cmnd(struct scsi_cmnd *scmd,
 	if (dix) {				/* DIX Type 0, 1, 2, 3 */
 		if (bio_integrity_flagged(bio, BIP_IP_CHECKSUM))
 			scmd->prot_flags |= SCSI_PROT_IP_CHECKSUM;
-
-		if (bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false)
-			scmd->prot_flags |= SCSI_PROT_GUARD_CHECK;
+		scmd->prot_flags |= SCSI_PROT_GUARD_CHECK;
 	}
 
 	if (dif != T10_PI_TYPE3_PROTECTION) {	/* DIX/DIF Type 0, 1, 2 */
 		scmd->prot_flags |= SCSI_PROT_REF_INCREMENT;
-
-		if (bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false)
-			scmd->prot_flags |= SCSI_PROT_REF_CHECK;
+		scmd->prot_flags |= SCSI_PROT_REF_CHECK;
 	}
 
 	if (dif) {				/* DIX/DIF Type 1, 2, 3 */
 		scmd->prot_flags |= SCSI_PROT_TRANSFER_PI;
-
-		if (bio_integrity_flagged(bio, BIP_DISK_NOCHECK))
-			protect = 3 << 5;	/* Disable target PI checking */
-		else
-			protect = 1 << 5;	/* Enable target PI checking */
+		protect = 1 << 5;	/* Enable target PI checking */
 	}
 
 	scsi_set_prot_op(scmd, prot_op);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d5379548d684e1..ec5dcf8635ac66 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,8 +324,6 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
-	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
 	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
 	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
-- 
2.43.0


