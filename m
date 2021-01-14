Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92BFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAE823A55
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAE823A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPTrUYJrKl7i9oi1yqb4/BCvAeyAbBk59sWpqjtRoUo=; b=xdcp2WYTSG7YzA5mvOWqNFR+IY
	lbuUoEIF0LqxjMwhFtzKC5Qg+Bwpz7peHPeDpQXkf8ILMF/Vq7xAG9nVtyau3St7gE98GZgB8QDCA
	UZAOAulWibVscNY4Id1HNauMW/CUvzZiSfbkpjGZiw5jUjzMjHWfQu8gugRCIyDrAEuo4dduvGA5m
	TRrCL2nBvKZ6UaOdIZVolzbgqB1mEDE814+6b8Ksj1S4KAnGvOBcL07uWBBM56pm/bsPsfjyfmaGc
	1yUbGtPqBPgPaJEGtMLmYVEoex1jocSaJC5dKx4C/1qpjoxOG3JT26LDR4eHa/Lg2lVKatXCTAURh
	UWf+eiwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l02il-0001TL-4Z; Thu, 14 Jan 2021 13:31:27 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l02ii-0001Ri-Bh
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 13:31:25 +0000
Received: by mail-pj1-x1030.google.com with SMTP id l23so3195536pjg.1
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9s8mDrj9Qo2c5wOTAo1lHo80hmVfcACcbXc+pNkTdF0=;
 b=oHrBHiGz/nvtrpEBz1cDEmrcn6xLodTBZGbD6LlHx2/sKLXyyuVzW+yS1k147/tVAS
 HsUsMRO+mTSc+3hnO8WokkilPtoZKtyT6DbExwK7beLA8Q8B0i4UZvDCbXLw5A/r4G3p
 ZrcUjuOuDGFOzrIfVTvnSaK1PKYNRfoFGpav94+zogAL0tlgnefqsLjA9s671iVIxjy4
 iB1jsXD+Z+8ap5YozNdtA2hH2e5HyY3+CZonxbeZPBQ2gQZQCUbMZ5DI0GfziyrFUxfG
 ebe1beqmeQb1oVjj+ZAjaA0m5nUJiAovXDovB+moikj1EN4VBI9lW42pqQX6GGIFDABn
 ruSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9s8mDrj9Qo2c5wOTAo1lHo80hmVfcACcbXc+pNkTdF0=;
 b=e+NtivhexLuW15MXlbTq+It4a+Ri5eRTQ+chpfYew619G0mRj7KgACJPtqzF8aYAOB
 YBTd+Sf8V2DiV3ybCOkDMzLVthyEQ+UZY0Ib1nRWvSz1AKnVQAg+Suwjr+KuuJystn5W
 VYkad6L6ek0Yj4S0BkZHt51K3byikE50nOzjbvOyra+EAbd5qiq4xKIB6imi0JNmr1ZH
 tMjst/iU8gJFtMjLcetZw35g7TAm/orz7+WIfnBSRh/1PXu//5Y7MafQluLuffHCxUQU
 DuHKfSkBIHNqLZx1E4JnsiDCvEEjRE6AS+iMkROs9uKwkWxSTlkFVr54+xBNdaImlOYA
 ZR2g==
X-Gm-Message-State: AOAM533D84WdQydPZR7dw+a3YVHdoapuQ2LIAq+BL/KgfMzLJZJ0DNB3
 4nJEkVIGG5xQFPV5WTWQEc+ZSFGZjZz3qg==
X-Google-Smtp-Source: ABdhPJz3htMfC+Z5Z7CwxPezRzXOa5i4WBvhUR8VYTmFUSrKHrBQcj00Q93vyvEjGUYPbQKLPqM6AQ==
X-Received: by 2002:a17:902:ff0a:b029:de:1d1f:8558 with SMTP id
 f10-20020a170902ff0ab02900de1d1f8558mr7571172plj.85.1610631081908; 
 Thu, 14 Jan 2021 05:31:21 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id gb9sm5549860pjb.40.2021.01.14.05.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 05:31:21 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/3] nvme: check all retry delay times in Identify
 Controller
Date: Thu, 14 Jan 2021 22:31:08 +0900
Message-Id: <20210114133110.20779-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_083124_449427_EBFCCF1F 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If none of Command Retry Delay Time(CRDT)s are set, then we can simply
skip to configure Advanced Command Retry Enable(ACRE).

CRDT selection will be made in Completion Queue Entry that controller
has responsibility to decide.

This patch checks all CRDT[0, 1, and 2] in Identify Controller data
structrure instead of checking the first one: CRDT[0] for cases that:

	- CRDT[0] == 0, but CRDT[1 or 2] != 0

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff49e544fdf..a8cee380b3c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2499,7 +2499,7 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	int ret;
 
 	/* Don't bother enabling the feature if retry delay is not reported */
-	if (!ctrl->crdt[0])
+	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
 		return 0;
 
 	host = kzalloc(sizeof(*host), GFP_KERNEL);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
