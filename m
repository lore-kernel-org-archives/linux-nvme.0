Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047FC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:36:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD0E64F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD0E64F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aOrl6jML/PdM5tNJWlrR6xuC+IPVkIOtJvkfYShZVAE=; b=WoD2MmxSoRqqCN
	5REAhOHFvJwwPuKtisAEJjLHS0rcrCD7r58LpVSQszJmpsQwC+uNI+b5mEaQJeAPjb3orACCS05xG
	AcscnPfDiZ8FhZkj9VPELAiCNquPbjvI7vPj5Mxs+AO85uilPQxadF6GJqlIflPG3EPQru2YhWSkh
	UHUjGDnF6tWOC7kYYMoZOsk94XjDFqIpZzmupDIbouESBCnGNBCp9Q5iWJrJkeunt3iF6Hmr1pkgB
	4mlPl7pAadBqnTr17zlYTCCJkvnteMuiLaFkqcJ+szryRgs9erGnz7as6UmqOl83unxTKE/2kuksc
	pZsstZBwH88+Na9NumPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLvoW-00H2KF-Tt; Mon, 15 Mar 2021 22:36:34 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLvna-00H2I0-Kw
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 22:35:04 +0000
Received: by mail-pf1-f174.google.com with SMTP id x21so6200474pfa.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 15:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nPRHxt1Bid5WMYJp1lsiBwEM33J9wVJ40uNvYCpmbh0=;
 b=GsOoEfpA7T+LZfyTXYwk2tTtm+6uUYtrR4SO71txvwMCs43/N/ZmGVjuttssVMFHxU
 S8xczgSFlCtyWJi71WGXIddaIjhS3+4yG8+95chAkd+07KcPFF+RXdPFzNfulDhYmoAJ
 Zhh11Zi1Zv6+DnL4VVX1klSnzlceMqGxWQko2swOsgN4GsxoOlNEzzH7h2h7FHFQuE8p
 zz0fDbfCuSbQToSdTgqU2ampUSafxx4HOIkukDybgMtjJdajtK2wjWQiSg6EhWe9DdMT
 OREYGEQm+EBWtztunZt7tX/WDXiqnNSl8DvhhB4ZgAuTXcZnMiVXFf/60G9yfhqa1wY3
 jvyQ==
X-Gm-Message-State: AOAM530VTVm/J2AinG3r0tzdwFM4RinZ5KpTDm/V2A1LLKJvXjQE8Pwy
 dG1v2x35CaGN+MquaURbcOl7W0OffRc=
X-Google-Smtp-Source: ABdhPJwTDou/zbEmAMuJJIPfJqPrQnJXHp93y4qFerXgSEZ6Lzr1xgrtKI6TnX8OIRSM3BDpe1IMfw==
X-Received: by 2002:a62:2c85:0:b029:1ed:39f4:ca0f with SMTP id
 s127-20020a622c850000b02901ed39f4ca0fmr26922234pfs.11.1615847692891; 
 Mon, 15 Mar 2021 15:34:52 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id e22sm14289096pgk.56.2021.03.15.15.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 15:34:52 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet: don't check iosqes,iocqes for discovery controllers
Date: Mon, 15 Mar 2021 15:34:51 -0700
Message-Id: <20210315223451.380437-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_223502_629803_3A436AAB 
X-CRM114-Status: GOOD (  14.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From the base spec, Figure 78:
"Controller Configuration, these fields are defined as parameters to
configure an "I/O Controller (IOC)" and not to configure a "Discovery
Controller (DC)".
...
"If the controller does not support I/O queues, then this field shall
be read-only with a value of 0h"

Just have this check for I/O controllers.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Reported-by: Belanger, Martin <Martin.Belanger@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index be6fcdaf51a7..a027433b8be8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1118,9 +1118,20 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
 
-	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
-	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
-	    nvmet_cc_mps(ctrl->cc) != 0 ||
+	/*
+	 * Only I/O controllers should verify iosqes,iocqes.
+	 * Strictly speaking, the spec says a discovery controller
+	 * should verify iosqes,iocqes are zeroed, however that
+	 * would break backwards compatibility, so don't enforce it.
+	 */
+	if (ctrl->subsys->type != NVME_NQN_DISC &&
+	    (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
+	     nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
+		ctrl->csts = NVME_CSTS_CFS;
+		return;
+	}
+
+	if (nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
 	    nvmet_cc_css(ctrl->cc) != 0) {
 		ctrl->csts = NVME_CSTS_CFS;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
