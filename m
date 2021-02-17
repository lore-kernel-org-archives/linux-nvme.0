Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F0C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DC164EB1
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DC164EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FJA6Pi/sj5olAGfFEIdYzgjUb705dqoCvzDw0+5WE+E=; b=UknHmJgbCtYT9raYBb5f9VbdP
	QHURMcViTTPH1CVqBlddQSbykn3ZgE11VA5zHsNvvYSgtadIEHJdffDn/YKyWdC70MXlylzennOa3
	9ZHhqc9Sm9YVwEVG6erpti0ybahJQ2IVc6ITXUXQNBMzPJml/Julv6XiFvmRCUknz1T2eIweY5ptl
	PGz2sxLCAEZyrBYLiGqta3nqwN9dRZxcVQ4tYBBa6KmNN2ju2GjZQ+xqxFzXTORCaWvYgWPjyjtrL
	2FWTMo/TvmI4ZcVp2sULgGsmw0BVk+XsPa0lTzEESY6rpt81lHEgzAj3j/ZctmrSRSL4+WLd5APBV
	Ru5OecihA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCARF-0007iK-Dd; Wed, 17 Feb 2021 00:11:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARC-0007gb-1f
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520685; x=1645056685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b8aOzb87EaHzEvMhWVInnvrOmmhseUd520qKYpC79hU=;
 b=p+p3vAXLLvWfD2kvZk0mlac2KZmaajhA5IQ4Wt4HQgYN3UOq64SjHG5C
 hWGe78dqCPDJaV5bezUj902eMMMfozOnaFeTuT91ycC4ZcOnjNdmXWyDo
 tvWP9NvtWVR8pxJfDW7dFDTPtbw+kVBW0bD+zrZtgI7R9IDs+OxtEJz6q
 HbQFg/pLj7FurdsdS/rBbo9OMvSVvpxRRpZnrcjZJ+uG9BhHTjyFZgXWa
 YSPiaOtCQr+lGz3UcNxzUnuh6+i7DVEjtEfJQUROrCpoULBkCcwH8gEsY
 28aAnate8RY9BQk4l6Mnw7GxcSQXaNute0C/7dSrq7E04YXlqQoGd8h29 Q==;
IronPort-SDR: 1uEmfv9QxR5V0pawHk9lmvfnP/M1utPI2nhNvL3iBAlDvA3Eblm+vrAEOPW/Ny8gka6rm66I2q
 4qmb++RSkS3omMxzHlDAmLIRdD8uIhWP1UYde0kh1Kbo9HR/oSCy0xG3LP8nxMd7SilvPDPucc
 B4PJ52TGqHuQtqSX7TAbztXPqOd5cTzHmiOZ8+f06z0sNZ2EMcxryZHzLGHVEf8aXdD8n2Mvmz
 /gHdPigXEDIUGO1I+X6ifINh/Hf4uHxkpq/8gzwJUwoxeJeUnBKjf/Ix084NZ9GIiUynmlLqja
 QmQ=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160123499"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:25 +0800
IronPort-SDR: 1Le3XEoOzsZ41jSEL9N3AzQTsj4Y7GBOGsK0fkklnl/e0zF9/wkH+QcpWYG5/I05zaRDC4aVWr
 N8Cv5qyMxh4obrkh+XiHOIgmhHqsXlCs6KlRWZMZN2VBmXE7brGd1KbpQyJbPsHOVyCZbHxZ1C
 iMn5ZBDOPS0Lcw1I6K+XZioFLsLG/bzaVw8ueas1iGnzdt7TzPb+Iu5XfR7s06Jr8YohENvC0W
 6DowI0GLbSrOMkRXgxx3zZg3iRbvMdNoGbofmWdLDADzm/Izdwlk7sS1r8JCgL0rOpPck+pEsX
 VZmlFcDj3xb/I6WVKOluHIPv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:53:09 -0800
IronPort-SDR: S6ajHTdfHsPeyAfPsdADVGMlT1Nv2GamWOcI84kDq7O5r2a8IAjxdBcg5BGRW2GzS7PIesKb0i
 KXsaf8DJ5z3DVRDkGhUdpD3kUXVmqdJEtPuU8Hb3tD1nFjmJJjZ6fEask5E4DKnfAmj1r8RO6i
 N2w7I1CvjjH+u6/Ono0+qKMnoty8A0CTIBmDkjpK51zwUbNQU/aA/1eBHPhEZAPlgb/ifKcuZ+
 RqaNfZiDkN9ejeHPubSrWw3HHLqAeDHAaZN8f6PNs100pgjE49YM6zMedIQZPmSv/rspE6n16E
 p5Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:26 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 07/14] nvme-core: add helper to init ctrl subsys quirk
Date: Tue, 16 Feb 2021 16:10:25 -0800
Message-Id: <20210217001032.25741-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191126_305700_5E4F5338 
X-CRM114-Status: GOOD (  17.18  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_init_identify() has grown over the period of time about
~200 lines given the size of nvme id_ctrl data structure.

Just like the tail of the function it has small helpers to initialize
the independent fields that needs some extra checking, add a new helper
nvme_init_ctrl_subsys_and_quirks() to initialize ctrl subsystem and
quirks.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 43 +++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 77f79a2a396f..4a59a46193e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3057,6 +3057,32 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 	return 0;
 }
 
+static int nvme_init_ctrl_subsys_and_quirks(struct nvme_ctrl *ctrl,
+		struct nvme_id_ctrl *id)
+{
+	unsigned int i;
+	int ret;
+
+	ret = nvme_init_subsystem(ctrl, id);
+	if (ret)
+		return ret;
+
+	/*
+	 * Check for quirks.  Quirk can depend on firmware version,
+	 * so, in principle, the set of quirks present can change
+	 * across a reset.  As a possible future enhancement, we
+	 * could re-scan for quirks every time we reinitialize
+	 * the device, but we'd have to make sure that the driver
+	 * behaves intelligently if the quirks change.
+	 */
+	for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
+		if (quirk_matches(id, &core_quirks[i]))
+			ctrl->quirks |= core_quirks[i].quirks;
+	}
+
+	return 0;
+}
+
 static int nvme_init_identify_transport(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
@@ -3151,24 +3177,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
 
 	if (!ctrl->identified) {
-		unsigned int i;
-
-		ret = nvme_init_subsystem(ctrl, id);
+		ret = nvme_init_ctrl_subsys_and_quirks(ctrl, id);
 		if (ret)
 			goto out_free;
-
-		/*
-		 * Check for quirks.  Quirk can depend on firmware version,
-		 * so, in principle, the set of quirks present can change
-		 * across a reset.  As a possible future enhancement, we
-		 * could re-scan for quirks every time we reinitialize
-		 * the device, but we'd have to make sure that the driver
-		 * behaves intelligently if the quirks change.
-		 */
-		for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
-			if (quirk_matches(id, &core_quirks[i]))
-				ctrl->quirks |= core_quirks[i].quirks;
-		}
 	}
 
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
