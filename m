Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0679C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9140522D05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9140522D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NCxYEPD4kGaKifNSac5tjIh2U9q3WT+hhUQiLCN10+0=; b=iLuSuzqtjkiQfO/CM3UPpqTM+
	C1KtFmpcDL7oJFBQgHS3Ggq3QtG+jfPWxHIkLrg8SkfmQkmeVnMbiixQIO0RkujKV0XQpYBF19kWs
	3CcqW2Qshm2Vku+P5mzSCWhXZWnBDddjWGuynIhbL/gh7G47u/3Bhk09eNyoc4q9+OszNUvjzt35r
	UM8c8fUarpNEw9xoZqmNpGAIK9t56GBvlA7Pyd89uXBEwg2v4c4Yzs/mPAhA2b77KYuL5VcGuXHqQ
	sxsn5kGRl1gXwyMEdw8OpSX9xBv8MC2ST+fOyIwKUCXSmoy28khwQ0naotb55B7ICPiaWsTV8SjKe
	vnk841Z1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBHJ-0000rp-NW; Tue, 12 Jan 2021 04:27:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBHG-0000qQ-Ab
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610425650; x=1641961650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b7JlLdLhTEJHSJkJ2Ot7J3cXNRNUJqtnFvAN4lx8PoE=;
 b=pAa+dNgbArHQ3ZIWVQbQVh8u8WKEH3hQu9baCfPAV+2ziXQCNuofVhHZ
 CShBr2HamRdf4gl3rVTfNgLzaycSjZ0ExaNmUdzXFPrcAwRcDFq3sj/tv
 3Ne/JEAKdhipnpGtCU/b+SD0WpMj6Pb1FARtvtjxE2kbTR0p6iuOcmE1c
 BEQr1WZ3rS55myEc7IO2XUL5mGu2BBlyvs73P8KiuaTS/skbf/RSXC617
 0HEi/3RLmG3xBqJdGjU8SwdMI+HyKPUkdbM1SbdFxLFNzP8Sfy5fTYsaD
 gDibNE36SLP+wbEc3CnN8XiABxDSlDRKTiNxAL0VddX+TiewB5NW6uuMG A==;
IronPort-SDR: ZSmO4lcvynVc6MX7uPsyoq4rWGIOuJvEGrN9L0ip8C9VcjEQacgAPhysy3UbFVJef8j5IGactn
 9W8i5f1HYd52WlCysa2Yzz0ynPfdtQlPnESfPJpO5RRv0yfkec3VRJrsHUfuq+xW5L89Ku5111
 ch2D9/U4K5kk+wBBArpo69wIfdoo9HQOie1kp0rzIh5PxKfhUh5C5t4290ND7WJVG21Q9BZfYV
 +5IpBE91ByxsvS8U6CCqzTcVszBWjdwnh+6p0CAiDBngH0E8mYiJlBiOEPfgxWjk6fI0XOglVR
 1aY=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="267504866"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:27:29 +0800
IronPort-SDR: 3uNdmZx7mf7eATNZQyWySiAsens0C2ds2sonjmwGP5tUZzDqurAHQnNBNPZ12Hc1ufc7UVxbMy
 XNeNu1I1iUGICNwsMnRdlnB8QhLen/7TdhSiytOXSZpMGFv6HzX9BPmU39GWGh1gG2jMm3eBqd
 5KaO4dXsfCDANOsHPwh35peJVaIWE7lHcEPf29MccCBtnKxykMIXuZ6GbHdcvs6iWNQq7DyTAL
 dQFrKky6+0gkQGmhFlcdTZxk4ocMbjsTSD2iQtOhAjIN/zMG+GL9QbvmIptWzuz7UaI4FW6Cl3
 qvP1ci+OhexrubQZo85Y4qNK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:10:22 -0800
IronPort-SDR: o/sg1RlO55nBZvuaf2UOWUKg+CwrJQNyX5ExWX1SiQ1CQgy3BqgOm1LU6PVb42JWsHrs1QDrz3
 J4uJFV4zVQf6HISX5Eyak8w1215IcPdF0qV6tiyMi7rmneB27b5IacvY31BmKRQmfMifwJdI6O
 ilxFN4yx2Lcch6etVa3iripRW7bx1OkyKCMAqN0sVauyJcMtAb19GNvzUQFF7IAq+s35HG8MzY
 OyGtGIawg02tKIBBBAuIliFJgPfrBuIYFc4kVsoQYs7Xf1YHt4zwOXnUpOZml5byXfy6e9HCE5
 GNM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:29 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Date: Mon, 11 Jan 2021 20:26:20 -0800
Message-Id: <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232730_539895_DD0F018A 
X-CRM114-Status: GOOD (  15.83  )
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

With the addition of the zns backend now we have two different backends
with the same bio initialization code. That leads to having duplicate
code in two backends: generic bdev and generic zns.

Add a helper function to reduce the duplicate code such that helper
function initializes the various bio initialization parameters such as
bio block device, op flags, sector, end io callback, and private member,

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  6 +-----
 drivers/nvme/target/nvmet.h       | 11 +++++++++++
 drivers/nvme/target/zns.c         |  6 +++---
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 72746e29cb0d..b1fb0bb1f39f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -267,11 +267,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	bio = nvmet_req_bio_get(req, NULL);
-	bio_set_dev(bio, req->ns->bdev);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_private = req;
-	bio->bi_end_io = nvmet_bio_done;
-	bio->bi_opf = op;
+	nvmet_bio_init(bio, req->ns->bdev, op, sector, req, nvmet_bio_done);
 
 	blk_start_plug(&plug);
 	if (req->metadata_len)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3fc84f79cce1..1ec9e1b35c67 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -668,4 +668,15 @@ static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
 	return bio;
 }
 
+static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
+				  unsigned int op, sector_t sect, void *private,
+				  bio_end_io_t *bi_end_io)
+{
+	bio_set_dev(bio, bdev);
+	bio->bi_opf = op;
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_private = private;
+	bio->bi_end_io = bi_end_io;
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c32e93a3c7e1..92213bed0006 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -281,6 +281,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 {
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 	struct request_queue *q = req->ns->bdev->bd_disk->queue;
+	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	unsigned int max_sects = queue_max_zone_append_sectors(q);
 	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
@@ -297,9 +298,8 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	bio = nvmet_req_bio_get(req, NULL);
-	bio_set_dev(bio, req->ns->bdev);
-	bio->bi_iter.bi_sector = sect;
-	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);
+
 	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 		bio->bi_opf |= REQ_FUA;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
