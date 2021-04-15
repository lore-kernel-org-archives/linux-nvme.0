Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDEC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:16:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E4460FD7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E4460FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PRcbcgqE0vWixJhR3kN5zY07vs6uGu0omf7gyKQOjq4=; b=Q5/u3LJ4MWd+O4pRO20VWJbgbc
	yYT3kwGUVr+k/i6fDUe8PhryrnGR/YZixEXSC5y0gjjh6eQT0dZrX4XErHZFtfpBdDXeV5emK+eT+
	IejKlPJu127a6uaWr7rJIN8hEhp5xAzq0FQPfWY1lYIYpT7okm33XlllyRduJIKtLn4szchRPonzb
	GY7Yt+Ivefq69fObk/mlIvYPMB3wjdHQCJzFtACxDgwzC4GIszpiiscHT1i4WHwgTq1jSJiPqoWm3
	7r16C+j2Hpz24xtJy0S44RQQwrg3QrvxeiuE2DeiKRH8yiaFCktWeKxC3n2ZqDucOeB0xBRMpfpom
	e2X3YOMw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBDz-0002sF-GT; Thu, 15 Apr 2021 23:16:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBD1-0002h0-Sc
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7RCfwAN4jL/DjugvaPSOGTsmpmXQlAF+zlH96pTjoMg=; b=l7aJQHH4/Zf1RUd1khm4YmScVZ
 mdV2mf8jszszbc0k1VNEUvwB9ITEctNuyS4H1FVbmPX4Lhvr00puEVxLDsupfcX7fKxF75FTTly5W
 6b9NsxbT+qjlWGiZ7ESU7ERh29V1KAc8r5X2DQ2hTsHqSHA0zMyLXN7ACpHdnAHO2DZkOFSzQ9QpM
 B7FNjO9H3dcagZTin/gGsxdxidYz36ybx7A0v2/xrELdt0OqFa4I4s6/oSeblg0p7O7pRiRrXwfTO
 LeRbBzqsPjP/0w9iz+wimLMe2314uOHZFD5ypnJijjbrjDPhQXiwWlNmd80tKqlQM2WV1yKEUIiEl
 zPmRxFMQ==;
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBCz-008xvQ-8K
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:15:38 +0000
Received: by mail-qk1-x72a.google.com with SMTP id o17so18607715qkl.13
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7RCfwAN4jL/DjugvaPSOGTsmpmXQlAF+zlH96pTjoMg=;
 b=HSjDkB47gFDJ40jIAgfKGOwisFzX5ppiQIpfjeawhJybyMhgCNcxjSqQmUoZcyiDyn
 aNlTbyf4LI0Ct4TP1bykmZBA9UNZy8Scaz7Nq440NfLOJOIP51+A8YcmbSWbT/PK12Zv
 +fPfnby7kQIvUGbn6kgzIWOYUwV6Edi//Cw2HO8BQFhBV/3ElwAQqI6LDP8pBGKVGHAG
 AaGS0JiEhoxfLD3Zn/Uh/AeIyPvxPSFNjGJb0gSFf8jKVwZZ0hBYYvC4ORI7mbZ3D9dM
 O3gsrE9a3TPX2n2MB89THPuJc+reClB+ZPZqzS/iUr10SuWZJ2yb4PretCEq4TL31I+I
 6Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7RCfwAN4jL/DjugvaPSOGTsmpmXQlAF+zlH96pTjoMg=;
 b=e5G7KnuE2pdcq6gyZg1FqTKhBQfsHiH2T2i+YDKIcCs+wBr+p4SXMnnJpx4G6fEnN+
 8/EyGW+QigvWUPGWymnmw8mkRE2LQxKK33Ly31PVr60RFo6GGBZXMlepr330yoodxURF
 a0OEKEbb+MTSfGRM0PD19ptyX9APxD/395NACxq3ex7w5hyRRiRufinE4KWaXdqRwIlq
 muyzbhQ80LGPoGNyN+qPI8ykbHxLGTLYqscf4ywjWUgY84VcTfaJkb96iPZ6JgqQsiDX
 Jc8qwPB2GnRxoB7OxigmIuSggo1ySevQbnMq0XNHxDlRIxy3AXhBUIQkkrdU3pYEk9LZ
 E58A==
X-Gm-Message-State: AOAM5329ZlkL9LmIh69dZfdk65Bi3q45mrQ+Z12JUyqVH5s/M3akSGxa
 1Ch0hegLNuxhsvV5lA/5Woc=
X-Google-Smtp-Source: ABdhPJwf8piMfDo08mpBT8UOsivPw4eYX8FyC0nqQZZ8gbPRXDke0svfzY8InnsN4GsOOspqnWEdpA==
X-Received: by 2002:a05:620a:70c:: with SMTP id
 12mr336862qkc.377.1618528536145; 
 Thu, 15 Apr 2021 16:15:36 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id c17sm2627690qtd.71.2021.04.15.16.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 16:15:35 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
Date: Thu, 15 Apr 2021 19:15:29 -0400
Message-Id: <20210415231530.95464-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_161537_314918_073D1F67 
X-CRM114-Status: GOOD (  16.59  )
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

If REQ_FAILFAST_TRANSPORT is set it means the driver should not retry
IO that completed with transport errors. REQ_FAILFAST_TRANSPORT is
set by multipathing software (e.g. dm-multipath) before it issues IO.

Update NVMe to allow failover of requests marked with either
REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT. This allows such requests
to be given a disposition of either FAILOVER or FAILUP respectively.
FAILUP handling ensures a retryable error is returned up from NVMe.

Introduce nvme_failup_req() for use in nvme_complete_rq() if
nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
the request is completed with a retryable IO error when appropriate.
__nvme_end_req() was factored out for use by both nvme_end_req() and
nvme_failup_req().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4134cf3c7e48..10375197dd53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	FAILUP,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -318,10 +319,11 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
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
@@ -330,10 +332,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	return RETRY;
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void __nvme_end_req(struct request *req, blk_status_t status)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
@@ -343,6 +343,24 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_end_req(struct request *req)
+{
+	__nvme_end_req(req, nvme_error_status(nvme_req(req)->status));
+}
+
+static void nvme_failup_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+
+	if (WARN_ON_ONCE(!blk_path_error(status))) {
+		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
+			 blk_status_to_errno(status));
+		status = BLK_STS_IOERR;
+	}
+
+	__nvme_end_req(req, status);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -361,6 +379,9 @@ void nvme_complete_rq(struct request *req)
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
