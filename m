Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80395C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:26:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FA522D05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FA522D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ubSVP1qQiJZtXQl1lbc5FZ8CQmkfGSQphXx2o25xagM=; b=zCfvj1qmqj3yeF1kk2uUhL7Vh
	r+o8giaEZR8tJs/8PCDEYQ4RjNCA+gqeeZywx4vzrq/cTscPiuhrx/gcSE10GlSG6iqcqbMH0Ug8s
	qLs7raDAN/qaTE7qVfgKPH3NAf9+51SX5niRPsLm/fD6N3nLYKbjDFnANU7pNjuQehzDewmz5S9tW
	bgT7xKYLqusnlKo7fOYIhKinrmamm6mnTMcwORXi9l7WQyuPcOgCGQZgZd0LrR+jZG23eb4t8xeKZ
	W3DeKjLVC7RRxPB8GwEMndWWFI2f1Gu3LMzwS2Z68uc0jA5OWyBquJejzxskGcVdQSTYs2xRvwCon
	U82U4tMDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBGX-0000Yv-05; Tue, 12 Jan 2021 04:26:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBGU-0000XV-0x
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610425601; x=1641961601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=88Lp0y2hIyhYG8It0MWl/SOspuKedN/u1kjgeCCanzg=;
 b=RhrVSFN2Xsl5INISCKjWtvKEmmKbi5mHKxUhLHVRyim1XNKPCDBvcHQF
 pwgSZHjKh9lUKrPejaawPzU1sG9eYhtlqiKZPskxnHDkSG719Y/FFafng
 L40Sms/NGelqNGJrH8ZGXmFJQvByIkaKM+4Ak63wldLH8MMvrs2xu4NYn
 8rpR2sJstKqZM7Gx+PkSm9O+MwLfn/ZeXBU0aGfdtCweh8LRWq+7HkHgx
 f+poLumsez02BNWzqEtiXY5c6jQ2QTmeCIggf0H3Yd3aRBqinUuAcpesT
 RMiabA3/StWkiqiaVn2EZ8DOLKEYqxEDX+D0VqzFIVyXOiuWn+rMvbr3T w==;
IronPort-SDR: B9GtlsZDDm2mjNwA4IeaMBEXyDm2nvTt9Dezx13dECTJ1lweFI8np4tloxLOB84SmPCzBDZl8i
 A9H9IU78IRIWNx/IRhOQ0q9cIL8XenqYDiXRIaVAVAdc7Xn0ibjezlvroVId73SCcQ8bSQit/s
 1MPS+tmcyJZQm4BWryKouUQJHQ5Intu72902J9En3nbikpg0UUDCf1KIN3DWy5YwTo+AlpWMTu
 JaavOal7LRKaWO/+z/rmvAz90F1aakKwXtRqsIyprsW2fe0hhILn4dO2XoTROPhi8ipeJpAVV4
 w9k=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="267504781"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:26:39 +0800
IronPort-SDR: ufPz2fx3Ty4DZQTInqUJh4ALQq3CFoOi4LN79wcs5IGwyOIvQzeOlwPKbS8uzNHYV42dUb/1vv
 m32ZRy5m5+Hqmfw67TNlfLn1M1SHDVG/LmJFF6eFBJtpbMl3qfF30GJBASBf/dVhb/6hX5cVnM
 6KmQPG4ERzRp8D/hzUfyy5WGxAXk8Fra4KdY6s+VB/2Uk/2kQ5nCgPXk9bQWiHRzZLCPdzEdPz
 IzT1ps9Up6JWfTiceeMktYxENQ6iXiSq8tsa93YTmezM+XqAzlZOkW/i8vMxjQFPi47XYpJkYA
 dEhqDbk3iCKrhWzzGHCjWvOZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:11:25 -0800
IronPort-SDR: z9UEULbt+pn4EiVfrtpVYsW4uNE3iQHb/kMaXpXrBGK5OJsYzeRp8/hluQMcJj+0oxxb4BOTbx
 xvXDFYSk7usjy+NsJx+AIjnABMWluqNdvJtxanQhSkRgwFQ4QONUbof8F+2EKSGyu0Mon9pjaa
 0rVURICapY2zI2/O5zVoA830o5l7BDqAfRmxT80F1QnkfY8SsV42ZCfFy+74SA1zsH4m3PCfyM
 0Ng4P/kMJOr7Wet+ZDCOW2Vb7mhGjyrKTrk416ogQExjh1DYMSV4MbHRyVEEMceeb8SkLzH/Lu
 ROk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:39 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 1/9] block: export bio_add_hw_pages()
Date: Mon, 11 Jan 2021 20:26:15 -0800
Message-Id: <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232642_428902_F8C31C81 
X-CRM114-Status: GOOD (  14.63  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To implement the NVMe Zone Append command on the NVMeOF target side for
generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
need to build the bios with hardware limitations, i.e. we use
bio_add_hw_page() with queue_max_zone_append_sectors() instead of
bio_add_page().

Without this API being exported NVMeOF target will require to use
bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
extra work which is inefficient.

Export the API so that NVMeOF ZBD over ZNS backend can use it to build
Zone Append bios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c            | 1 +
 block/blk.h            | 4 ----
 include/linux/blkdev.h | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..5cbd56b54f98 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	bio->bi_iter.bi_size += len;
 	return len;
 }
+EXPORT_SYMBOL(bio_add_hw_page);
 
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
diff --git a/block/blk.h b/block/blk.h
index 7550364c326c..200030b2d74f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -351,8 +351,4 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 070de09425ad..028ccc9bdf8d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2005,6 +2005,10 @@ struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
