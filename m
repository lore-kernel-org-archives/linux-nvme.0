Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E9C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:08:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E58E61166
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E58E61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FlVqnLRpaK79B3ee1Q/NjPO/VGpxgJ42xbIUi0pfRuY=; b=WS1twD2MWj6ISLRQz95KEkMDqK
	Mgs87zwRNQXdssDxlkirz3W8OquysGAiY5piaB6hOXhlH4X0sNKMBHrEX+nb7k6adcWT6ROz44h75
	LxlDWV4qB65n+szAbyjchl4gZJ8tdO6iyCE+dymyvQQ4VRiLzjCzMjxyyUaqOIV7mMd0oLSXuvJCf
	UVomb2GdS3xqjN1pNyw7khBB0qeBhfP190MKyeGUvaJ3buxVP728hhDs/DwHO/EVTByR4Gi65EkIm
	EaOhNVL6F1fRIRBrdLk/KiyaNM26wINFQvkrSDRoLW7hUruW+Gyrbzexz1RhNPmOPvk6gVczWZAsH
	pzgDRvpQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXWcs-003XJS-3w; Fri, 16 Apr 2021 22:07:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWby-003XBg-6K
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 22:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=bMR2VTLj6F901p54R7TJJG701KH0qEMwjYWby2WBJ1k=; b=fpkqQPzlnNG29UkrNha4JhjbzY
 TbBlWW5zWL2vz2j/fUDgEKwxxxZv9m22joVdkkRr3uEMifD9QqwCjzuLjY5wXk2Vy1fO+DpE3OFUq
 qzwTbygaWmvn6VifG6HlkZFhHqWQCNe4VhDXktGlS4IG+akxtcT2aRNybcQ8/nCoPV55h/tk81sPh
 j0ZNCFgMJto+GgkOrtOzAyPutIEXv198RMP+0f0FnFPfIyNCR8bgEbBM5rd+0Mrw3iWmdzNK2zcJX
 0jZpuEJbwHZfWzZGePEgVZSJWJ4F+287k45DL3VTOPkbSC/i5TZNXE3z4sWun8QkEMhb7Q22QObGQ
 u+Qs9YdQ==;
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbr-009jkF-HN
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 22:06:49 +0000
Received: by mail-qk1-x72d.google.com with SMTP id f19so12753247qka.8
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bMR2VTLj6F901p54R7TJJG701KH0qEMwjYWby2WBJ1k=;
 b=mDbIrcwHFRy36PxLRjINn8KBeQK2Ja/TGUbAGVEyEBT37K1rvaRAlkrDNeJq/H3FZZ
 cqqFrzkh9T9aBaM0RJ1UtGCc/jYEa82z2twH0NyE1CWV5hijRzXptVHlq3Hv6G3g7Ozb
 AKvmml+Zn2DR4xbG4k4pu9aYBgvbr0jJWoiNtwGjphQfr4Z1KxKXnlHMwyBbpwSRzzBa
 6yDUJOsJ4AOGUWhkUvDkGml3yGr8IrGqo07FHzOug43DugUS+N9qWNfke0iDL2o/8ONi
 cTF+LUdYsZ39xgjDEt0IC2jdjJ97Q7aNOMU0SlXTWjwuvWOZwH9hjj/3O4eu9gdXoYVi
 mhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=bMR2VTLj6F901p54R7TJJG701KH0qEMwjYWby2WBJ1k=;
 b=mXE9LN75xTztt+5+qF4EIheUqlMt9Ut15YHcrNG51ZAapNw0OCfdJbcT66FWobwUYf
 F+G1HFMx6dac2h0eLqmFQcu4irt3oN1sfHIlMxFqWrkKyEbOR84x14iT5hSgrUvZHohj
 9PbStKgjoA6qDwQpBSQOuxyVlbdMKApNsQlEXmuocyrnw+xyb5UeDY/Ywg3VJGUSXtU1
 BLtLnZ5Zvw/8VH2Rl/X5JrP00DCLcimGF5MYd6vq1Xx6pJgkNm5l7H2ZvhMx3h/0SWUi
 YTUrRe1fvgBTMNNw1m+rHzJ6FarslFsaMYKnbwuOuTiB+k8aL3GWFpbjU6LF1gV59pWH
 ZcAw==
X-Gm-Message-State: AOAM5316gzaYhdq83xgiNRip8/Hz8pP/qY/O1nXOTGuKdAjA5IX9dMJF
 tRUZVT0eHv8m7Tchsym23Y4=
X-Google-Smtp-Source: ABdhPJwWCSOVGVoMxgIJwBSWNNpF9FwTIxmOZvPSZ8Rmi8aNJ381/s9+9qabM8hKroVd8ED9vuQBtw==
X-Received: by 2002:a37:7006:: with SMTP id l6mr1394793qkc.137.1618610802681; 
 Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id d62sm5173006qkg.55.2021.04.16.15.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
Date: Fri, 16 Apr 2021 18:06:36 -0400
Message-Id: <20210416220637.41111-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_150643_594787_27824CEE 
X-CRM114-Status: GOOD (  16.83  )
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

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4134cf3c7e48..605ffba6835f 100644
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
@@ -343,6 +345,25 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static void nvme_failup_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+
+	/* Ensure a retryable path error is returned */
+	if (WARN_ON_ONCE(!blk_path_error(status))) {
+		/*
+		 * If here, nvme_is_path_error() returned true.
+		 * So nvme_error_status() translation needs updating
+		 * relative to blk_path_error(), or vice versa.
+		 */
+		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
+			 blk_status_to_errno(status));
+		nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	}
+
+	nvme_end_req(req);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -361,6 +382,9 @@ void nvme_complete_rq(struct request *req)
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
