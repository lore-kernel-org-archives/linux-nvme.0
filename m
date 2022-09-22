Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE91C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=; b=tqvJd5X/ecZTMOYVAZaaObnSR2
	glnL4nFbpkj9rzOs4cOkj3IKcHneNZ3ad20JLwJtvK7YugnyMHBiPhqaMsFha1K2mr2WWrTTCfI7y
	qblLJfaXJB10vqRYq/Mm4XE/clqBfhkblXHUV6DzQlQ1mKnVPNrCHzPi61D7p0gOgQr3v59vE0nrZ
	7VjmUFpSXfxmDKihFpHcVhE3RIOvEFfF8Altr1NvEwm0N+JtvbIcs0V/BYe3MovPGr2MH2VrEeUCj
	xL6ZuPZxGkVAvk6EOmik91Rx+1ISkjapwhW1cPfSitwVXGcbxkek17SwAJlFQDmyI8puAhv5afOvW
	01HPrH7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvq-00HLD3-46; Thu, 22 Sep 2022 18:28:18 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvi-00HL7Q-72
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:28:12 +0000
Received: by mail-io1-xd31.google.com with SMTP id d8so8436357iof.11
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=I3ozfRpCO+8sfk1czHqJkuud5fbhOBBjBPNani3SoWO5IZrr+n/xykd4BYCj6iF/yZ
         YUgMhkihNpdD90pGDqffGeTVe1Lb9NSQnHeRoD8cgg2gFQ/EmHGBP46WBRkepSKacBe9
         0/BDSuaDvLg45rQ8CzKBSAt8/NtYunQdrfrc0/qYd/SHmQXOTUhVkzxgGGcPxLM8Q6yG
         Pnxpp3iPWxoszKqZD6piQndRMfFxGNQXSl6LEm2shcEG/V1F+VDWoYsayPrD5S/hJS3w
         /DgQMp06IIBo+G6qQyJy0W2qJ9hcQXFC9VwcVse6SFsPWkJYASV0uNPVG/clm0ofomyV
         cjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=jjTABJxDYHkcyv2IMu1BXDSJyq0eOyNfuQzd+EgKZoEWEBGQiUG7knV2ASjbTYXZMw
         zGmvRdofFJGmVxHKa3zyfqWAOVojH/VvjhwCreFBBf8P1MmTgWxB06jRWxaLhIhTDexN
         dd0ggpO2rcNIX9ZbFGyEfWvyXmFarCGA928kUls3BaAocxMMybotCEcIkaSDR6mVqmon
         +/xccgCSXGd5ToWAN9c3ISWcKKp6w6tFCkxn17P+L7GEflZXejukBuR85fZVmBQy9Z+S
         LVKdRRfujZNxQzIPz0dtacWLeKR565wLf2PblmMHXN2R+vj1CHk+0JQaruFhD1CsAepu
         FKtw==
X-Gm-Message-State: ACrzQf2Ljg8fRkflwRDkuXF8A2Vmpj51wvnttYA8mYipRUDkDlExRRKV
	k3lYXFsGiyuVzA0PjLBH3wDH3FSJ6YIHgA==
X-Google-Smtp-Source: AMsMyM6q1U2zUDZ6fq1ZHALNlDos6d1f2IhUDrAzg+XF/fY3dxFEtLxvEozxHX6pNVp/47zfuhfqkg==
X-Received: by 2002:a05:6602:2d09:b0:688:f387:aab5 with SMTP id c9-20020a0566022d0900b00688f387aab5mr2274193iow.107.1663871288335;
        Thu, 22 Sep 2022 11:28:08 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: enable batched allocation for blk_mq_alloc_request()
Date: Thu, 22 Sep 2022 12:28:01 -0600
Message-Id: <20220922182805.96173-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_112810_473323_AD601172 
X-CRM114-Status: GOOD (  15.49  )
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

The filesystem IO path can take advantage of allocating batches of
requests, if the underlying submitter tells the block layer about it
through the blk_plug. For passthrough IO, the exported API is the
blk_mq_alloc_request() helper, and that one does not allow for
request caching.

Wire up request caching for blk_mq_alloc_request(), which is generally
done without having a bio available upfront.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..d3a9f8b9c7ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -510,25 +510,87 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 					alloc_time_ns);
 }
 
-struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
-		blk_mq_req_flags_t flags)
+static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
+					    struct blk_plug *plug,
+					    blk_opf_t opf,
+					    blk_mq_req_flags_t flags)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= opf,
-		.nr_tags	= 1,
+		.nr_tags	= plug->nr_ios,
+		.cached_rq	= &plug->cached_rq,
 	};
 	struct request *rq;
-	int ret;
 
-	ret = blk_queue_enter(q, flags);
-	if (ret)
-		return ERR_PTR(ret);
+	if (blk_queue_enter(q, flags))
+		return NULL;
+
+	plug->nr_ios = 1;
 
 	rq = __blk_mq_alloc_requests(&data);
-	if (!rq)
-		goto out_queue_exit;
+	if (unlikely(!rq))
+		blk_queue_exit(q);
+	return rq;
+}
+
+static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
+						   blk_opf_t opf,
+						   blk_mq_req_flags_t flags)
+{
+	struct blk_plug *plug = current->plug;
+	struct request *rq;
+
+	if (!plug)
+		return NULL;
+	if (rq_list_empty(plug->cached_rq)) {
+		if (plug->nr_ios == 1)
+			return NULL;
+		rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
+		if (rq)
+			goto got_it;
+		return NULL;
+	}
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
+
+	if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
+		return NULL;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
+		return NULL;
+
+	plug->cached_rq = rq_list_next(rq);
+got_it:
+	rq->cmd_flags = opf;
+	INIT_LIST_HEAD(&rq->queuelist);
+	return rq;
+}
+
+struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
+		blk_mq_req_flags_t flags)
+{
+	struct request *rq;
+
+	rq = blk_mq_alloc_cached_request(q, opf, flags);
+	if (!rq) {
+		struct blk_mq_alloc_data data = {
+			.q		= q,
+			.flags		= flags,
+			.cmd_flags	= opf,
+			.nr_tags	= 1,
+		};
+		int ret;
+
+		ret = blk_queue_enter(q, flags);
+		if (ret)
+			return ERR_PTR(ret);
+
+		rq = __blk_mq_alloc_requests(&data);
+		if (!rq)
+			goto out_queue_exit;
+	}
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
-- 
2.35.1


