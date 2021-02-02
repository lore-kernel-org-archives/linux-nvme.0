Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E11C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:00:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2DF64EC5
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2DF64EC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CkpOGx23lrdzQdhWuqgNU2+hCL/iUnz6NR2523rZozo=; b=lWj3a6HxgFz7nx6TI4RT62JIO8
	K6WY3nsyyximS7t1jyRsTQU3GhMG2KFuulpT/WuhNWRevd6Y6h5ZW5bV3pnL848khTTKD1UB8oqbk
	mhBhunNUTzQ9bodIzjEI+o3JxAZURJJtVLaFR2mHehyzrra4KzSSfc4UvcHXpj4v5VJ2C94xCHmrn
	wIHsGAK4r0qzKAeRDPQcrpNqzRgDJHza2uAdlVoBBfKKunfRpWPcUQ/V/y47DRdDQ/THqwOfVw9G8
	NZXrwI3dTP3Ki8nX6GtE6Dmnbdt+B2kmYULC09tGhLgSX+eyicEvzKmKVq8GffdWKE5Oy/EH3ZGzU
	GLBelzjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6k34-0000S6-WD; Tue, 02 Feb 2021 01:00:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6k32-0000Rm-63
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 01:00:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612227601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WdeMNI5FBD7nvgfmhop/DMNCiF/w+DeIGLtZBQgmX1Q=;
 b=AxUUlDkOSQi4iLFYsmR96Gf6g6tHkMGXKEKEVAJy2n6UzB5u20Ol8I99nZc9ENbYbzrdLf
 e3J0D11lmXOGFj/P2de+cD9RipN7tpEn3q7M+hGWIY+5fM0VcMOVPMTCFq0/lDKDUI/W+5
 1OFp6QAwGHweEgiiUUYj/XYfqsDOYIQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 799C1AD3E;
 Tue,  2 Feb 2021 01:00:01 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Date: Tue,  2 Feb 2021 01:59:51 +0100
Message-Id: <20210202005951.26614-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_200004_603772_F5654608 
X-CRM114-Status: GOOD (  13.68  )
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
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..8b0fc4a07b31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3538,8 +3538,14 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 					 char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	char *subsysnqn = "unknown";
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
+	if (ctrl->subsys)
+		subsysnqn = ctrl->subsys->subnqn;
+	else if (ctrl->opts && ctrl->opts->subsysnqn)
+		subsysnqn = ctrl->opts->subsysnqn;
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
