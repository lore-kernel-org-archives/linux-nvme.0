Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 22:37:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572BC64EAA
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 22:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572BC64EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OEknjejOzIpFxRnLF90dXm/UYOH/EDpVJCkBYV5WUno=; b=UVChBHnbsLhb53UIck8f0mutWX
	EqUikPv3XTCFmoWiN+7M014GF77JJYSgiCHy2QdaIea+0+s1GY2FBPaYhkLc7qxE/RzUcLc+Z+kD0
	DLLin2TQ3BRJjap+5r0hbUNbmbxuqShUaAgOtrcLOOPjQLOQJa/LGcoF1Uc6rKfzQLNwsue7Wr0CR
	ghYnB8sBuLfIBQ9Z+GpZ5HAGfgaWHg+AgQGrQufsSv453YmVZE3mldRoVwYdwgCoowZkym+XTUHCo
	5yQ7n4bPwxvq7v09lLMCuzLwnQ0MGEkssa/xflHt/YHh3OJXdhusfM3KyCZGb8YZ5JSh/MXMdwnLY
	wmtMoEyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6hpB-0007D0-JO; Mon, 01 Feb 2021 22:37:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6hp8-0007CY-52
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 22:37:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612219048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4OZTOIXFoqCw1+s3LRH+hjNLAc3YKiq97W46jjpZAWQ=;
 b=CDiMpFr6xYx0mHKixTdx06j/BTfToq9ks9NEAtnbGwtIXgzL9cd3wZK5xQr7HCiv5M9iNY
 45iacjsu4u9n3X5B7nbdRvMbOYDlQYDwVZsi0RochZPCT9EU2d6A79jsxwy3GX4rDkprAL
 pamZg/rCL4IOPIFN6UOC5VbjDAagVts=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0B858ABD6;
 Mon,  1 Feb 2021 22:37:28 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Date: Mon,  1 Feb 2021 23:37:13 +0100
Message-Id: <20210201223713.15243-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_173734_421452_54532310 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

While a controller is still connecting, ctrl->subsys is NULL and
thus reading the controller's "subsysnqn" sysfs attribute returns
"(efault)". This happens all the time when user space processes
"add" events for NVMe controller devices.

Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
if ctrl->subsys isn't initialized yet.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..5d901dd0098b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3538,8 +3538,16 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 					 char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	char *subsysnqn;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
+	if (ctrl->subsys)
+		subsysnqn = ctrl->subsys->subnqn;
+	else if (ctrl->opts && ctrl->opts->subsysnqn)
+		subsysnqn = ctrl->opts->subsysnqn;
+	else
+		subsysnqn = "unknown";
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", subsysnqn);
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
