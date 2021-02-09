Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:12:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7539664E6C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7539664E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3BW59+/wPjd6O5MdMg5NzIF1hv0T+ULZtgEq/NYFLmA=; b=R1R5n4NIuzZOsnNgbQln1Ea7B
	Rai/7E6Zd/VT9s6mIspk1tV2SXzQjwpdtQITfnhReFn4meaihodvVFrjoWbqMeFjNlUUj4TnCjNSI
	EPUGMJKVqgyDPI7f+Ah5MYGk3Wd6q2g+tl/JeQqpevQj/EhnxwT+Yh7rNurTPG6ehdaCAPSa3e0ul
	MAXxvs51vccv5QXrFNgVrpwTMXCYHWWLFJrT5hv0c5cv200AmlJbBXOFmMlbte7curbSURPfDi6pI
	vKwhZfN528bMPaHQIb93PSIgRDIJIRNjLc5tzc0CU8r3UimGSzzyCV9dTV6Un57gE6muayISx1RUl
	Jz1VgepaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Q0n-0004ml-1e; Tue, 09 Feb 2021 10:12:49 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Q0j-0004lI-HX
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:12:46 +0000
Received: by mail-wr1-f50.google.com with SMTP id v15so20886371wrx.4
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 02:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3PQ1WN+bvRt6BG086CEuTsYRusSq02lU7GgJZRbqPTo=;
 b=QlaJa4ZSPYUv+zqr1vF599/5qTBalRP3fHj/zSvU+kdSJ/K7MgmD0JVX9EW+cneQ4L
 38+Ubm7ia03z4Z0H0QuSyiyWOgdn5RzL4EDfGhGq95FajHcSb7npWrSA8ncV87gZPWyw
 GpA2ySJ5npv5S4/qyidD89BCXBJlyBpl7NDeo8GXs2DYa525xALQxPe2gdSXJ0lr89K7
 WRUnixs+lndT4qqF9Q1DLcgkVERVAl5myG4EsFmyrcik/uUrKPdpmq4dYiRj8yVFW/kn
 rb48k+NphoBzxnsf5WDbGLlRV/uhVV1C8217o4V5nQMAzAyx4cO5AfDlfL71zbqdZ4xf
 gtpw==
X-Gm-Message-State: AOAM5324X0e2/qyyMYEKWn4E3Mu4b+65KSX+EQrbMyDCPUE99s41375J
 I6ybEvJQO3X4WTEn5gv8jy8l/2+wdVM=
X-Google-Smtp-Source: ABdhPJxS1Y1rN/FPGME4CD5Uq3l+dcbS/I6Q9llNMnaIcIjELoCCgwesAqzmB/NlOAH1fGP0rP7pew==
X-Received: by 2002:adf:e510:: with SMTP id j16mr16087260wrm.153.1612865563814; 
 Tue, 09 Feb 2021 02:12:43 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id h9sm11173396wrc.94.2021.02.09.02.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 02:12:43 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery controllers
Date: Tue,  9 Feb 2021 02:12:35 -0800
Message-Id: <20210209101235.1539917-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210209101235.1539917-1-sagi@grimberg.me>
References: <20210209101235.1539917-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_051245_596582_6BEEFA72 
X-CRM114-Status: GOOD (  15.26  )
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
Cc: Martin.Belanger@dell.com
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

Set these only for I/O controllers.

Reported-by: Belanger, Martin <Martin.Belanger@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 546a10407385..a7578c601727 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2443,6 +2443,11 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
+static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->opts && ctrl->opts->discovery_nqn;
+}
+
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
 	unsigned dev_page_min;
@@ -2468,7 +2473,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
-	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+	if (!nvme_discovery_ctrl(ctrl))
+		ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
@@ -2888,11 +2894,6 @@ static const struct attribute_group *nvme_subsys_attrs_groups[] = {
 	NULL,
 };
 
-static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
-{
-	return ctrl->opts && ctrl->opts->discovery_nqn;
-}
-
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
