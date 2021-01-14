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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F5C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA5C23A55
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA5C23A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPhpAKB+QmHxIgXaBFuqUaE86SvHvDAFR3ZRSzSWUyQ=; b=XkCdk5hSbaKOTUSheSoh/r+KUc
	8fhGuwcqEfGJR0kcKWZkhNiU2gpI0dXeHf2r2y+SiNjLoYNFS3feYNPiHo+HVb2WO/uy/OTtjhmvI
	5QpovDwHYTSIlvh4/jnx+FYI85KcWD8jvV1Q399TGf1RdqMNPtFP+SPuTPLbH8Gveac7gU0rFlhh6
	mhF+8W5rjCCVl/rdScsP+T8pL9DLvP0HvOA+19NVSak+HvnEfqwRwcczqEAZ1JT8YbyBqQyRS9Oxm
	yk3Dc0TQOOE39EWPfRh9MIXDGcKy7aUyH/o+y3dfHw6KoBO53fWQ7dnPIFkhsRmlWUJnAvQMO9pFH
	SVw0nbAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l02in-0001UK-Ik; Thu, 14 Jan 2021 13:31:29 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l02ik-0001SV-F7
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 13:31:27 +0000
Received: by mail-pl1-x62a.google.com with SMTP id t6so2913847plq.1
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4ufnm1N+hRBr2x1UPDUsu+QMVKWUzczgNKe4REKcRLg=;
 b=YShVFT+nAV9ga+maYzF+G5PWeoGq/18GyBt/MMQ4s4w3FJbMLsKIAJVg2w5H+1yAfd
 47Lq/IT9Dz4BcIT5eIvznxJTxk0hwcdl21LK22q2M3jyvyB3XVhuqkj/fINupeM2qlg5
 U3nk1v5CRnONeswNvNT/YhPXdrHaKIqG+j5YGYNjxyvRalHvuF615ROh8JJOpgTOhBrx
 3ZvoyKkZ/td4cpcZSzL3WZkbXf3noja6wlLGLCK4hutTRrHGgS4GtPqJKN0eEOuMGTzY
 N4NlruIZ1trPxgCIdgg6atUtZ238C69nu56+8yLEsdHP9uKtbyvFTcT7pnmitE/j3nhI
 wN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4ufnm1N+hRBr2x1UPDUsu+QMVKWUzczgNKe4REKcRLg=;
 b=is7TILiOW4m78XcjwvKALTn/86V3lTOrak+BJlMoRzPPjm5HGw6gFa8ECjIvA7hKNA
 u4pg3TF+qEdAePOJwvLrd9LZk8v6s7wRyHOY3GK9yi7PrSl35CB0wTu3Bmbsm0ucXTje
 OWl4qJsnQFF1GLhl99vY0AZ+07Kv4tLJWKGxxaBQgiA2cj5sqTyyRjZvIE8sa3ztFuvT
 Jt5BUhyv3ycQ8ZZ3ANU8aiLIVkuSbtko7NOzw9Zd+7Ag0LOoG5FvfYbcpNLr/6LzLDnN
 PMWcn+mGlk8uiKHIJf2QQuJzoSpxNgRapQ7ZaqtvbgBB8idkUJ2WWLfXjDMrKgf++1MG
 MAlg==
X-Gm-Message-State: AOAM533vEeqWZVj4MSx/nypKv5wN1FDY/5K2gICBtoDtqXnI4k/GfI+J
 6pd3osT+mSUUK12RLKNnMXqrmxpDweFbWg==
X-Google-Smtp-Source: ABdhPJx0g6XVf2VajR3aHq+xeIjOAaAJ7vY/RTic0FpgtYJHiJ6VkSSEMHIIDlHMz/xYArKDZN4Ljw==
X-Received: by 2002:a17:90a:fd08:: with SMTP id
 cv8mr4882276pjb.29.1610631084091; 
 Thu, 14 Jan 2021 05:31:24 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id gb9sm5549860pjb.40.2021.01.14.05.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 05:31:23 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 2/3] nvme: introduce acre flag in nvme_ctrl
Date: Thu, 14 Jan 2021 22:31:09 +0900
Message-Id: <20210114133110.20779-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_083126_591988_347EE4E5 
X-CRM114-Status: GOOD (  15.54  )
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

Advanced Command Retry Enable (ACRE) flag is added in nvme_ctrl
instance to indicate that Set Features for Host Behavior Support with
ACRE enabled is whether successfully done or not during reset_work.

This flag will be used to decide to retry commands that fail or not in
the followed patch.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a8cee380b3c0..a286e3422c61 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2498,6 +2498,8 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	struct nvme_feat_host_behavior *host;
 	int ret;
 
+	ctrl->acre = false;
+
 	/* Don't bother enabling the feature if retry delay is not reported */
 	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
 		return 0;
@@ -2509,6 +2511,10 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
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
