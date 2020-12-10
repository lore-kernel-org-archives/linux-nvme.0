Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2CDC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:27:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36E623C43
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36E623C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O9wnAX/5QpkOLd4dZmIgJQ+7uKVgu5NDJBlI/2WOx0Q=; b=GPRFHiSeHrg2ZBHQ5iae+uLt5
	nZdgwFWjox6m0HkQby8ojbjo1qG2rPqhcxx+C2evga6rqnfC0GsOe+FW0UHlu0vV6ird0oy/djsF2
	PWIB7mXspg6AHb8bfcArOOgGutwo1kQ9EeFrkvv+MyXFjVh9iDGZNW8lHHy5vP7Juu5kv7UUuUAer
	w2VssLflzK3+AbOQ9i7monRUIuysUO7EK4ZYD5BIS1Cb3LWOJlQCzrZBNB4qDJExzkDKo4ayTnpEY
	yrNlcRuLKhFJWGOUR9iXlP6hZb0D3lxKdhisgGrn32UIZTQM94kR086kvHmFX44vE2DISq6X7Gm/y
	jThDYuGUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knFQb-0001Gc-W2; Thu, 10 Dec 2020 06:27:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knFQY-0001En-EY
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 06:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607581666; x=1639117666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YrepnEU+9E1QsZlnFlnVsVTqhlODTy9EkUh+6u1821Q=;
 b=CPH8aXq+971s26lXdJ/2tbD1dmMcT6ys7H0Q2JDsGa/POt0HMjLrSl/l
 MZ+BuiELBmJ8wi43eVUQ6Y41ezcMVx/iH6fXV5C9RlmWyVPoV31yOm6U+
 FPwZp8R6SnNira02i7fkvaLMNtTik49X3MkZMy4dxfwbhdH/hnZU99/iT
 IjBGiD85wxNW2XQYHiDkBi3z5ZlQjdcT1xSjBcMov/rvHQh+iC3k1PjYA
 5X8I27qKl4DZrB5fDk85XKTtDGapsBxZqHehtEyDh31W1+oFdjdYkpyAe
 0kTppHiR+1YPXJOHPxR0CfFUfgsFrBfcJ6/Jh4/yOt4eN3bwQeAgm1ez/ Q==;
IronPort-SDR: VXYiIE/Dy1vK32P/nBR9XUNR8x7M+vBVZU4at1BeimVEKep18XlG2iGdmFQFuo5stWfvSXYzKV
 9qwKSngWwwUWoTebTpmxhi+2luYlOUPVUHT+iiINMtoxop5ucJq8IsH5Xb3pbl/ImCXSu2fZtp
 DNj/rMLiJqcvBsmM+UpPaGHqT/TceZFh/ByWVOMg19F9phHTwYgWv5aIaY31qQ7Mi3HWlm8M7y
 9wKPYShzsOex3rk0X1VUjqxTIsk0IRVyW21bTbfiTFDQV3yqT31AqX7tOU3RLSeop/aPWatqIO
 ztA=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="154878090"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:27:45 +0800
IronPort-SDR: jZl+MDoaNUKayb6Jurh8WqGOrmQU3Uh03FMF0C87MBxnYiOdniTZR23Ky3EEs2svG8yToOa95H
 zWo3G3ffIGb9+zdprpnpnNmPyqW58NtWs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 22:13:10 -0800
IronPort-SDR: HmqZoYxzvof/ag7lL5BkZvGgcovkJVzTbGcDCyeQXgkH2sicheS5eSXy9SP1Rfh+b4R3CYRUGG
 8eaqt0XfpO2A==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:27:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V5 6/6] nvmet: add bio get helper for different backends
Date: Wed,  9 Dec 2020 22:26:22 -0800
Message-Id: <20201210062622.62053-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_012746_824649_CC91671D 
X-CRM114-Status: GOOD (  16.37  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the addition of the zns backend now we have three different
backends with inline bio optimization. That leads to having
duplicate code in for allocating or initializing the bio in all
three backends: generic bdev, passsthru, and generic zns.

Add a helper function to reduce the duplicate code such that helper
function accepts the bi_end_io callback which gets initialize for the
non-inline bio_alloc() case. This is due to the special case needed for
the passthru backend non-inline bio allocation bio_alloc() where we set
the bio->bi_end_io = bio_put. For rest of the backends, we set the same
bi_end_io callback for inline and non-inline cases, that is for generic
bdev we set to nvmet_bio_done() and for generic zns we set to NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  7 +------
 drivers/nvme/target/nvmet.h       | 16 ++++++++++++++++
 drivers/nvme/target/passthru.c    |  8 +-------
 drivers/nvme/target/zns.c         |  8 +-------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0ce6d165dc4f..6ffd84a620e7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -265,12 +265,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
-		bio = &req->b.inline_bio;
-		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	} else {
-		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-	}
+	bio = nvmet_req_bio_get(req, NULL);
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7ef416de4f6f..5d187642a3fa 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -618,6 +618,22 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
+					    bio_end_io_t *bi_end_io)
+{
+	struct bio *bio;
+
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->b.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+		return bio;
+	}
+
+	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
+	bio->bi_end_io = bi_end_io;
+	return bio;
+}
+
 static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index c2858ea8cabc..a4a73d64c603 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -194,13 +194,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
-		bio = &req->p.inline_bio;
-		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	} else {
-		bio = bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));
-		bio->bi_end_io = bio_put;
-	}
+	bio = nvmet_req_bio_get(req, bio_put);
 	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index d2d1538f92d4..dc841f8ae7b3 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -279,13 +279,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		return;
 	}
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
-		bio = &req->b.inline_bio;
-		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	} else {
-		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
-	}
-
+	bio = nvmet_req_bio_get(req, NULL);
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sect;
 	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
