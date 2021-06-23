Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6990BC4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 14:33:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369676101D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 14:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369676101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=grkdWfpoidk+V5zNm+fXi1L9cRy2eLrbn8jw+JCYIZI=; b=BFy5O4oUtgqYqN
	zuJ0UpX2d+Et1CjQP3iYTzzg+qOx5V3Gpb2vKiEJsSE46qjXT7KmR/ADzvtNKrbpFEpm4EK0IAdRk
	Q2rs/7ZZo42WnQlkuWYW4S1w/wl/MxLJnG4LBbcJNf2dkuOK2fl50wpYRDp/33T39+4zEOOrhx/iL
	BUDWZh7t2xIybDsyN5Pca6vMZ1Bv1Fw8buLEBHrOm7SpWC70eiA5AkvaW446fUvR17UmPH3kUGhDI
	4kOqYxqcCsGW6ITbFA7X6R1wZ6P60cegjISYllj3+kLQa9GZ9CBMT4un/v/vXacY7j+DuFSTr/4WM
	2n+9AimSuWErSJWVpwig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw3wM-00B0WX-HL; Wed, 23 Jun 2021 14:33:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw3w0-00B0TL-PB
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 14:32:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 38DDB21970;
 Wed, 23 Jun 2021 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624458774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zA6mrfkrf8yCpctLX5m620vORA1Eh2OqH/xaa7wv3M=;
 b=xb/RiQbZdgIiIGg7VT3HWOqOsFoNycxpOLp3EWPh8B31jRCwpX2fOxlg83AEvSGffOPFhr
 477wv1lhD6ZscTObDn5Q+RDy2DIcfYJnUCvHxKXwM1wY9yFoyXyj27jXPx4UcfQ4cbPxlk
 8oJkIj97q5sPi4yioMarEgeJr7VaeVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624458774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zA6mrfkrf8yCpctLX5m620vORA1Eh2OqH/xaa7wv3M=;
 b=Y5H5lwAksWN9gS80FjCdAMogBfz+Uijqkr8l8PwfyLdb4K4mqQRwvuaGXE0gnQCbPDelWT
 f4ppe+JOhG/dKOCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0A3EFA3BC2;
 Wed, 23 Jun 2021 14:32:53 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 4306D5170879; Wed, 23 Jun 2021 16:32:53 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme-rdma: short-circuit reconnect retries
Date: Wed, 23 Jun 2021 16:32:50 +0200
Message-Id: <20210623143250.82445-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210623143250.82445-1-hare@suse.de>
References: <20210623143250.82445-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_073257_035431_4E6176E3 
X-CRM114-Status: GOOD (  13.91  )
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

Returning an nvme status from nvme_rdma_setup_ctrl() indicates
that the association was established and we have received a status
from the controller; consequently we should honour the DNR bit.
If not any future reconnect attempts will just return the same error, so
we can short-circuit the reconnect attempts and fail the connection
directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4697a94c0945..92c0bdf2bc74 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1067,8 +1067,11 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl,
+		int status)
 {
+	bool recon = status > 0 && (status & NVME_SC_DNR) ? false : true;
+
 	/* If we are resetting/deleting then do nothing */
 	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
@@ -1076,12 +1079,14 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+	if (recon && nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
+		dev_info(ctrl->ctrl.device, "Removing controller (%d)...\n",
+			 status);
 		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 }
@@ -1166,10 +1171,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_rdma_ctrl, reconnect_work);
+	int ret;
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
@@ -1182,7 +1189,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
@@ -1203,7 +1210,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -2259,6 +2266,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -2269,14 +2277,15 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
