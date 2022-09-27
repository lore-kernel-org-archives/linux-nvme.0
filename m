Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860C8C32771
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nz/B6jdwrrOsf5JLn/R8YVwnmVtMrvsX8isrBntB0gc=; b=H9LUxoXTB2/xOVx0qAZkKCAgPQ
	0clCruUTnH4272gqFjZJzkjUdePf5jViMrZYc20eziny/TYST0k7+NK1ys0b/i/krc6pOc44Z/Mmy
	xAMADinK6v4R3oX3qL1HxFcLZ3OfR82vjhlHbzCjICdpmM1rWkaQEqw3gvlD8I1MhVtdTLVQVghrg
	3GlXIHupjYl6wxabexWKhwx6NUS5L3s6pXu6a0foawPi5NU/r0MOj6sAHttWcyIkaHdKB094ppEMQ
	SKbbsEmG0RjLy8vuNBnsBP4Gu4ze4RQSGPv8jE+jmu8OZrTtilRZSQ5GDC7k8DCrBXeOG2D9LUZEk
	67rsBONg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oczeK-007h3y-RP; Tue, 27 Sep 2022 01:44:40 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocze7-007gyD-0K
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 01:44:28 +0000
Received: by mail-pj1-x102f.google.com with SMTP id x15-20020a17090a294f00b00205d6bb3815so552755pjf.4
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Nz/B6jdwrrOsf5JLn/R8YVwnmVtMrvsX8isrBntB0gc=;
        b=YT5XveMQNm31+MTJZ+0kPwthf1yXMJQ1wFLUuRB4zypjMZ05Qqnq+P+1friBnnl77p
         KK60FLMIHFVWxiWnFKEELBnnjeeaaHf2qbOuV4Qdfa94HJQGydL7bQ/t4I7UNG8HESrS
         iAkRfMZxl9iupPkubKeTmJd1BkFZajiZTLcUWR8mfMrNJQaLSs7sHmpmHNyj3ZM5FDfO
         +M7oADYj71hjFcKq22AZjw+9JA7DV3xtA2/NNc6EY0fj+yG6OixAA0LQw+9E/MMmTcCI
         22ybrhzADauGcmi87SYE8KgOzPoTihQPwmT9QcpNB4uP/SN6h/yUDZtBk9GUkauHG5LD
         0ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Nz/B6jdwrrOsf5JLn/R8YVwnmVtMrvsX8isrBntB0gc=;
        b=6Y7LnT2FxibBW4TNjpsLyxM7ZhoVALCMipjbAn+/efJYyAscuvxQeMhCcY+gleDAaW
         AAeJmavivAhqMcP4awhLaseN4Ub18Fv02YRPmW3SsibgKhNE62FyRUem7m4Wbqtvdhev
         RYYgUvLXWpTFw8WvJytSto9g85X+sjlFUv1Nwa5vdhHU77gUdK0k03TzI4QhyaMZsD6+
         T+oWszuHDeQCdNO2hwqsymiCJ6qtbvbATl3UpxOMx5cKzqb1ToDduJ/mStmFcs/qhIPk
         1FN6J2J7m7pbAy9oyUgt1JwI6UUZqW9YY64cfchgS162XFXIwFeAZxt/bTJ3IjIS9So2
         3Exg==
X-Gm-Message-State: ACrzQf2xdmyhRfs+LZY5HcwXAP8mtrT8GEjoT830onHLZpjKM9UrllBJ
	410QbPmIKv151YRiMSFWnCcAqg==
X-Google-Smtp-Source: AMsMyM4ePwz2HRsSpw7tWuMO8WEprrgKRsdcXCPFgXwQUx9CiC45lyoJblyFaY69/biPTWfpxqiSog==
X-Received: by 2002:a17:902:ce81:b0:178:8e0a:5615 with SMTP id f1-20020a170902ce8100b001788e0a5615mr25192700plg.109.1664243065770;
        Mon, 26 Sep 2022 18:44:25 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Roesch <shr@fb.com>
Subject: [PATCH 3/5] block: allow end_io based requests in the completion batch handling
Date: Mon, 26 Sep 2022 19:44:18 -0600
Message-Id: <20220927014420.71141-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_184427_206015_022F1F57 
X-CRM114-Status: GOOD (  14.36  )
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

With end_io handlers now being able to potentially pass ownership of
the request upon completion, we can allow requests with end_io handlers
in the batch completion handling.

Co-developed-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 13 +++++++++++--
 include/linux/blk-mq.h |  3 ++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4e018c82b7c..a7dfe7a898a4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -823,8 +823,10 @@ static void blk_complete_request(struct request *req)
 	 * can find how many bytes remain in the request
 	 * later.
 	 */
-	req->bio = NULL;
-	req->__data_len = 0;
+	if (!req->end_io) {
+		req->bio = NULL;
+		req->__data_len = 0;
+	}
 }
 
 /**
@@ -1055,6 +1057,13 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 
 		rq_qos_done(rq->q, rq);
 
+		/*
+		 * If end_io handler returns NONE, then it still has
+		 * ownership of the request.
+		 */
+		if (rq->end_io && rq->end_io(rq, 0) == RQ_END_IO_NONE)
+			continue;
+
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		if (!req_ref_put_and_test(rq))
 			continue;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e6fa49dd6196..50811d0fb143 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -853,8 +853,9 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       struct io_comp_batch *iob, int ioerror,
 				       void (*complete)(struct io_comp_batch *))
 {
-	if (!iob || (req->rq_flags & RQF_ELV) || req->end_io || ioerror)
+	if (!iob || (req->rq_flags & RQF_ELV) || ioerror)
 		return false;
+
 	if (!iob->complete)
 		iob->complete = complete;
 	else if (iob->complete != complete)
-- 
2.35.1


