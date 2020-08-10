Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D0C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA5C20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rLiUNrVn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b40T34qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA5C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HztJCOfDQP5biotOJvRdnzvQ0f0aGP9oYuSbFEzW/T0=; b=rLiUNrVnsKuzvj5cnRu7hq1/9
	I4GVAo6gbeidQb53qtPg8eyR/uegZspF26DG0VAIDZKIHVgmAsgJDh55Ky2ZfFaljFpz5oowNDa4I
	vwPq1CyucIjGU7VdagN1zLkmRI0Wy9VURmoBrvA3q6BBQgq48a4dU4/4gywWNkTMAHGNvO6M6SEHz
	abIrt5NV1p0w5P867dyoJ8739CYp+qvQIsD2cu6i33tCmlqJaslDm2bQ+k3mncz+CmU+xnlTCZDRE
	0HO5tmLmKL4+eZi//byotbERdVMc8Jm62gZDpz0xG0pV10uIzOsHHJAHcxfLOYuj/wtDE2tx/FRZ/
	08SROiXfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cyc-0007ce-7G; Mon, 10 Aug 2020 18:56:54 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5CyR-0007W3-3r
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085803; x=1628621803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/0/WHb/RBbcetA1xzE6eM178t0n/0/3kuFlF69yMdak=;
 b=b40T34qbPyokJ0g68qcsJ1BT+jb6vZIbCCtLTE30YVanHCn8tfJGg7zA
 RR527M2ZylsU0GaEUBpgkA9RKoSL0KIewYqDiu/28fzPep+x8qDfY16i/
 /IslA9fNGGe8GWtpTX21elewibzVy5Rl6hn5mHM0bbtEh6FqbwPWWZAmu
 LOMp7p7AM66mgwujAIIilZRQ9/4ffHFJ4yQbjg5XomVHI1NDODH9F1fpa
 Rv7pQHZ2/TU0MsCcLbcxlRu9hYIZV/08ksSaNFnUFG9C0Srf4bGOKQ40f
 JLQzKsxT8kCGO3wb025phT8DCnF3OQwsipDDhqAiMQHUidZhbaYoHKM39 Q==;
IronPort-SDR: 3y5S/9j5pNUE0GMwiP04JI8O9CzhqVCKRJMykl7q0l+WaRtcKpKo74dkDSdh6rIV7Ohcm4H6X+
 9ZJIl1lzsB/+qPROu+2c9OJSpErDOrmhqaYJQXdjGee7WBRDj+6ou1/OD3GhP2kiGXOFRUlrZl
 b8vCM6nRarLQ4RPwvKu9DiGA6fSXowwXHF3OzsL7oNM+Rzy8X7gxGLJrcSdsvQFE8hgLWuRuR8
 H97pT6sbpPMNlHqxUk4fN8XyCUrezI1APsIzNc+ebezRU/NcMQoesfdG8leLdghOxGojpR/I8S
 REA=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="253987946"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:41 +0800
IronPort-SDR: AI3GIf7um/EJcoMrhOBZ3uCZR/s5Nu1FGxkw2fLSo4qsiBWS3FYph30cnXjtEerKIrx8gFXFh7
 GMcCa4vlFxjw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:52 -0700
IronPort-SDR: +ucADYBvrOUUECCTamn6mp9VJSbrCFm+gij8SM87MEH7npPqR7CfNJfx9aNCgLf2zfkbQ68LNJ
 kOdHunUIZ1TQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 13/14] nvmet: use minimized version of blk_rq_append_bio
Date: Mon, 10 Aug 2020 11:54:55 -0700
Message-Id: <20200810185456.7713-14-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145643_384128_7FB3A008 
X-CRM114-Status: GOOD (  19.43  )
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

The function blk_rq_append_bio() is a genereric API written for all
types driver (having bounce buffers) and different context (where
request is already having a bio i.e. rq->bio != NULL).

It does mainly three things: calculating the segments, bounce queue and
if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
case.

The NVMe PCIe driver does not use the queue bounce mechanism. In order
to find this out for each request processing in the passthru
blk_rq_append_bio() does extra work in the fast path for each request.

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
and ll_back_merge_code is not needed such that we can get away with the
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

With this patch :-
----------------------------------------------------
+    3.14%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    3.26%     0.01%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.37%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.18%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.84%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.87%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 5925e93c4682..a7ccc817ac2d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -9,6 +9,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/blk-mq.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -205,7 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
 	struct bio *bio;
-	int i, ret;
+	int i;
 
 	if (nvme_is_write(req->cmd)) {
 		op_flags = REQ_SYNC | REQ_IDLE;
@@ -231,11 +232,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
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
