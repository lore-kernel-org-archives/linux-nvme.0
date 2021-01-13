Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB173C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5139923433
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139923433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxmoweinjaCfAUdh4scvYjheXUmjfznq09KQpm7q2PE=; b=EalGEOf0XFTCSipAh2FFseD9R0
	FsVBrFDu+2Sp9gQD7meVyGR/MGOSAOxmjSUCn4ZAXOWTM15UqNedjvVDTYCl6RjtIKGSjOKcikPx0
	5WpIeOrvRldMhpqL7IT9baf+k8u8TC4o9B26+qjHoeMND5Q5e8rJtbX/LIbVmIQrI8z6V1Ha0JCl8
	Y7wWEN454rg9ubt22uFUeHfzBtMMMf4nIJkSeCSgTfbqVl4HvMCqNp/Wo5j+w/Jd5igHx7pehPnTK
	Kwb7xv7tbOT0GihkV05heN/p0Fs2TKDQ/cM69VTEHs38vb2Y8ZQerNdQXVDEayEFphqvQ9x8UaT+m
	PVlPV+0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzhFh-0000qJ-Jz; Wed, 13 Jan 2021 14:36:01 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzhFZ-0000m8-LA
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 14:35:58 +0000
Received: by mail-pj1-x1034.google.com with SMTP id j13so1319720pjz.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dD1kMbQyf5Z/5Zm0nio5L5c0NILc5FtiXPWM7GRqzl8=;
 b=Ck9mtw86JPm51kmrlWvXxh/lOzMjXwq0P05buBP8FDObsOkye/fMlJoOE00nNIwcp4
 UMyddHWjvIOfuyb/cjNpmwFr2KwC9GLq5IpVjiQ3MT6qQiRyY1ZGoE/YctbU4jBaRaNt
 WQxQCGs3aLIc6ibyJP2E2yYdiuC3KJh3v311pp3swYnWqxC+EGZxCzyLY7iD4KT4eyX0
 xpfgk8HBOpNMXmz7E64PrFweLhukPXeYiyG6N9KP6uvM//wb/WbmxqWGAygk239QG6AB
 STFNyUHi/mcjgM82pU3Xo5t1/ydV+I5eAkBfKh3xCsCLT/AAgP+FhozsQpRpfUReej9x
 KRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dD1kMbQyf5Z/5Zm0nio5L5c0NILc5FtiXPWM7GRqzl8=;
 b=M49iNI8Y0FVzT9MY2Nd47LBtKvVOUNMKKo1F1OMwOrYPuKfIflXALgqnM2z/26QWSr
 om4lHxHR8rUztYYzWa4yQakKbzt2VxtTif7qaKW7qZLwvxJWBsIfcZ/gMV9s51kgb3zM
 HETLdVB1zDHiNwjDaqYM1pai+J6fo1CjTXoNGgOcFlT4FVsSN3Ag7sgS/ueYsjtuZU4U
 SAB8Mo0QFWSi8Ev1fAXtLe5uskIfhqO8FslO9DHtO/iDfstWW7/VOZ8A048VvtTC5piH
 WT8qe8TNDaVfn0Cq15C3JzXmHt7AUdBGI3BGbYjtwzHMA236Y1X7ldtzw+ovV6nIUm5H
 Os4w==
X-Gm-Message-State: AOAM532rDLtLexUr2/bLCoP5Jir8z+mB0X3Cdts3h14EcVu5bHbuPJj8
 8OUTvX4CWKTVthX6SCLY3Kd0Mi31n6/dJg==
X-Google-Smtp-Source: ABdhPJzgafj0ZaB0TAPSVFgeyDqCF+vl3pWHL/X9tB+KzRQukuYwENu/b0X5J/6f4UfQnVfNIkLIrg==
X-Received: by 2002:a17:902:d385:b029:da:c6e4:5cab with SMTP id
 e5-20020a170902d385b02900dac6e45cabmr2501013pld.7.1610548551194; 
 Wed, 13 Jan 2021 06:35:51 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id i13sm2914431pgd.32.2021.01.13.06.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 06:35:50 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvme: retry commands based on ACRE result
Date: Wed, 13 Jan 2021 23:35:38 +0900
Message-Id: <20210113143538.554-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113143538.554-1-minwoo.im.dev@gmail.com>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_093553_798417_B1EDEC13 
X-CRM114-Status: GOOD (  19.60  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce acre flag for Advanced Command Retry Enable to controller
instance to decide whether to retry or not in error cases.  This flag is
set if Set Features for Host Behavior Support with ACRE bit set is
successfully done during reset_work.

This patch also fixes nvme_decide_disposition() because all the nvme
requests are initialized with REQ_FAILFAST_DRIVER to req->cmd_flags so
that blk_noretry_request(req) is always true.  Check ctrl->acre first
and if it's not host path error, then it will be retried.

Cc: Chao Leng <lengchao@huawei.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a8cee380b3c0..391bb2d08d0f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -303,8 +303,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
-	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	if ((nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
@@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 			return COMPLETE;
 	}
 
+	if (nvme_req(req)->ctrl->acre) {
+		if (!nvme_is_path_error(nvme_req(req)->status) &&
+				!blk_queue_dying(req->q))
+			return RETRY;
+	} else if (blk_noretry_request(req))
+		return COMPLETE;
+
 	return RETRY;
 }
 
@@ -2498,6 +2504,8 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	struct nvme_feat_host_behavior *host;
 	int ret;
 
+	ctrl->acre = false;
+
 	/* Don't bother enabling the feature if retry delay is not reported */
 	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
 		return 0;
@@ -2509,6 +2517,10 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	host->acre = NVME_ENABLE_ACRE;
 	ret = nvme_set_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
 				host, sizeof(*host), NULL);
+
+	if (!ret)
+		ctrl->acre = true;
+
 	kfree(host);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f5..db8b45e8ffde 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -270,6 +270,7 @@ struct nvme_ctrl {
 #ifdef CONFIG_BLK_DEV_ZONED
 	u32 max_zone_append;
 #endif
+	bool acre;
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
