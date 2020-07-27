Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB0C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1154D20729
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p4LCyeco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1154D20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3oQsbZjhC1ICJh/5zQjOCV0jXiN+nNVsu+3KI4xDqDA=; b=p4LCyecoodciCvgwi6HyVqST5
	OOic3LKTG5JKaTkCCtmyAOdJwb1yrVyS3SNGMETlj3XCXFFujobUzJoTHNA1ILfCyGfUDAsd8up9R
	aWgcD8Q7ZpBFvVPl60ag0mv7IP3hOZFUOFg4kQhmYI00LI98TYYpIVP2ChTZqUdkodGNTbzCt8EJt
	bfs5fqHnt5Rqc1zlUiyrmeOAmZmY4o9okZ1UWkaZSGY9EpwkRfvZBsAvP08REPMuCPYLveETK2I0K
	2/gveCJA6Kgy7OgLFIlMIy32MEyOgc4Wi17SI+QK91hrrb/AhN/vNbG62w1BFmZKcYUoATbcT940i
	IfWJ6L8MQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0CGP-0006EH-EK; Mon, 27 Jul 2020 23:10:33 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0CGM-0006Cs-09
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 23:10:30 +0000
Received: by mail-pg1-f196.google.com with SMTP id e8so10804454pgc.5
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 16:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rhPI1AK8s0t5ZglX+PETgazcv0kHzfPuguyROZL/wxE=;
 b=mM1OU8xv8wrQew6ic2BlKaGAGdwlsBbUHOBXad9Hv6AGWaZ64sSbGnEZqoAnXN1o3a
 s+wC6Q0sVUhb9V5wOBYnClaC4YbUpb6aP8HSHANrHd+Y/YprQyRg8kEbtkGVSQJ78xFL
 vbERqS4dbmXdGEpwMx/4w7B+dqLBA+IJx1o8mjIUi9+Rr72+eVUUOwmavDTERWy256Ko
 wWY+TphCkEBQQH4Jl5fPtoxpQzBhAEPt2JL9GlYzzduSkaay+izyk5xyEh14+uOHSupw
 V74lyFqDRTLWaQ3qjWDf5Ng9O01rTErwICNI9IgKSdv9pDJP/BZvwsQSR5aDlELBaUjn
 uObw==
X-Gm-Message-State: AOAM5316jvcUtNTqUV6nGFMeK1MY+d+4yqJrS3s9bkf78Opa46CEueDV
 ymqqsSvoCnjrtxAIChFp4pMXitOo
X-Google-Smtp-Source: ABdhPJwN/y5+qq3rd5tJTCca6/CBeuaY47jNx6qXZwnx26i6zeOQ5qwwrsmdbrP74v2FNbHJnC+6AA==
X-Received: by 2002:a62:7942:: with SMTP id u63mr21722936pfc.54.1595891428381; 
 Mon, 27 Jul 2020 16:10:28 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id z190sm7407171pfz.67.2020.07.27.16.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 16:10:27 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
Date: Mon, 27 Jul 2020 16:10:22 -0700
Message-Id: <20200727231022.307602-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727231022.307602-1-sagi@grimberg.me>
References: <20200727231022.307602-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_191030_115154_ADDF143F 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All controller namespaces share the same tagset, so we
can use this interface which does the optimal operation
for parallel quiesce based on the tagset type (e.g.
blocking tagsets and non-blocking tagsets).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..c41df20996d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_quiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
