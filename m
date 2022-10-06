Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6742C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=XWVHVdL1AFJksqVsKepY0Oyohaq4rUBE1eooB31xhPg=; b=o7wJY3eZ5XcbvgKMBl44P+7EEn
	aDXi3aj6tYqD/pRSRA+NA1f9hv840TPCPCiB35WjSjLPlOF2gFIRnetSHqeszpPvnqj5FTrjqpxp4
	JNIiCo8MqBaETimO9CPb/vJqWW7O5meg1BCq/b/cpJYz7o+2oPW9BLQkFo9RpFHO9L3FxhaiDNlZF
	k9aI+KmZ3FKRzkdT9I8szFznA31cbXgAnwTNpiDEmjKdqG3yU9AbJCvpq/21ZS5836GyWXvBHdAYW
	17NKt+Qpzprk14vrmzwA4qHYHsjWiwFV9i1OjRqjzWd/O144fllv4f92hYHFTYTipRMGVF/sIyvrG
	BtAwNkmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogMuP-000zW2-NT; Thu, 06 Oct 2022 09:11:13 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogMuI-000zOt-TB
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 09:11:09 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221006091056euoutp01a532b235eedb4806ec5b1b3943869851~bb9b5wvLM0951309513euoutp01L
	for <linux-nvme@lists.infradead.org>; Thu,  6 Oct 2022 09:10:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221006091056euoutp01a532b235eedb4806ec5b1b3943869851~bb9b5wvLM0951309513euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1665047456;
	bh=XWVHVdL1AFJksqVsKepY0Oyohaq4rUBE1eooB31xhPg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MsMRnvMsYXm9zF4kIl1Y5R9OxFrskbDkNfMF4DCVDZ1z3+zaMDfUZQvszqBY2+Tvf
	 zIn14IYKQecF1h/FyNn6cp89YiI4oGxF6MLNDejBKQ2FkUrgbtw8QdVYCZwYjsz8hQ
	 LjouuKaKdLrWd0hxfKkJaA/RIUrEkYWMsA4szPPU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221006091055eucas1p1bd9926a5994ef6db2c79494326990423~bb9azg_Pt0348503485eucas1p1B;
	Thu,  6 Oct 2022 09:10:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.7B.29727.E9B9E336; Thu,  6
	Oct 2022 10:10:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92~bb9aWE94x1404414044eucas1p1E;
	Thu,  6 Oct 2022 09:10:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221006091054eusmtrp28cbb51cd0b665f9bc60b526aa2366669~bb9aVYSGL2965729657eusmtrp2h;
	Thu,  6 Oct 2022 09:10:54 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-7b-633e9b9eebd5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.C3.07473.E9B9E336; Thu,  6
	Oct 2022 10:10:54 +0100 (BST)
Received: from localhost (unknown [106.210.248.47]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221006091054eusmtip2358fe6e276cbb94e1519f8cc497ae118~bb9Z-_AcQ0742607426eusmtip2X;
	Thu,  6 Oct 2022 09:10:54 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: hch@lst.de
Cc: gost.dev@samsung.com, linux-nvme@lists.infradead.org, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH] nvme: ignore starting sector while error logging for
 passthrough requests
Date: Thu,  6 Oct 2022 11:10:53 +0200
Message-Id: <20221006091053.36611-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87rzZ9slGyzqYLK4eWAnk8XK1UeZ
	LOYve8pu8XlpC7sDi8fmJfUeu282sHn0bVnFGMAcxWWTkpqTWZZapG+XwJVx7dtV5oJFPBWb
	Lm1jbmD8xdnFyMkhIWAi0X1xO2sXIxeHkMAKRokNnT/YQBJCAl8YJX4/C4BIfGaUeDxhLTNM
	x+ZT3ewQieWMEuv+34Jqf8Eo0fp+K1MXIwcHm4CWRGMnO4gpIsAncetWKkgvs0CCxK9z/awg
	trBAjMSbRVNYQGwWAVWJ5h8r2EFsXgFLiWd/mlggdslLzLz0HSouKHFy5hMWiDnyEs1bZzOD
	rJUQ+MkO9MIkqONcJJ6+mAbVLCzx6vgWdghbRuL/zvlMEHa1xNMbv6GaWxgl+neuZwM5VELA
	WqLvTA6IySygKbF+lz5EuaPEskMtjBAVfBI33gpCnMAnMWnbdGaIMK9ER5sQRLWSxM6fT6CW
	SkhcbpoDdYyHxKGrG5kgQRsrMXnNdfYJjAqzkDw2C8ljsxBuWMDIvIpRPLW0ODc9tdgwL7Vc
	rzgxt7g0L10vOT93EyMwZZz+d/zTDsa5rz7qHWJk4mA8xCjBwawkwts12zZZiDclsbIqtSg/
	vqg0J7X4EKM0B4uSOC/bDK1kIYH0xJLU7NTUgtQimCwTB6dUA5N98HfpYF+n6Pk3LSv/cu32
	NFzh/sI7ILvQzPzD2QtfKhUmGpr+C9jNtaLc+rpD5FIPWbuSmKLPT24y2TKbS/+bFCe1yrnL
	hseX5eWtlOutxd9z+L0tJ7x7yRJyfmr6NaYSJZYGj9Nvv378dGtHOWP1/K13YywmR290kdV+
	Y3fT/34wk9MLBl3LYxbWzIwPJhjt2G35iunj3s5pPjpy142W3442VY1+0+96WkzOoYJNtOnB
	qWWXZdp/aLEUrdNJ7i6LyGvKYS/5/HG9DevS12v1kns7iqbmvlb9ZXeqIHyOosGt++Fx7epO
	nLfenXjQ5WxWFS2wL4ef/Ud+/ewjDH1Xm+eXL+f8JZZ43fihEktxRqKhFnNRcSIAo66m04gD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t/xe7rzZtslG2z/pWhx88BOJouVq48y
	Wcxf9pTd4vPSFnYHFo/NS+o9dt9sYPPo27KKMYA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
	yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j2rerzAWLeCo2XdrG3MD4i7OLkZNDQsBEYvOp
	bvYuRi4OIYGljBL7tzQzQiQkJG4vbIKyhSX+XOtigyh6xihxbdEZli5GDg42AS2Jxk52EFNE
	gE/i1q1UEJNZIEni6l19kE5hgSiJ7Ru+MIHYLAKqEs0/VrCD2LwClhLP/jSxQEyXl5h56TtU
	XFDi5MwnYHFmoHjz1tnMExj5ZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw
	WLcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4e2abZssxJuSWFmVWpQfX1Sak1p8iNEU6L6JzFKi
	yfnAeMkriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamAS/2YeqWpx
	X7rB4britPebZl0KuVj/9OGlJ2nOd9a8/HE/cKPwE38FVnG2j5e4+m3+ex90/P1bZHFqjvO3
	VcUdBiXHJpc371PMWTpx9ZeWRcVPD76qXbZv+b+ep6e10pKz13qqHqp6oPt+5c7Neq6a+Q+f
	LfjW+SWXY/cLYcv+5SeZnnGbnw2buL5MZU+kg6PwHusLnsVv/a3/Rq7l78h9V3VIyNowcX+S
	b0/TTq5O8VWRUR7xL+f3Tezdm9G7wvtWs929hz77Gkv0ov48dfvT3bo3/u6P4k1NZ/dJllT8
	UHrDZC7Fx+D0ulr4r+aVsmpJA4+cU91/rgvtuil4v9HXNt1F7dau4zs3dcdmfe9VYinOSDTU
	Yi4qTgQAzL20S98CAAA=
X-CMS-MailID: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
References: <CGME20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_021107_368753_88F728DE 
X-CRM114-Status: GOOD (  12.18  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Error log will print a garbage value as the starting LBA for passthrough
requests and requests with uninitialized starting sector that return an
error. Print LBA as 0 instead for these requests. This behaviour is
similar what tracing does for these type of requests.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c1..41e0a257f1c2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -305,6 +305,13 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
+static inline u64 nvme_log_error_rq_lba(struct nvme_ns *ns, struct request *rq)
+{
+	if (blk_rq_is_passthrough(rq) || blk_rq_pos(rq) == (sector_t)-1)
+		return 0;
+	return nvme_sect_to_lba(ns, blk_rq_pos(rq));
+}
+
 static void nvme_log_error(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -315,7 +322,7 @@ static void nvme_log_error(struct request *req)
 		       ns->disk ? ns->disk->disk_name : "?",
 		       nvme_get_opcode_str(nr->cmd->common.opcode),
 		       nr->cmd->common.opcode,
-		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
+		       (unsigned long long)nvme_log_error_rq_lba(ns, req),
 		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
 		       nvme_get_error_status_str(nr->status),
 		       nr->status >> 8 & 7,	/* Status Code Type */
-- 
2.25.1


