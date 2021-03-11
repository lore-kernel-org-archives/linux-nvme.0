Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E43BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:40:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0206C64FA1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0206C64FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JIKLNHvqaY9LCfX66fMnXg6rCALK2paS3bHM7Pulmaw=; b=qVtH4vbCekgdeXC4aBGMMwTHO
	0Z/yW8R99oga7cZeQHi5pGZUpqXXtSD1Ti8vdTdM0uuMkIWinnbRKQ2pdyJHoGxvut8841ExRnpUL
	v8Zbxs/9lT+mKOebCjxdf5GG42/d7/Uodi3entMhMrYOwB0dGpHt4xEPUB6kbKj0ZWARFfAruKta2
	gLWARH+xSgYjraZzCv97d1dBr2cAvcC6RV0RKgJM3Y9d7DfS83tk80YZN3ArVKP5Yj/LsPiKaGlFf
	XDaBZ0CmUj8WL0nseJDxbrDYRphqlws9DI5iMB8Em2CcHrzXOqM8N6FcXuLvdkpWKiBeKqbcXNmXx
	T/Q1W70/Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKD7D-008Lve-Vr; Thu, 11 Mar 2021 04:40:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKD71-008Lsj-37
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 04:39:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615437590; x=1646973590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dlq4Ng5olUi92WqDmNPaUwlDdG4EE2zaZkCDMKxMzcc=;
 b=m10UCv/Cv+WLeTZajpjApodMXIZqmAfEii7ZgGp7EX9kW7/2f/1AvpKV
 BdQzo2Sh7sj3zfq3YO4u0ipup8ucywY5wrSt7JwrfAlZVYkHkiOQhtNnW
 ZSpJi0DhWkb7q2GpJUIEhuAF5qwk1sFiYnG2zy9fJUrVTyCG7J9qHUAKt
 JzJ9CNpP1vIHH+8AaL62zcsctvLAr3Wuc5jRi4nrMZZ98zxzJNype0rP+
 eZrIWqqZTXNiW1aos7TMPykEiS+48GOTytgc+J9XjWIMsSE3hfZeHRCqx
 OsSqY2QtiA4E38KoWzyBzlRLRXOax3P4YMzHjKMNkAHnb7h5EYtCIysip w==;
IronPort-SDR: vCR0sj8gTN56KKhhJ5V/5unS5EUr9PgNUevgq3Q6fiNqE0NZZr/+w7zUWjxdn+dFT54HwdR9yw
 FPPZoDtV+pV/UKagjEA0K1Racd6qlVgqYDi5ujJqFIORDAe273UyQaLfyyxXv6SUaLZ/mXliJs
 lFTGmaq156dQZ1UzGLL9mBaz4I0C1Z8UVL+pTXt1MQqHtzqIpQ8V+Y+mLt3jgeixRFPVAbYjl1
 9YVik2rN2xLtx+wsQB9pUul2aaO885INBN/DNNIRat+EK+9CsHSTpFhX/KGRDNFfkiauJFV8R/
 hVY=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="161895148"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 12:39:46 +0800
IronPort-SDR: 42/Co8p3g5kvval5fKJK9Re0eWs4RlzGidpmMAzalMVkvM92d59B3rtiMZqBRhjCRojhY86rm1
 O7qmoNkwqyTpkTurVwLD/Z3sJqKTsZRglMiZQDyRkbDSLpeBZaiIfb2+SFSUzH1waFKBdXlKuG
 FTRdgNeLiJ5Egxkt5zD650We4ZaLyrrWCsGE3eiK3oYvlZI0fUqSbtHAlh1OJ6ltEK2E5mTDSO
 2UD4kmXcI7g0iVZSmOhDIWlr0w6aCs8c+UFonC6S12ktCbXnm7W/y6YqJq12SQiga5ucVfR4J0
 J4kkm6Qu4BBHRIEZc5wne49h
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:22:25 -0800
IronPort-SDR: kseHOUegAGlabnDROML6mpcNBLbgn5Tk7zT9sipwiaOfZlidxRI/JmwcxnyR7pGQ4tbOCLah3R
 60w93Tz2ajokAAIu/eLq7Tbza5jYcM5gMCyD9Rz6gqLEEefg9B2KUHdz8zz4YEmDixG+1W1BPr
 FklFC8bPiRBK7MvxRKCt+OvwfYZkHVsiNJ2jasJbttfhK5v76ZpsJchIbKJiukH/zrBuLGOGO4
 p6Q29kQAp4nUmWCV6SGxGzHQoHpDnpF3W9VJwbBhIaUL+wC5okTsmsnnWYYpOP65VWhUFvRXsk
 ejU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2021 20:39:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V11 3/4] nvmet: add nvmet_req_bio put helper for backends
Date: Wed, 10 Mar 2021 20:39:07 -0800
Message-Id: <20210311043908.26146-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_043951_505422_77CBB5FF 
X-CRM114-Status: GOOD (  13.51  )
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

With the addition of zns backend now we have three different backends
with inline bio optimization. That leads to having duplicate code in
for freeing the bio in all three backends: generic bdev, passsthru and 
generic zns.

Add a helper function to avoid duplicate code and update the 
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ada0215f5e56..ca39d787d71f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -173,8 +173,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f3fccc49de03..2f1bd3ac34a2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -654,4 +654,10 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 26c587ccd152..011aeebace55 100644
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
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 8121b29df766..42f16ce55fa0 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -321,7 +321,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
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
