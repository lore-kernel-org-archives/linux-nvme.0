Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32899C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 05:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luAONBAN0nJiG2qd4IVk/ym6PD3j8Tq+GbpZg5S7V1o=; b=I/LXL9uHmu4WVTQv+l/EOndajN
	jSRzC5FFNsYEl8v+LfEgAYkOxobEnhysvKezaDscN271CDCd0VH+a3bO6U2FVJ5kOYcvBKGNorH3a
	8/FVlCkUf0DKRcXIzIKg5d5mb1Oy1DR1AGQyp9uNpuihka8qoUM5hi2by1gpkPGL+noeQYmv9bCFK
	/kccRP+9yro/RR9glPaP0+Xmkgwj3Fwp7WFZ2yjdMuF1UBmihJLSaVkwfQv9MUfM6ZgPgyO5jqe27
	WVQDDYHicM3f1/TQd0PGE4BRYIKAbJpb1u+Jhl15dRMwqYY1pyllisaMek3caDDjRG6LljjV40rzw
	TLVczHZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSda-0000000Ca1K-39uj;
	Fri, 07 Jun 2024 05:59:42 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdI-0000000CZyr-2JmH;
	Fri, 07 Jun 2024 05:59:25 +0000
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
Subject: [PATCH 02/11] block: remove the unused BIP_{CTRL,DISK}_NOCHECK flags
Date: Fri,  7 Jun 2024 07:58:56 +0200
Message-ID: <20240607055912.3586772-3-hch@lst.de>
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

Both flags are only checked, but never set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


