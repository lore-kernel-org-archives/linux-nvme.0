Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3DC55178
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24716223FB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PMIuPDbM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="irGT1CRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24716223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RhUnvO1yLWmwMpdWJneOC4GZWcLJZsopNQQglqUrA7M=; b=PMIuPDbMqY1L9hO1Un9Ayhx8C
	ugVPcjsEVpO6tCyDjYp3ln0t//YULgY/OAF0+h4PNwzNUp572iZPcxzPt8J7aByAh/BUP26cOKcOI
	GknPA/XpGcEZABrkaVHUJ3n6KWpWa16/VQAQtEPH7PhKDFbudOCxOoZYZi7wj+eZItmA3jzqCcOxv
	+a/YqH2veyx/DRP+UPkk1CtFgsVUPg9bKDkNBW+vIlqjjdWvtqqLO/g1JtFfHpPUYUWrd8jk+ak02
	AAH1y/5qo4btbUy8SfUW3+mN/ZnOzTN9MoSAZ+9tJOQAJLURlD2cBV+/pe5pew0+uMUfhAIm9ktVE
	/HA07Gc4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVP0m-0004Bi-1Q; Thu, 22 Oct 2020 01:03:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVP0j-0004At-Eb
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603328601; x=1634864601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZjuoyMHl/0ocfowOMPnoFX7SM4xH6ht94j8DCRztaGo=;
 b=irGT1CRyNy11TFDohyCRY5q2niqjUFE3zf7IRpk9C3+b8vH076Zqyynd
 38MjTdTMvqtLQreJgiN9DtNlyMnHqAPGe1wjZoaoae0USAmBy+KOepGRo
 9luaM7F80mSM/7/lxtD1XBzEr8pcyFVd/RWGQRkVzE2K1tDeoWays2Y8G
 IWX3TUD9GkQskjkDavn7n3rssNXra96Hhvvh4atwoKlrADtRrdoki0ZXW
 ZX9fakxeT41fXjmgY+bOApa3C9hM94ro+z5bKSJ+XeKq8TES1mteKXlAC
 DecVopCx0e/DY9GLFSPXavaPMenHgcVhXv8abXvLnOfhVizOzkK8gPyUL w==;
IronPort-SDR: w5Gm9f7FJHcfOZaC3+IbT329W2Y+D9XKgD1bW3ugHdbEx55mHPPlhLOlDml3Wtzme5CW8rXaAQ
 n7QeGLxm2AHrfRxIqaccltT2dEJpKj/P5jJmY4Uw3F3zhahdBcMOrI1wSDjstfp/p5LAFCDm6B
 o7x3PWrKUEdwmqqRAaHa3QDkCbYeQsgmss1pqrZ19St++NjB32w1aMsxP8d6o5+9FMgGN3urMC
 LyYdGvdQuInC8xVpQHl5Y0dsPMX6W4ZFrnP0h4YyoiKjYcrW1M9kD4mNNeYlHg99zlX1dH3GAl
 a38=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="151798029"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:20 +0800
IronPort-SDR: 9lxdoq48WCiIsLjX49uzcld+Ze0ktSlgSo6u9zcRJEpc2T5NFrGycIhZ7MEliUGpcJyToGlgin
 1b7oi0l8791mLNY7dz4J+kx6yIqCGHB+NkiQK6ZtpCt4uPv+yCY7m/phYmc2cUqbrV5Aci5f2R
 +cLt5urIeQ5aaG5B7dE/4RTtvHD6Uz62xjEs40vDVYZpJfr/ZfGAeegZuKaVSfifgG+eAuj1s+
 AA0POy8pxiMorgf6LsaLvlEGe2v/zvRXKXqkBsikeNGiONCeKieF+gmLAsCHJVn2A4GaLIYnC7
 xn0BW9UuFsj4Tl5mHJXBgCkd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 17:49:45 -0700
IronPort-SDR: tFvkaRu8x1mKxkoX4SXoM8AXOzEb5BaJcg/3a7oijkA4ynzu0K8QAYWv9/9B8jD9j6JyAI16os
 5DET0GzAGIAi3VE0NUF7KXw+PU88vagDlKzHGDoSrhCfQBAjVaiUAbRn/1GrQ/nOJnAV03moUx
 GMNuOooj9wuAxW+/XY97o7hBbdOWlkqAOLQJ2I2xEo1a9IQ6YEsVuIXSqf/ae4Cl9IW4RsUk1L
 PZSBP/SmWghO6lWVjfnIl1zo9m5092tlltDKqD32GzQIHLfNDCXDt/CPhYRYHCI6PR3bshdKYc
 USM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:21 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 5/6] nvmet: use minimized version of blk_rq_append_bio
Date: Wed, 21 Oct 2020 18:02:33 -0700
Message-Id: <20201022010234.8304-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_210321_914827_C326D54B 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function blk_rq_append_bio() is a genereric API written for all
types driver (having bounce buffers) and different context (where
request is already having a bio i.e. rq->bio != NULL).

It does mainly three things: calculating the segments, bounce queue and
if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
case.

The NVMe PCIe and fabrics transports currently does not use queue
bounce mechanism. In order to find this for each request processing
in the passthru blk_rq_append_bio() does extra work in the fast path
for each request.

When I ran I/Os with different block sizes on the passthru controller
I found that we can reuse the req->sg_cnt instead of iterating over the
bvecs to find out nr_segs in blk_rq_append_bio(). This calculation in
blk_rq_append_bio() is a duplication of work given that we have the
value in req->sg_cnt. (correct me here if I'm wrong).

With NVMe passthru request based driver we allocate fresh request each
time, so every call to blk_rq_append_bio() rq->bio will be NULL i.e.
we don't really need the second condition in the blk_rq_append_bio()
and the resulting error condition in the caller of blk_rq_append_bio().

So for NVMeOF passthru driver recalculating the segments, bounce check
and ll_back_merge code is not needed such that we can get away with the
minimal version of the blk_rq_append_bio() which removes the error check
in the fast path along with extra variable in nvmet_passthru_map_sg().

This patch updates the nvmet_passthru_map_sg() such that it does only
appending the bio to the request in the context of the NVMeOF Passthru
driver. Following are perf numbers :-

With current implementation (blk_rq_append_bio()) :-
----------------------------------------------------
+    5.80%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.88%     0.00%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.86%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.17%     0.00%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd

With this patch using blk_rq_bio_prep() :-
----------------------------------------------------
+    3.14%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    3.26%     0.01%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.37%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.18%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.84%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.87%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index e5b5657bcce2..496ffedb77dc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -183,7 +183,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
 	struct bio *bio;
-	int i, ret;
+	int i;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 	bio->bi_end_io = bio_put;
@@ -198,11 +198,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 		sg_cnt--;
 	}
 
-	ret = blk_rq_append_bio(rq, &bio);
-	if (unlikely(ret)) {
-		bio_put(bio);
-		return ret;
-	}
+	blk_rq_bio_prep(rq, bio, req->sg_cnt);
 
 	return 0;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
