Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D925AC07E9D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=; b=NzJjRquj1V+n3S9AV0DIFcXKIP
	cF2ayZ/Iiu33hHmgKE/mW1U3My0zcYdE9LK6A6XxRtaTbxC4rZvTB5H3rV8LYHI2ykMlNsuABPR8+
	FpYc612WOc7aCfYLzz3+WNcYYX+gWrrPbeUAMA5A9lzHI9OTVmC8buHR14/Pe7H5GtJ1tzAQ72dxJ
	YaxtK/vampvTwX5GhixBysqNx5kTPVnEZW87TaZeKbrPpaWMiNKle/QcOHN0ZuRfqs9r6lS7L9gjT
	RkNOhbOBL4mnujVEr8C/abZODf+URmIMsbIQwQ6CStGSZ+d6Jx0K9pQAGGd9pt/faNQtn4wVxxYMM
	zNTq80sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oczeC-007h0a-3u; Tue, 27 Sep 2022 01:44:32 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocze5-007gxR-0C
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 01:44:26 +0000
Received: by mail-pj1-x102a.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso8652638pjd.4
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=IZ47anjuWzzeW6tFN95y9yhaayVusdQv6KbEijleZbt5Iw+sz8JmacG50WtnEERZ+T
         ukyS5F4ahFzGOZK+L3qTcdJexGtnST2bu8ZaKa9WT/utuzrcw2o4cFJtsy8euWpKfEnx
         rvXyTqA4TZKRalJzpTIHilAYUmbH08J08UcL9DEgRm38E9mVgaInmLOetIV5qET5M320
         GfRVwa+ng63clk9+PkTDvTFIobCDuQXpIlTz2yxPbQHKwvG5PpO89F9AjtZ24/VgOIho
         tiyCKV7/xq7YI0KwHz3GIYPrUcj0KkG5fgwsHcUPzP5uFBbmQmk0DNOd+Hp8+2Av5AKp
         fvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KOdha0xZ2/QYkK5YkfhyDv4n+7NP1qIjesr4vuNTao8=;
        b=0D9JE7mKl969I4GVyDEft/h9TM1TlVD1KjM5ZwjAogCrcOzQ0cXwKbX1A7Hhj8L4Iw
         Jk6Vu32cq8Wqh1gNoUIMeLe8naI0dTunM4CJJQIlz6a2Vf2jOyz17N8S5HfTvcW/w2KM
         M5RKEa9Dh0KNSGNOWTNbk4E/mpOfzlXyC63wTBn89EFJKnnPQKl0aCMajWOEgLLassn9
         gE32TcCZ3WQoA4Ho7qxjuWGxyFJFOxa70R2eOLPrCHM9XnaXJRYbWoL54kDIETyckHDm
         RL8dTcPTVyX6KbHyzZDFaThi9qw4LeUPQzFnMmx8o58eiNvVjz2imd9uhKHU2lGc32Ih
         piAg==
X-Gm-Message-State: ACrzQf2mz7nHsB181h/sblC1GB/q7ffaza0Mly7XJyruFDxWVWYvoYq1
	7oYlHGVo3erowhOb0ukqh5Dk2Q==
X-Google-Smtp-Source: AMsMyM4q9iQ/NKVm6hjlVj+kedzuR0z7pDReUN/KpszmAjSVIxz1HZxq3fyW05GGm8DEzlY8kHoU6w==
X-Received: by 2002:a17:90b:180a:b0:202:ae1f:328a with SMTP id lw10-20020a17090b180a00b00202ae1f328amr1816502pjb.78.1664243063538;
        Mon, 26 Sep 2022 18:44:23 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: enable batched allocation for blk_mq_alloc_request()
Date: Mon, 26 Sep 2022 19:44:16 -0600
Message-Id: <20220927014420.71141-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_184425_058637_46F322F7 
X-CRM114-Status: GOOD (  15.80  )
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


