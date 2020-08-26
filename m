Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAA8C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 17:53:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9CF2080C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RTXHkWXh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD4kkNie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9CF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=onfnIyQlMN9fa736USHyitRbh/IFRQd2ekftQieG3C0=; b=RTXHkWXh9VpFNY+6D6zLLzTdrm
	lLsEkDtXih7RJRgFNlkH/TyhDZ16n94WNYOEGqEfEYQuSLzytYlQ0DcMAKFSf0V2XdG1m5yb24yNq
	71mfxVFOHD4zfmKMLxzBDrduPgB41tzEvZ6/0ot2nkI2Cnu8bG6u+Oz2vKxmptkK6mqUFa9mr5/Qv
	4rufvV4o0vkDdH0iYZjIvcDTIHOicrJiUzkdk4txd55odmulH/LfIBaUYZJcrfhGYOGTtATPGc0Gh
	rUYq7OcR7+sBX+4oZMUy/1vWJHvuZKlccph8tRqHqAQaLpWwmar77pQEuMa9RQ3erDTZ+0wTJDOZ0
	0umdSPHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAzbi-0007wg-K6; Wed, 26 Aug 2020 17:53:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAzbe-0007w8-Tx
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 17:53:07 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5A6920737;
 Wed, 26 Aug 2020 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598464386;
 bh=MXBuBhtAe49h3N+hVCitkYxwSVjUHCejMblnLOW5cn8=;
 h=From:To:Cc:Subject:Date:From;
 b=qD4kkNieoJ1LqSkLXzcPghfK9rxR9kkDsozYaz3MijmHMqplYXCqe8Oi21sQy/U/s
 SIkAo9ABe9+ajoHJBN5y7QHQdCYfdxWXTa82eNFwhCDkbgkf72YYFtvwLbbwG6wVUc
 og1cD+LOYDhaQ+FYOAL1hAeSq/Ii9SSkCe8D4KO4=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme: fix controller instance leak
Date: Wed, 26 Aug 2020 10:53:04 -0700
Message-Id: <20200826175304.2151626-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_135307_209792_DFE52218 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the driver has to unbind from the controller for an early failure
before the subsystem has been set up, there won't be a subsystem holding
the controller's instance, so the controller needs to free its own
instance in this case.

Fixes: 733e4b69d508d ("nvme: Assign subsys instance from first ctrl")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942fc64eb..be7c609b3d07 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4390,7 +4390,7 @@ static void nvme_free_ctrl(struct device *dev)
 	struct nvme_subsystem *subsys = ctrl->subsys;
 	struct nvme_cel *cel, *next;
 
-	if (subsys && ctrl->instance != subsys->instance)
+	if (!subsys || ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
 	list_for_each_entry_safe(cel, next, &ctrl->cels, entry) {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
