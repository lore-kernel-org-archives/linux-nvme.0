Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81324C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415C422D05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415C422D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BrNt/auezuR4TATrjVe2dueOmtWdFnbbHCWsazxnJ1g=; b=WWIBSPzZ01mBV3ayyts2pJdHa
	TTVlt1aw7ghhDbn3HY9S1SyYi/+HbMo0WeHcoBfbVpNn6jN0Ydp6WYv6agEj1nXwu8FW3Yj0s7R/+
	Uo5z78LE9WefYtZ5gktRnF1VeL5hbREn7/4weMa3a0z1GFpNwHQdCyx2lGDgE51Ns91f5gz3Lk4iF
	/gZDGr4JNbUnw98frl4A1/QjVHx1GpMUivFRTIDCDanvYlBPRf5L5B+lYzxVFuPWe5JbYui3XNqZ0
	dnRg6lpn2fY27manfjNydb23Lr5qC0VrkxYi+pzNLrxAKoYV+c4o27IFoKLwiNt95NW4O2XIkLq+G
	/B0HQQDMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBHV-0000xB-2a; Tue, 12 Jan 2021 04:27:45 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBHR-0000v9-K3
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:27:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610426412; x=1641962412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R91N4OJCuometnQDJ1w4j46SwlbKLZn5XO72xfDzsGA=;
 b=Yiw7SoAC4+FPVypPOSTqvUrGH6grIKQYo1J8Pbtwr1vI8aht06pBu6Fz
 J3zojNTZh7UmnecUGwkqnerSgHcFyAVb2LskDEhXqq3r95yjmfRpjNXwW
 iyIFxGRf4er1pbocrVAZd0PS9ceJTqvx6wjeCB/clkjmArZHyDGojvceM
 MUiiHSixx7PMQHlGr1cqc5mS4LsyW3nKvVh4ZHLh1c8REahKnOzCI921Z
 JdCMHx0ckxgtJbT+RuRkS6TUXJZKKLsaZV+Re5reTG4L4R+PHeR0YgMy0
 0TtVe4oFpo6SXUuzip/NtWrqChJxK66dz6pbnRtjThsPmhhhaYpzlhSYb g==;
IronPort-SDR: C1cTDeiK++yd08PLSl5LT/nXIwOc9HTmGGUYytCoo9JuJz2KIdRWDfIidwnAl0P0UKeH6mNsSx
 qbx13PJhuJsnib7+nXAHnk3QQyKB+k+U5hkdCGsTpwgxvyIPyvG+nBRVg8wMIZNUwQdtS8urbn
 Yu9K7xq2U+QlF5k3N8YQW6/4VNJLMV8u0//D8YK1Pc+xahZFgKLkKshf7AFwD7BH0vi/5v5LdP
 xicHIcjQWKB/EgghARnUwsjGq8+vNGCEowi2Ut3ndVrxdWQ4yfZUHgXFlvbdTNTqKti9mDo6Ka
 llc=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="261100195"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:40:10 +0800
IronPort-SDR: 5+D0Es60/c2i8fqZvVheinDhdUF+Nx0dSw6SFULbTHBRXovvtFL85mB0KREwf3m8NV1mOislG/
 Gw2DpAr+RbiBPva22DL24bWAO+xGGWipxeGOjMBT1pfY7Ab7TmkNSjU8W7F9WsoBYiUrUzgt+X
 6rw3otEEB+maNViP3AHdwkyZFbw7ZRnOGzABhidjXHb2y8RtnGLPfSP9DsST4uWrw34wDUq/1a
 NChb4Ymjt5bkNN0afnq4im/9sx86QBa9Nu+9ziWWtM5wUsRsN6DY8ryJlzl7qRadNzomdPLIiL
 WnG4yi37+2tS/9AVQAqwps3P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:12:25 -0800
IronPort-SDR: cxxBy+WvCfwIT1aN0fSwJRc2u0a0ZFgDTUxwy0EBRvjkwF5bLgRJxyGovX/xmoU5rD13K1GVW3
 bdxsbX9+S3UcDkMCpCGjBKXhrIFLsNudnpIbh02UZKb+rDNvC7X94PBTsTVMXU4IcTzEW2MnfD
 tMQTA/NR6PSxweczXJaZ4CuWvi3jCPUyPVqrWCAKzkWUwzWWBE2H7mhRd+UczzKAfmny0o7SUc
 DZGVO0+0N9KD5Y8dTLMYYtCGL12zKvk7hNnQFP2nqENoLuup5VbnhyugiO/z/cJ8vcXYCdyjMq
 NPc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 7/9] nvmet: add bio put helper for different backends
Date: Mon, 11 Jan 2021 20:26:21 -0800
Message-Id: <20210112042623.6316-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232741_844215_2FD2AF0A 
X-CRM114-Status: GOOD (  15.10  )
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
