Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CBC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8021361166
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8021361166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rr3Ns/zJLJeUlF4RV6ZxuHPudvWaqf9Eo0W3XiR2+cg=; b=ZH3ufdx9hE1vUqo7FMC59xn1Yv
	0zq/jupve68pFcFub6vdHqHNAcQzPsUj2sDb3Afra7567zTPvLuS0TgipfIESj0JqzeZrB9tVJp9C
	/ugLwk8sVKSG/Dve+HCW2vwd2jHe7xnIXBGbO1NxLYaGwzhyn8CjE2lJiyW+XW5uTxQKURLFLXAwG
	QZwEKlTJ120tedOQdhGFq3OEKRyLjjpOT2s0XmzhSbp79EZfE025c081QjYfKWg3p8JTXy24JjHmX
	wrHdO9V7F+7jepWpZfXNhwc0pFNap2qX66/3EkAep9PcemFbOlnHVE+9W9EVuP3EzeglIUnOhH7ZW
	CkldnHeg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXYHv-003m7n-B1; Fri, 16 Apr 2021 23:54:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHL-003m4D-CL
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 23:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=a1nvUyKb7Km0hekKdxHGyN60tpfHzRrsEqFGAZI+ni4=; b=WfrUHippFtp0RuKKuL3XVz3uTh
 5SJV51Pesg0VTSc//mMYnqLu1kVkiD8bp97K/2w8QG5/FGZ/eDJGQQVx+myqjVWvvjBl1xmFZFf3h
 yIG3yZaRT/wxqa/J47sQwa5hIyznCy4U/fbxAk+sRP0+NE1NkgOIFC9UBNnN2m9z6piqbX2yFm8p+
 T7jUzOT6GlrwColg2SHrthzdpJIm7GQvKkPLcscKvR0H4NRxeHIsplOzrMxg3PC3hGCVEu5hd/mnZ
 OU6R/hwqcmA4Iydv4Kpzeol3kTNKo6mYhUCboOJ54gF+1NlLxJRf+Llk5eTjPvnff/KbHd3OQkuc+
 PfCU8ogw==;
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHG-009n0g-Je
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 23:53:38 +0000
Received: by mail-qt1-x832.google.com with SMTP id d6so3796687qtx.13
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a1nvUyKb7Km0hekKdxHGyN60tpfHzRrsEqFGAZI+ni4=;
 b=BdMJCnbct5KBJPP5KqyCcBSekxteAlGsUyEUCoGq/aas7H8lj1zNY/JEg1Dr1ksZ+f
 Tihi06XP8wDuWWI4N01bDBKOwW6/3yYFyIfyZwb3kCCZmtq3Y04pS/wgFVkLb+kpdlke
 KHtZ7wzFAHPhexb0v4g6UHVVyAallv45CkVa1a7BeT7iPBek05P/JGiwUxWyqUkJdDFf
 7pdnQbVFf9eRE546Tcw4okY6RSuEaQbDRcx+J9t75+DjKYZmS6Ea9a6RZXoqHxPC/dPC
 HQ95CTmz03mie15e/yUsmUkFLWqvQz7jkjlAF8szQudy4vVy/sL8gc3P5MQh4Jwi0C3d
 wtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=a1nvUyKb7Km0hekKdxHGyN60tpfHzRrsEqFGAZI+ni4=;
 b=ARXPsKP0ox69ACY7YWEdUmBjAQrufoyqB1noJyDz24Tc3gGBb/KfWXEzDNi2uP+LUO
 MIw8OYU58gnuJba+EDB4Ws4x00GwwQsFRQXp+7bqzMS50ULN7iDiG2mVCGXECp/2Oo2L
 as7JOjOCVcInNFCIZT5U9N9V0No1ug6rvtqaoV+Dd/xt00IQVqTEywOvtBbyjyaLNx0g
 DuUGKaCYEPVfCTz2PVVNLSf6SWLXRtU0dpLlc8Vt3ROTilzEOjqUr4/5xjkXKEDBeplY
 6wrtMr27bu1QK2UHQ7b7EcUle5dyRtBMsFpjFp/0qqERZ+6RKU+eh8OBOIVqQntqtuu/
 jyNQ==
X-Gm-Message-State: AOAM533FTn+uan4/yWFGl1ksQhCQmfsW1C8ssx9kPRgbRWqh2LGYBM/t
 TiVFZ5M4M1O276J5IRT1ImA=
X-Google-Smtp-Source: ABdhPJxYYCrNVTkBMHh7ujpabmWkrGvRS/5k9AOlVSsGCZug6eBYSy3tgv0ntn47DVL2D4MVf0kk9A==
X-Received: by 2002:ac8:6b46:: with SMTP id x6mr1598672qts.150.1618617213544; 
 Fri, 16 Apr 2021 16:53:33 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id a66sm1377452qkc.74.2021.04.16.16.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 16:53:33 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v4 2/3] nvme: allow local retry and proper failover for
 REQ_FAILFAST_TRANSPORT
Date: Fri, 16 Apr 2021 19:53:28 -0400
Message-Id: <20210416235329.49234-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_165334_666649_CAB31E44 
X-CRM114-Status: GOOD (  13.92  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

REQ_FAILFAST_TRANSPORT is set by upper layer software that handles
multipathing. Unlike SCSI, NVMe's error handling was specifically
designed to handle local retry for non-path errors. As such, allow
NVMe's local retry mechanism to be used for requests marked with
REQ_FAILFAST_TRANSPORT.

In this way, the mechanism of NVMe multipath or other multipath are
now equivalent. The mechanism is: non path related error will be
retried locally, path related error is handled by multipath.

Also, introduce FAILUP handling for REQ_FAILFAST_TRANSPORT. Update
NVMe to allow failover of requests marked with either REQ_NVME_MPATH
or REQ_FAILFAST_TRANSPORT. This allows such requests to be given a
disposition of either FAILOVER or FAILUP respectively.

nvme_complete_rq() is updated to call nvme_failup_req() if
nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
the request is completed with a retryable path error.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..a12b10a1383c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	FAILUP,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -306,15 +307,16 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
-	if (req->cmd_flags & REQ_NVME_MPATH) {
+	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
-			return FAILOVER;
+			return (req->cmd_flags & REQ_NVME_MPATH) ?
+				FAILOVER : FAILUP;
 	} else {
 		if (blk_queue_dying(req->q))
 			return COMPLETE;
@@ -336,6 +338,12 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_failup_req(struct request *req)
+{
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	nvme_end_req(req);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -354,6 +362,9 @@ void nvme_complete_rq(struct request *req)
 	case FAILOVER:
 		nvme_failover_req(req);
 		return;
+	case FAILUP:
+		nvme_failup_req(req);
+		return;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
