Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A5C433E9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:11:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541D92087E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541D92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BrNt/auezuR4TATrjVe2dueOmtWdFnbbHCWsazxnJ1g=; b=RZOVZYzqegyn+Gri5QPV1troD
	IsUWHhCGknv9kwJdeENQOmfye+06e4Edg8/Mc91z7Q68tjhwaPl3Olv67ihR1vLKx6t8jiOOjffZc
	lXlh8SurKgNX5RFJvTyQbcMW8zamJhB8KRla1njSs1tS6MXgqxFy4k5bp3EHHtp1ZfHDTcqkzMlLc
	/hZYrijF/9DicvqV3/hdo6KgfCGFb7XBMHwfHzrWlg1enVP/r3ez2o6FYuQLUAhj9mCIO1nZkAOeP
	PUiJxaqhynTKPEHn/wqfPb2vaad/0F1aQKDFzbxUnGY1aHnGDiiKDE43VMc+3bXaNJfPCSEaPyzaO
	Db1ivglzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI8l-00038E-8s; Mon, 04 Jan 2021 05:10:47 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI8i-00036t-4I
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737043; x=1641273043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R91N4OJCuometnQDJ1w4j46SwlbKLZn5XO72xfDzsGA=;
 b=L76C3bvYtrYUe/EzfDLFKQbf/0NfzUGQtJfxp6drYZajiaBxYfhz3pN1
 cne5HJ943JLaW17qvS5GRnNLptA5Sh9y6eEHx1dF3KABsJyTb56mP/Bkr
 OU6SiPlHCW2ZJXGb85OeqAuep4mNrRwe1dCJKmiU5c5L4qTkTNLtMiWIu
 REgfJ+GX3lozc4pma+6hiJSUqcmmPkM+HrTgETpd84lK2BH0KFcC/42ab
 PYgt+O0Mnq9RT6enSp6VOaNCWzOlHZQ2P47y0Fxgb5li6z0Gty/TGkIEX
 w7Xi1oM8jMzPhlDitMwcdwyZ8kBePMFR3tz05ktpJvuxqzBmPhC1r1ZIs A==;
IronPort-SDR: iRK+pTFsSy+Rf2vQpYDL+vZdSAzDFJq5+uFsRn8phkqAvAHdeT7Iu51w2SavRDJD9bGZcelEOv
 6U6djhlNw+W4pTNwbYDHvRUayVxiP7mrx0YtMvVo/kfT/AuGOz/o8/3dGisO72OrhS93OKRr/2
 Igtjznyw0jqKv9uQJ7wmK797CBO81EMT7i+YLOFPR8MWStkJtfPCeteXlQwym8BM2fAF8EtatQ
 vka5pyBAGdlQcXlzkPoMJ2aQmQYL/FuI0iCCxnt7poSz6y9R1J4HBFtSzp3ZJT0csCZTXGswcO
 CF8=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156480939"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:10:43 +0800
IronPort-SDR: LV7NsyVWYTYeuLiaHRhAtpawKmZxsNUfuKJhahQRTp2s+NOjqJbe9IgCvXHZY3XxtmgHk32zxE
 IXF9KLr1reLI+nzMC1hqBczBW9t2a8wXJ8y3EiQgvupxSi9bKsuVlz8oUOfUvSIHx1/qXLQSl7
 OPGlcA4ZBp65gcNMDk9eqfymKLr+7kxc81GSBJ8A2m6Um/JrDBlPT3U1vBrO+5p5ubU5S9NWag
 /1WAlIqyKVttx374LxmMZ+wq2CYeXV/djpjWXmB42g8F2LePSYSl0JqGSLq6o5jbrXk7F29jH/
 cXyT3D3FDBGrAPkb16rry50+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:53:52 -0800
IronPort-SDR: y5NIO1FexAdalp4SIBa89uhDg3qCKmw/sGNx1X2YozLSKDfqvqNfTraN/HFn193MUCk4Ru7lzM
 K4UhrF9TnfYcZZauiDzzzzxHpdFQTeOME6ZGjfM9432XSEadbXRGb7gQpcWJBRjA9FLOVKTF2C
 rou2e/FE1edgRnHVzPacj7w9cUJAqNlulPTxm4uz3W7FrAWOZ5ERFfAlE4Zsp/wG/Ea7o5Vcl5
 APjf3/NchZmGZl3/5SKtHnFQtK5XBnrzyK7PahRSsvbdb8g3IYaLp5wRFdfV6u/v4LGlQdqYaK
 +MM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:10:44 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 7/9] nvmet: add bio put helper for different backends
Date: Sun,  3 Jan 2021 21:09:36 -0800
Message-Id: <20210104050938.25745-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001044_341084_61B0D199 
X-CRM114-Status: GOOD (  14.28  )
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

With the addition of zns backend now we have three different backends
with inline bio optimization. That leads to having duplicate code in for
freeing the bio in all three backends: generic bdev, passsthru and
generic zns.

Add a helper function to avoid the duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index b1fb0bb1f39f..562c2dd9c08c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -172,8 +172,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1ec9e1b35c67..93ebc9ae3fe4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -679,4 +679,10 @@ static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
 	bio->bi_end_io = bi_end_io;
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 54f765b566ee..a4a73d64c603 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -200,8 +200,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			if (bio != &req->p.inline_bio)
-				bio_put(bio);
+			nvmet_req_bio_put(req, bio);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 92213bed0006..bba1d6957b6a 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -330,7 +330,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 						 bio->bi_iter.bi_sector);
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
