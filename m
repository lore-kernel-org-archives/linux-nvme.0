Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C0BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287CC20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2PAPmpn3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DGTZiLK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287CC20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a1E53P43kIHEpXF8GFRSg9rTY0zaATxiiVkYUlkywZA=; b=2PAPmpn30SvmM1uQl0a37Jz+s
	rD5yyGH+3a5S1YJCXwAJCePYz3KRHcP4RUQVYN46MPboE6WtcAk9GYwQEpmUTjfrYeiWAefIvQJkJ
	AkYy0jCM05GyZZq2Sd8pTsscQc86dRVCx0BSzN1y14TPGMiizFDo8n09UB+8Ja88z85T3vRJ9R/6B
	/3UzvxL7ZdFzIQQvwbGQjQvcXH4RnvvELZs9YJQO7GAZXgZZWvNGcHZLYgsw5mafacMjFcsRfV5wa
	6AZqxvJm8hMH+zmSk6D1FM/1iAX1DzAOPOBJ2+OndLAqJY6bdiwVTDdcpzvaVjiCk+Bq7QT0nXatM
	TOF7zNy8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cxz-0007HR-Ln; Mon, 10 Aug 2020 18:56:15 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cxv-0007FK-L6
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085771; x=1628621771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nv/VBPGalpNHmlL+5ib7YOFtNavHink+zV/6RUO8Sw0=;
 b=DGTZiLK3dMAnpiJm8y/3dksnwHtIw6KK9e8a92Hj2dLIp5djRZpnGkwQ
 k/2g0azz7+09cCSm3puKWqZemLoEovjsxMzcjd76t5OTtXI4TyzbPXHBz
 vR91mpQdtat2IEkfTPmB/Gx1Q/z2WsNKGZg9Z6UHOTcYM5JokHtcXeeTB
 zvo8LWxveOl+/lBYXmuRjx9jDTSFojlq/JXy31r+yfSjl4XHvAzSwY11M
 fEcWFYNcGCa5ExFXVl6Xrn7Woc+NTUpbjJOyccbnJfp9i2e4h+ef4WbK3
 ZNdA8O+cRVd/989G6Dnb9qKMQupc/6YWief3ol6myKRTNo/FPnDs1EloZ Q==;
IronPort-SDR: Vq7Ouzu6OaLDQAAEeFXuRiwzXgK2fcHE4luN9nyPYl0ZtbYcGPdGhZhHqMvmIVRFVWGpLizl43
 6xgJP3KLiKAtuuqeySP17A8FcxfAF+cXIeS4FwLlIRi2wOynpFnhD50z5gGPaUp4TyJ4FICK99
 oT1OuuFf0TUtFYExG38jqq4sd9GYdmm5Bglf4ARUtAu1yt1RHm2ItRVEzBTTQVRSRgkuaoajKs
 yGE3yaxC8ttyjVQoLLNDYWmX2iVQxJj2c3AsKTQCirw2Hld21XqYo06PzFz6mGHtNEdzoYuugz
 KtY=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="253987910"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:10 +0800
IronPort-SDR: l189qxJKAW67lEXNjrEppUZImU0jEH4bfUyKw/hBKrJ39Z73DmRTXhcOGjxUnmZNA5YMMzwJex
 3KTA2bqp5klw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:44:04 -0700
IronPort-SDR: 9Hkw213zshnfyaQmPDuL9DevP5LlGyFT+dJyqgNMNVSoBGyefNneTF2VqyZVFUGxnvKV/rDqG4
 AxYK9a9U3nrQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:11 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 09/14] nvmet: based on passthru req control use REQ_FUA
Date: Mon, 10 Aug 2020 11:54:51 -0700
Message-Id: <20200810185456.7713-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145611_897716_2D9ECD22 
X-CRM114-Status: GOOD (  13.31  )
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

The write request for passthru driver currently does not consider
nvme control field which could be set in the nvme_rw_command from host
side.

Update op_flags with REQ_FUA when control field flag is set to
NVME_RW_FUA.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 5f06f4290c52..a703f3f14b35 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -207,11 +207,15 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	struct bio *bio;
 	int i, ret;
 
-	if (nvme_is_write(req->cmd))
+	if (nvme_is_write(req->cmd)) {
 		op_flags = REQ_SYNC | REQ_IDLE;
-	else if (unlikely(nvmet_write_cmd_group(req->cmd->common.opcode)))
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			op_flags |= REQ_FUA;
+	} else if (unlikely(nvmet_write_cmd_group(req->cmd->common.opcode))) {
 		op_flags = REQ_SYNC;
-	else if (unlikely(req->cmd->common.opcode == nvme_cmd_flush))
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			op_flags |= REQ_FUA;
+	} else if (unlikely(req->cmd->common.opcode == nvme_cmd_flush))
 		op_flags = REQ_FUA;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
