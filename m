Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553FAC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0732D207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HT8ideUJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IZkxI6wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0732D207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3d5HuSUNMZmVwndwI57GN3BsjsOktzMUmxaJcXKrgJI=; b=HT8ideUJjonWK4PEZFMNOcEkj
	IfPdqdb67GOr25MDwP5m8f+8QsaFoP/2tEKlVqX2vO7uLv1Wm5Lf2VoCrQgUbwx9i1ymUZVfRLMYC
	DutHHnbyIlz8Wm6v1w+qZK9RMtFdv8MIFgrYACZwOHeB5JAa8sOx2KXoZt5i4fSnl37xCOmZsnIpx
	bQk1YVuGPuqQncoV1OIEH6p3q+09oBajvNgrtXHaF+hlGBXa7YsfRgoOu+r44owSa+CAtncsrWyfO
	uUFJPC3vnzD5ZhBFk+gebJkOQ9MCi4xWrlKe4JyZ7+O2WuFIi2bIHGH3TU+cXhMxxl84jA7aWVagf
	R72bpfyhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsHn-0005tQ-SA; Mon, 31 Aug 2020 22:28:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsHP-0005Vg-Fw
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:28:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912879; x=1630448879;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zST195QueShp4zI3xwF1FjpzG0HAcdGZUIFdXdb6mXI=;
 b=IZkxI6wyxeWbYAil2s+GMCT6oIBscqQKyCBZTI8i80jLDquSmDhbtegi
 OYV+qutA15ba2RRBSsUIkRKVnW+vFPHE0zLhVSt8fI1ErnKAQRy7ixBLy
 W148z4RGRJVHQ6JqWtq0VTVB+rUUKNkPE+QpTZDfVy0BG3Pg3cfQ7yJ09
 qxd415BXZTmMAgbEMRF1GMzB1J6J2ZRWy2TVFV5phJ2kxS3CBneaZImbd
 7EydDgHRH3lSlKACjnW/u0WPzG4N0o3wZd/8Cwc5m8/C/vQS7a98a1cK7
 8HgI2ChHyr4OcoCb5bpEOLEO4XCy6BkQURP0On7dqRSOty8GuReYDdYD8 w==;
IronPort-SDR: 8dq+iFDs+9pUvAKSlDO2ybh2k/ZVJzp4QEXB2vg7FnB2cUShinTkt1o+kJICjAt5EN13Qbktgf
 APTMOnOtEuhXvCfDH4Uwla0oYnNoWvh3f3Q/UJV5L3fsksufIhPF9X/iBeG1t8By/iBTxujeSZ
 QDFJaXstoEdigI2GcbMoEL2SwUgWv0pIWjdziHvpRC0BmIobKXnzEuWzIK4cp5RkwwmKbwJbUd
 X7zfl6UsSohgdP/Cn/yZyUMq4kVOJEDOr6WIkY9sk0TVL05EccTOMXCPb9Kpi3c0k+05AEekeI
 Mv8=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482879"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:59 +0800
IronPort-SDR: i9eEi0seD1gLf9B2Nwnfg2YVNGKfr7o6257ivx+2+BA0YuFbEic+ojg+AyAfToZ7h3Sd+z8bhP
 kUeguZlUrUCw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:27 -0700
IronPort-SDR: ldzGG215w5FJCTHjwgK0JpQpV4mf0QQYa243ZXyT2xymR1L01XFbDPjOCKRpAouP6WHC5Sb/C/
 i8UJcuvuoSLg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:59 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 11/12] nvmet: use minimized version of blk_rq_append_bio
Date: Mon, 31 Aug 2020 15:27:06 -0700
Message-Id: <20200831222707.35611-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182759_754512_167D652D 
X-CRM114-Status: GOOD (  21.04  )
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

With this patch :-
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
 drivers/nvme/target/passthru.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 20944c48095c..89d848006bd5 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -9,6 +9,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/blk-mq.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -184,7 +185,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
 	struct bio *bio;
-	int i, ret;
+	int i;
 
 	if (req->cmd->common.opcode == nvme_cmd_flush)
 		op_flags = REQ_FUA;
@@ -202,11 +203,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
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
