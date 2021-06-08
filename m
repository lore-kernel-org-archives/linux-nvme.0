Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3483FC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:47:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEA761108
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEA761108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HCt8xTAJeazgYP93dnylI1gqpCizJXn0p567AoUp4Mc=; b=Ywrh7+TKXPWv+g
	D34LgiNqWdW8KgBF5KO8ZSZmRmg2GiIoIwPqR6mY+Lay7mVDP/aaPa28LAKiutDU/QJ3nXY0MXTyu
	TCBVSHO1NPzikkycbPQU80pGCKWEcitGWMKZaSqcYIkVN9vPg1Pg3hU7Vo+Czr4Z6XHGjUKydWCIT
	myyQx6XDH6JnlT+dNsjkpcW8M8xcVJYRGw6f35x9uZPKGMx7KoVQLdz2GiTrwdeYwPGiIoCUAzXO4
	/KaVDxGYVpvk2+LQkXwHHQ85583P/Znn0vpT4VLYpHT/uk21o/MjRjuyR2FuO3zurkbazK/cwPTYL
	G378sGUAbMBZWAbfjWJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUaR-006aeY-2s; Tue, 08 Jun 2021 05:47:39 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUZu-006aRP-Of
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623131224; x=1654667224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=17oBnF3kbw+yqOuJrzzPe8n0ZEHxjbS4tGwTQxYAudA=;
 b=HHTDQwmjdZpw8hBrx2vSwRz1mxx301hZlqwGONMvsvESmXj5h3ICubA2
 6ROFk1Jz42w5E6g3MH1THpQrQZ0NQg20vulIzdccuQ8oxltOcDpexcmcH
 ixwEAWEqFSc6GOxLyORLs/NTUhYbAYUDevSJ6hPZ1zs11XCUc1kdpqXn3
 9Lp4+TNZ8DgppnoskgUY0d6dbS64qj5P91oa9B5KiJZIUBKzChBcTvxI0
 YMtY+cE4FO2jtEnuq/AmscgFpAJ2fjggR4/hKorJFwXg9oEnQDInoiK+H
 N0HO5FjrFTsc+e07iOoXODkHLEbakSSzASa+e9WtWIFn1Vx2+mHh/GNo4 g==;
IronPort-SDR: LcGQiD92Ln+aIRkF09cKpPc0CWFMw52YMQE/Jp2fOLBivuBujQZ+9+y2ACtNz+Ttcbx8+RLO+0
 vF5DvgnQXgQYjzoLwhPXdGvw1ERYw47VE6+sf0V6ZZwnt0vKs0ozuImD45cS6JmlGa8xUd/iPk
 TWNcoS3buUHptZB6p2qlsNZGxR/JUQ+h6Bo9DBtdPW363kY7Cprm/6+N0qItqVvy93ABB5Jbit
 CRoZY/xb7VO9UcJ6V+0IBA6pAAuN1WWreTWJ8FteKm0/0MykNjN7cYHNAV+BGj5ZaoG2jJHf2d
 yNI=
X-IronPort-AV: E=Sophos;i="5.83,256,1616428800"; d="scan'208";a="171110311"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 13:47:03 +0800
IronPort-SDR: F+8gIzFG0NvShZ/DoqpTtd+3kAloLZKlwS0P8hEnB4twFBYEJCRtkRIP4Cg0I8swp3Y3rtx1Lp
 458MKqlodIRpvPt5PHYWjyf7RWSZE7S5HInQZj42ZKEnetKszbqlNqfS8VboARac61XOW4qUWB
 egYhBqTgkUbfVS916+FfnkYAp69t9yjexqFUsCISOrS/JxkQAQc6yyo9kVJAEwf6Qhc89iabx9
 4HIr+t4Pl68kEzZX+aKiNGWyqx1mT82ej6XGohGgvfgoy+vs/Z2Vg+mRPoPP0yTHqzxAjLrC+b
 mdPvoXAePYieMkuTOWGNQb+x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 22:24:46 -0700
IronPort-SDR: sdD3ajTn1+J7kQrQaXS7rf4MQaLbxt1s/9LSQtryK1UksSg2ejaAvtpzk55W1ySxzCooMrHja6
 zKy88nTiycsJ6d90GD89Cs3BZB+euGFd831ybWnF6qHwDZ8nxbMaBQdIxLXoWbbkK26vHVrQus
 yr5Dx/vdXKsNFzb076cKFEq5OmpY/jqmQIENIpe1bieNaSnauc9fMaa6WWLcbKfpB6OqzaPwBi
 VSxNpeGrmmlBh5WbU1k4CTaYzRbJ8d+L6RR3gL5ugxYJwo6uZuhc20bjNJookl72snZy9sfaT2
 B9w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2021 22:47:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/5] nvmet: add nvmet_req_bio put helper for backends
Date: Mon,  7 Jun 2021 22:46:33 -0700
Message-Id: <20210608054635.5661-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_224706_839646_7A151A89 
X-CRM114-Status: GOOD (  14.97  )
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
index 058b6d3d48fa..a7d035be9f13 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -630,4 +630,10 @@ static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
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
