Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE39C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EC022D05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EC022D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5WkN4XFjNyWWCL9rv94wJbHzE7n21SlImJJ77/L6vDM=; b=PiQANuLDFtRmCEtK6NRdhPGe2
	nmCkUWZymTX3JOQxcR21ezKTJCKrhfif3zEaeAFhW3OAlKeZL7LXNQCOu3dVukr+AXH+vs7qLBe8Q
	94ilnumIR9UBbJ+EzLZonA9cuKgnL+GayG2y4ugsQpoAAYMFOFm8gJoeqKrfc6WfIYn7BYAvt8BvG
	p8NxxXM68YTUBQVcqnw1bfrQUQZVvd/IDk+tl2046KjAyXs6mv1x2V4MMsp87tfrvtcjiQk1TPioi
	G2xb+BaveXLwg8wCS0t8M3a1qsyj3F1tKS1NZ3gM9D3nd9ZNQOXOAmJ5DFwgj7viqI5J0NS0TlpdR
	/rsNFRQkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBGf-0000bq-Ti; Tue, 12 Jan 2021 04:26:53 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBGd-0000af-LB
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610425611; x=1641961611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+dzMfelXKXKTtvlSdWk9DFOOoxVVf6e3u02T42xzOzM=;
 b=IFYKoS+PCrI/aa17rA5SnVxIw91xmusloKZ1g/7SP3otBu3lhSRasBiH
 80kTK1JFs4EeeLowOS5J0EaK05ZHommnDBT8Wf17t5M6WzI9knuyXqL+T
 VpBLXi6yRBGf9hXYgJvtRXxFYcBkc4WSZmUHIhKiDdj7fay+GuOJp6B3c
 thuUnQZZRu0FGZvGtFFxoyAOlWZ3Kcu6tZiYY6kUfgoFctp9WKw2cVsQT
 Ts441aSLXVsqxMsvHj21UpnFCBy+Kx6Ngubk+Pu12yp0XpcnBL2LPk72n
 9WeuECfwnM3Zf5TF2W+Fg/nPZh6pGhPb5TrDk39akLRF7KvNYnKMutksi A==;
IronPort-SDR: uAaqXR98kV0MFmBuEWZnDEZcvjXElhob6LwKGNA/NkEiQcAtymjKQqAEP7xVDLiW7lXnmilW5T
 RJIZVz8PvX5HjQRNp0xZwYoFdV69MYJPSelRfgTV3sE/fKKdY5LhTx4a2ZhIBvv/1tqMQaDZgc
 O15OPEq3qfndwgLqNdb2qLbSYYZ9HgFBxd9c8LlEBZZr9dPkUVIBofLgXWJFWp0gV/CFlycDUv
 7L+o9iezSdkhIfY1q8b99Wy7IR8WYtKT17QUrMSWRZytkiFg48vmovmo6QlnFxfKeilK6vRvyl
 bYY=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="161648525"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:26:49 +0800
IronPort-SDR: 5wV3zKntRcUgRoY3DR0LDsuhkihQLcOPgVbtooKI7L4RAU2kR2eltuw4mOv5OHQvoQauRsGEJ2
 VwtQrFp0fIuUbFSTHlVR5BAjKeIjPg7JpMYQPDJBcnraCkRoOqytX0qlXC0lnvxv70KYu0jlb5
 mfctUMNTOhnHdW2DH91m8j1aoGljVrplmvclakKzHeT7tJsvcMKNkWUMHUhKjR9SYE388PfBKS
 b7YERk71Z5Cgl72+xtdh8G08FWCm1R5BBBHjyf0J9+OhMNxzcF1A9843UXN9IbEjNCozYHEsj+
 rmt2RRLpFORL4ydatUalcIdq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:11:35 -0800
IronPort-SDR: TL3SMAN4xBZTCWgOcB7qrMyfXMq+v+dIkYcgd8fk8wm/f0XrOO7oKqKfN6qbvV81ui7rbbUL+D
 jYYVBqeZTPdsnA0SWeIOLBJ+vgFR9dOG+Ey7HKAa5NBWHp1R6VVemmMlhFYk/KVecLUqCwrzn1
 OZ6Um8+0/xsCkbYy/nU7ojODUrrkPU1I/AVyHghuDphaFIJ9bPd96jTIp1w1+xGLfR9+dPXBnj
 SOiXrsH9cstotShUvkwy4s/4L7nFk6+j06UVVjRaFG/QB/DqUGzPOU+AwASS9WDIKc9i1oUCEU
 U8E=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:49 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 2/9] nvmet: add lba to sect conversion helpers
Date: Mon, 11 Jan 2021 20:26:16 -0800
Message-Id: <20210112042623.6316-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232651_862161_5FA7EC12 
X-CRM114-Status: GOOD (  12.64  )
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

In this preparation patch, we add helpers to convert lbas to sectors &
sectors to lba. This is needed to eliminate code duplication in the ZBD
backend.

Use these helpers in the block device backend.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..23095bdfce06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		op |= REQ_NOMERGE;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
@@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
+			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..8776dd1a0490 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
