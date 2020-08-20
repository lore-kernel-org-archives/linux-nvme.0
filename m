Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA33C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:13:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A0F2078B
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/6lCzk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A0F2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DK9AOQnZQ+/uOilb7sfRdQ+tm7nuDHG9iytT7GqpkZo=; b=h/6lCzk09bx8ITx3MIXEfzmeQQ
	mN6O3NYQTjbi0e8CmLt8zVYmjnVSVsU+T1GeCiF9HTweRixAVSqd3429ZbLuRvfmBEEw6toblec05
	0V/QhD3g7Pfe0DFK5dtfiKel3GmPRgeSOk3Os2KKgZyDIQa0BNeH96gXShHXPLuFK47k7vhj90pcJ
	4pIRx4dPQicLiMUPvWU4bgGBI/bcV8FzCvHAhvgnjChxT/PtulOeDFpPypwZgPVFSUaqB8kTnihuR
	Ak1Ga6ETuPM952DA7hIP0BjQP7hFkEAphvYmHbGNuQWJYDiQDf/8q5FbEIBQJ+swH+DLjPRQHzzUV
	2DwssJwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8b1I-0003dK-Ql; Thu, 20 Aug 2020 03:13:40 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8b1G-0003ct-2b
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 03:13:38 +0000
Received: by mail-wm1-f66.google.com with SMTP id u18so328777wmc.3
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 20:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uSa3dKFwHsl26K96yJoavpbvsGnWZLg9bzU2fJZE5kc=;
 b=CplKz5lMiC2g4WI1k5eniuzjdqbcwuc1pvFUtCCMcFMn0AuwxsVj4d/a8YDmGbMkLP
 zW4r/E4SM5qce5kBt0Fd5bJPS4xL0Y2KF1DkIilelVMf28SU51Ulezy6xe8kN6o2QoBy
 8mN3BvMfXSQ8gcr+sXHTzhZwtyWNodw/AaHXo1mEG3l+fMGO4o4aGJiHqs1uRLeqBsxM
 0eNMA7DkTJqCPZAGi2edCk0+B5f/65qIBAFxArcFuCmSUmUH9u6L8J4FPazlAA0j2xII
 BigrdkUNoyNOc9Iy8wiBmv+wOQMiSKAuAbbTZjdgevCgjt7oSOizSOpnU/gSGqUyoK9Y
 cHNg==
X-Gm-Message-State: AOAM531bsBNujvJGPwxzIeNynG+9VIqxNyWFNJCDEUq2x+zDhuCFpxxI
 jhoX71gCphZQ58gadibP6IWKYW59Ol6/iQ==
X-Google-Smtp-Source: ABdhPJzCxIKJkIiOxjzq0gjKF8lXiDzBxrrYL6nKONGqy90fTAcTRAjHgahC7MoPrPSO8ZL38Du1bA==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr1257285wmh.56.1597893215177; 
 Wed, 19 Aug 2020 20:13:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id b123sm1463978wme.20.2020.08.19.20.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 20:13:34 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH nvme-cli] fabrics: fix passing ctrl_loss_tmo=0 by default
Date: Wed, 19 Aug 2020 20:13:20 -0700
Message-Id: <20200820031320.177627-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_231338_133032_EF42F42D 
X-CRM114-Status: GOOD (  14.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

cfg.ctrl_loss_tmo will be cleared to zero even if it wasn't set
at all, we must not pass ctrl_loss_tmo in the connection string.

This fixes a regression caused by allowing ctrl_loss_tmo to be
zero at all, by setting it to be a sane default (which currently
matches the kernel default).

Fixes: a6105a30a39a ("nvme-cli/fabrics: Add tos param to connect cmd")
Fixes: 4b607779af71 ("Allow 0 value of ctrl_loss_tmo.")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index c93b752ff142..f8a055b7d9ba 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -54,6 +54,9 @@
 
 #define NVMF_HOSTID_SIZE	36
 
+/* default to 600 seconds of reconnect attempts before giving up */
+#define NVMF_DEF_CTRL_LOSS_TMO		600
+
 const char *conarg_nqn = "nqn";
 const char *conarg_transport = "transport";
 const char *conarg_traddr = "traddr";
@@ -85,7 +88,7 @@ static struct config {
 	bool persistent;
 	bool quiet;
 	bool matching_only;
-} cfg = { NULL };
+} cfg = { .ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO };
 
 struct connect_args {
 	char *subsysnqn;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
