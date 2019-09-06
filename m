Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF4C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 18:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A1020838
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 18:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cg7zEJBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A1020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ze0cWubCFjokH9oInK18vQrQIDR8HEZEXDWMk08NRgM=; b=Cg7zEJBYPG7SdkmnT7jqgDLENz
	p8iukxUY+efxueCRgB24wYhey6/uEetPwptEL03LLXzbTptVT01xjLyTdJ/2TJIZpIlFpuNLsvQdY
	3vRd/kXgAhHrG3uLS0hcLz65W3P41OQz3ZgACDRmwneMmDWbf9pnarq3XIFDsjwJspWP/feKM8gdj
	6voqxwMWUpaKTbp0UPQcrJDnj4rCK6qVL7cKr+IkPAoTm3axzPRMRZF+ho5htOy+sIm2QkYnU7AX0
	2rQS4ZEHo19MKdEHyQxtLag41t8TqcEntVXxbgRDBnE5SAUY4vrZAM9U8fE72yp4TDCK1x/RjabwX
	9zqcFJFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Ij6-0001hs-KZ; Fri, 06 Sep 2019 18:12:52 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Iiq-0001O2-6g; Fri, 06 Sep 2019 18:12:36 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v5 2/4] nvme: enable aen regardless of the presence of I/O
 queues
Date: Fri,  6 Sep 2019 11:12:32 -0700
Message-Id: <20190906181235.20365-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906181235.20365-1-sagi@grimberg.me>
References: <20190906181235.20365-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

AENs in general are not related to the presence of I/O queues,
so enable them regardless. Note that the only exception is that
discovery controller will not support any of the requested AENs
and nvme_enable_aen will respect that and return, so it is still
safe to enable regardless.

Note it is safe to enable AENs even before the initial namespace
scanning as we have the scan operation in a workqueue context.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b19f9153161..23cc0fd6f667 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1200,6 +1200,8 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	if (status)
 		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
 			 supported_aens);
+
+	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
@@ -3789,10 +3791,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->kato)
 		nvme_start_keep_alive(ctrl);
 
+	nvme_enable_aen(ctrl);
+
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
-		nvme_enable_aen(ctrl);
-		queue_work(nvme_wq, &ctrl->async_event_work);
 		nvme_start_queues(ctrl);
 	}
 }
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
