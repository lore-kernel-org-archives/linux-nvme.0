Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C422EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3B82087E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3B82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NCxYEPD4kGaKifNSac5tjIh2U9q3WT+hhUQiLCN10+0=; b=LdetK312e4rZ12zuh0VU1RSsV
	M2CbT0fso/GlMo1ltrj13dB3YBODVQfVGXD/96IpAgqqbUp7jIX6zdYxJPCs4U99mIr87r8yE1dEI
	fM65kwr+97bRU7Z5m62ThqIj0bwvZ5owaqlv0N62QzvXXrgP3fD72fJbSMXtmjhdgiNwsi/P+oHbA
	GWV8LFJ6SbB9xo61x794UNdyeRLGBpLTPyiuGBDOnLGrkZFFEprZfYM5X0OJyW+MvFTd+xt6ICtWF
	4EpuPWf8iMGoZm3+wwJ94bcA+7lCAlEd6uF6aHxMNc7w9ASaftKd0xa5+PUt7kfi/ZIf7laHB56DF
	ibgW7wy+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI8d-000359-1K; Mon, 04 Jan 2021 05:10:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI8a-000340-0l
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737699; x=1641273699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b7JlLdLhTEJHSJkJ2Ot7J3cXNRNUJqtnFvAN4lx8PoE=;
 b=RY9vWxbfr/81jYwG3Ved827/V1DxV7sM3/8sto2nRC2GpkbNHM1Hh/JU
 fIGZ5S49X6AuDr19WyoGHF8TnXbWvhHq41WlMjvCDiXVj2QdTja/byKEq
 6dZool08uG2MBVUcn9hjadBe0jvUPEBGI7I/Rtc6aebi+fwAFBuKclj8b
 jWUqVpfoyhQS9aYO2lzRUpLOkPgfmSZzyd953+wx172cC2nGJwXp+xXqQ
 mbVWJBt7rYoZWp6NJcfd7xKqKNqOmuDNXuhLIr8QgFfLHKa0cVkyQSxPc
 pJ3YIGuj8ir/4aeAWgrha6nfO7Pxs9MfFI3+g5SZDnp5id5RZVnzTVGZL Q==;
IronPort-SDR: 7l3DHVwOESVgtN2TO4+BIkeW4MiLKjgIpMybObdL7uzlRUJ3aqf0CpS1ws0ivrZQxzorUuP/2J
 P7gM22TNgBxpJfuhdL7ugD3JJ0VSnteqK/C33OpStMxYF4V52lSyX9z56HnedOhnaNiRefSvEg
 daoQJaMBzpaBMaE65I749MWZPTZGhWznPFbMhJX6IxeD34RBn7e0586f0nXPRMv73tHuHTe25D
 VSHC1xA7RS930tnBa4p+BNMZXOlLLEZln+sWo2S/1/dpp/bHC3+XUmlft177usGRuewtxN9DwA
 qpQ=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="260321536"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:21:36 +0800
IronPort-SDR: bNzIDBgwQ04mXwUK6TE8QOsNTqsIQj6MDZ/AvPIHngtN9ZRkxeL44hNCR873aExUZTzSU1TWDT
 xXDGkayQHIBvfpk6tyYfGFU1JWTAlKRppFGC+M9K6mUldxIm2zkHz1S+qzxygfud0bGWsMUnTS
 i9nV2lvfLrrtaCDatdkZy5kmkPTe94Ucx5FoGLasdtUGRv3xmj/PGIVzJXWkj3A+b02IC1xyxJ
 BmdqDuqxzMC3k+dG82AGS/3iuu4Xwvhmj9YHbQ+XEsZZZlpXbhGw07tyJSEkTcnZrf42PMyXJU
 EF8XKsGOxtmIAPS9gtZoZiBX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:55:29 -0800
IronPort-SDR: P3psn+7q+AuoW4ooHJLfm6KWAOxCiuHTe7jGpXzzg5K1GMrgh4T4nYjgR3m9Eklitx+ZIo42pq
 3eD8mEaRhq/SvCIRObPS5L/XfQS0P20AYsmniQsy90ChdULVAR7N8It89e0e3XkUH+weOVSwn/
 D1AisNgqeW4WcXQGn6PXytmMtfYWYGecV4mmbi4idY4ySjhfdwun79dMo4ShQJHlf83gGevZhU
 cOI0oBoj6tiMRYE3XCC1XxLoUav8LbiSr3gq8wgA/BzhwUf+fHpUBXJqAugHooSsjQIhEOB0eQ
 ZpE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:10:35 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 6/9] nvmet: add bio init helper for different backends
Date: Sun,  3 Jan 2021 21:09:35 -0800
Message-Id: <20210104050938.25745-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001036_493101_BB10CAD3 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
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
