Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFEAC71157
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AphzsfxjNeKVKXBI0eht8VGHFki7UqreyMpiNst00kk=; b=IiDIIOt82wICmksHQ3opW3/dr7
	5RgXsF6L9wgjj2uHgYEezYmtoUokEy1NiXVua3YVsAtcKPLbjALVdxj7sTKeRQQd4J/KOIXoHDeVO
	vPysyhGzylyi08sbwjomaTfFueDP1Iy6sF51bN0cQYkPP1R9WjadU1/LhCCcP/CvKk/6Y8vZa9Cmn
	pmkF35v9E702dtiY1N/K2dng206SZugeKycEzhaC7SJqjF1GC4LeQ8gp3OVzuriMdQZJZzFE8R2jY
	aFY1obd03h1OV+SYRqMuQw8OhRXY671yWfc+hDMCiQa3+v6wwcuIUiPi5kaP5wqo2yrRADjX9NWH2
	yPbc6qWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRljD-000000097aE-0O0y;
	Wed, 18 Jun 2025 05:52:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRlj9-000000097WR-2ZhZ
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 05:52:54 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250618055248epoutp0288f622e1af5a647bda6cdb35fe95aff8~KDT7aXmV_0240302403epoutp02R
	for <linux-nvme@lists.infradead.org>; Wed, 18 Jun 2025 05:52:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250618055248epoutp0288f622e1af5a647bda6cdb35fe95aff8~KDT7aXmV_0240302403epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750225968;
	bh=AphzsfxjNeKVKXBI0eht8VGHFki7UqreyMpiNst00kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaqFDF8k4BA63Dg0MkmxtBvBwYqll1+Prexk8q6/EqErzcNWRyBn2oZEEqYr6bWwr
	 QeSGgvjmIsVJlPSs1nL9Ap0q/b+6WatUs0oj8S4qrVdoFtunXMj3lHovteTugL1U55
	 LZulMs6NWnvhMUf+dc7eNpjGG8Szmp5GKZleq9ZY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250618055248epcas5p12a63e6201e1e953d7f1f4946513407b5~KDT6xSGRA1875218752epcas5p1Z;
	Wed, 18 Jun 2025 05:52:48 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.177]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bMXvf21VJz6B9mS; Wed, 18 Jun
	2025 05:52:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250618055215epcas5p3232e90ae38bbd6667aacc6d32abb4189~KDTciXbNO2388423884epcas5p3k;
	Wed, 18 Jun 2025 05:52:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618055213epsmtip2aea9608f13518dc675ff961d58899d03~KDTaWbUnp3085030850epsmtip2N;
	Wed, 18 Jun 2025 05:52:13 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH for-next v4 2/4] block: introduce pi_tuple_size field in
 blk_integrity
Date: Wed, 18 Jun 2025 11:21:51 +0530
Message-Id: <20250618055153.48823-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618055153.48823-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618055215epcas5p3232e90ae38bbd6667aacc6d32abb4189
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618055215epcas5p3232e90ae38bbd6667aacc6d32abb4189
References: <20250618055153.48823-1-anuj20.g@samsung.com>
	<CGME20250618055215epcas5p3232e90ae38bbd6667aacc6d32abb4189@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_225251_966106_B697A7A7 
X-CRM114-Status: GOOD (  16.95  )
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

Introduce a new pi_tuple_size field in struct blk_integrity to
explicitly represent the size (in bytes) of the protection information
(PI) tuple. This is a prep patch.
Add validation in blk_validate_integrity_limits() to ensure that
pi size matches the expected size for known checksum types and never
exceeds the pi_tuple_size.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c     | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c |  2 ++
 drivers/scsi/sd_dif.c    |  1 +
 include/linux/blkdev.h   |  1 +
 4 files changed, 42 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 787500ff00c3..32f3cdc9835a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -14,6 +14,8 @@
 #include <linux/jiffies.h>
 #include <linux/gfp.h>
 #include <linux/dma-mapping.h>
+#include <linux/t10-pi.h>
+#include <linux/crc64.h>
 
 #include "blk.h"
 #include "blk-rq-qos.h"
@@ -135,6 +137,42 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 		return -EINVAL;
 	}
 
+	if (bi->pi_tuple_size > bi->metadata_size) {
+		pr_warn("pi_tuple_size (%u) exceeds metadata_size (%u)\n",
+			 bi->pi_tuple_size,
+			 bi->metadata_size);
+		return -EINVAL;
+	}
+
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_NONE:
+		if (bi->pi_tuple_size) {
+			pr_warn("pi_tuple_size must be 0 when checksum type \
+				 is none\n");
+			return -EINVAL;
+		}
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		if (bi->pi_tuple_size != sizeof(struct t10_pi_tuple)) {
+			pr_warn("pi_tuple_size mismatch for T10 PI: expected \
+				 %zu, got %u\n",
+				 sizeof(struct t10_pi_tuple),
+				 bi->pi_tuple_size);
+			return -EINVAL;
+		}
+		break;
+	case BLK_INTEGRITY_CSUM_CRC64:
+		if (bi->pi_tuple_size != sizeof(struct crc64_pi_tuple)) {
+			pr_warn("pi_tuple_size mismatch for CRC64 PI: \
+				 expected %zu, got %u\n",
+				 sizeof(struct crc64_pi_tuple),
+				 bi->pi_tuple_size);
+			return -EINVAL;
+		}
+		break;
+	}
+
 	if (!bi->interval_exp)
 		bi->interval_exp = ilog2(lim->logical_block_size);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b027dda38e69..fe72accab516 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1867,6 +1867,8 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	}
 
 	bi->metadata_size = head->ms;
+	if (bi->csum_type)
+		bi->pi_tuple_size = head->pi_size;
 	bi->pi_offset = info->pi_offset;
 	return true;
 }
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 18bfca1f1c78..ff4217fef93b 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -53,6 +53,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp, struct queue_limits *lim)
 		bi->flags |= BLK_INTEGRITY_REF_TAG;
 
 	bi->metadata_size = sizeof(struct t10_pi_tuple);
+	bi->pi_tuple_size = bi->metadata_size;
 
 	if (dif && type) {
 		bi->flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ccda87d06a38..0d4011dcfed3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -120,6 +120,7 @@ struct blk_integrity {
 	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
+	unsigned char				pi_tuple_size;
 };
 
 typedef unsigned int __bitwise blk_mode_t;
-- 
2.25.1


