Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42BAC48BCD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:34:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798F461059
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798F461059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fy5f/YvWW21WGiru/KiSA+dxFQ21HXM5sjyiyYfkGrA=; b=a1Jc40X9/Uf14L
	IIdhiHBeiAL5HdzVd1wJsPgo8LrVQaBYnTLrTKH+SS5i+QE6bK1QOdq/z+6BB7yv5KXgxmoElpld6
	YurVieaoGCbPkiQBtO+/9V0wyJKCTK/eZIENvOMfbjK+atThoD4WBHpgYvQpp22ToeHTGQcYPTiTR
	tS+h2BDOY3VUD6cbTlFf+dXQnq6HWtN+R8N2FZgoe+PXTPoMagRtPcGvJqOLZ5KuOH4dgB+wgo5vl
	GUCIPO3yGWScFOLv2hNd46oNOdL/oc9OrIfrDYlFvdHwTEu+rrgDHHTOSnmeg9U7mCxMbKWlos3tY
	MgSbtQe/wssnY4YZeTJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9a0-00GGlo-UO; Thu, 10 Jun 2021 01:33:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9ZV-00GGd1-8H
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288804; x=1654824804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K2a3BW/K2scus12syH9yEOlFhAjm9xMwk1rT7lOToj0=;
 b=bADg+OSmYMqsp46zGIEcMqLVl/6PF+144PzJEeTpc7ZBchNAHai9C0mG
 fJLXMJAh8DQlJjZzKdz7QrrppchedZj5mSWVlxWriL1LKrZl6Z9tCaB1p
 gLpke/ewQht1J/uXgwNXFLrGijWenyuI4zvRMGyw29OnU82QMAqxo47vn
 pvdLx8otln7xxVi9YD2pS/FVG3eYhzFKUYE1n2kVXL9odJgoPi2WlzQHS
 pq8nXzzPQZEpZprkKJzu+nRykPciOERDnZF0PBfD7oP1RPSTNt/3LN/jn
 nCgdYnWaMlJWwCu1DUUG3QjeanFDm6BuXKmzHECgVmZD5En21pZk4oU+d g==;
IronPort-SDR: doPP98GEG1UB6795uAQaQN5xBiZ8JwdHrkRnQwui1C6fV7JWgNEi9ONBEjM9dnKHPmCpU07fDP
 CO+TNIeK0wvR+o6LvKGVh4FPZDNFSW4brx7boQQaF3MowBmnaTV+/IuEIcUdutNkTvHaTZFuZL
 j810U4v8GISry0FOjbZHF3HDi/65gn5jrq3XrIwpb9025K5QpeFU5uL/O8P+GywPQDvTc9N59Y
 POZT/zBfd72xqd6vXFWSpfO826PHKhcDBebhH66H2u7z0qbOnRHlGwMB5NztIWYbdj8R3uWTYi
 Dj4=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="282813654"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:24 +0800
IronPort-SDR: KxiLa0ScjBRnTDnXHwXQy+IpOr0POs4ngPhhW76oKF9v7QP/5JQR16B5DTQcLas8x8TQdUrtrr
 3C/VYvFPR2pm4KdGBabECKyUZcLbOyQWff8ZfCZfY3B2BOChb1phHa4xGF5QqOeYsvExh6xMOs
 93NRo1l2K9USoVKXWrJv21rBRp/LCeDMqJVBY67SgKruezFY5IgmdkumApK1NQmo7lFyxnsC/o
 84zbZ07BTpztgbtRWekEBSPFt6nTWGqnpqDHupugX06Iit47I4R5NqQtnS34xMUEQAaJflqgwz
 graAx+CwxF9jS9qgeZFLHkSI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:11:03 -0700
IronPort-SDR: ISIKHpV7gJma7HPfnYGRhc5fWeBVXQDbFSHOsi+2MRV0CRNGbD2t2pgAzP4z7Pc5Ylvb+FNIfb
 X94ySPBcArLQan5MAbj87GvPYSJNGaN/FR81PW7U95ztAksJB1aopD1zp3DPSiK9Jinhk4KaKY
 LKJ3d7psb4l+J4L9AVDVL96oNk9kz9avwYk/XtRKRayWCmKI8KqROUVZuR+rkOa9ppnS6ynDSJ
 ulpbHF6n7dGyWGnEKjjM8V6dwa4zWBTfdh/XQME4H9ehPi1zjCEHgu91fhgmhxHTKVMydiJXag
 2bY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:25 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 3/5] nvmet: add nvmet_req_bio put helper for backends
Date: Wed,  9 Jun 2021 18:32:50 -0700
Message-Id: <20210610013252.53874-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_183325_347023_2B3FCFF7 
X-CRM114-Status: GOOD (  14.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In current code there exists two backends which are using inline bio
optimization, that adds a duplicate code for freeing the bio.

For Zoned Block Device backend we also use the same optimzation and it
will lead to having duplicate code in the three backends: generic
bdev, passsthru, and generic zns.

Add a helper function to avoid duplicate code and update the respective
backends.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f673679d258a..40534d9a86d1 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -164,8 +164,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f53ce96df498..d4bcfeb570e5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -632,4 +632,10 @@ static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 39b1473f7204..fced52de33ce 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -206,8 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			if (bio != &req->p.inline_bio)
-				bio_put(bio);
+			nvmet_req_bio_put(req, bio);
 			return -EINVAL;
 		}
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
