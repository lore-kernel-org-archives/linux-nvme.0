Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA36CA0FF0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+H452fgK8KM6NSesi2Rbgkwu04/R6e4ckH4gbHELSbA=; b=qb/heAYRtZGsaW9xEwvzZZIz6H
	L9HiQqJTmB3mkfqDlDdiwPcf2mRtey5/oxJIdAXBhZqch/1viYQrn65UbrSP8nzYDKL8avixD/MkJ
	2xHlXCriby1bU16RVE9GWEj3LTmzbsLds+thiwi0qqHfg5pKAtw227+7VHCn0OMEmwGv2wazmao4x
	foJ22ePSwJBqn6RMxrDtX258NtgK6OxK2LmDcDc4FKbl9zTL9rZ2Lb+f5IySP95twamY6axaKYeZr
	5fZZ6XlrDUD+S0Mtd4x9w/Zl8GP9s0czjSQvwjGcb5EbfWzwSAHTqaMY0bk4cIAyqeVD3vzU2yswX
	XnRQIGyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us4tM-00000006l1h-0MdG;
	Fri, 29 Aug 2025 19:36:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us1Aa-00000006DrT-3UlK
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:37:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4462B601BC;
	Fri, 29 Aug 2025 15:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2FEC4CEF0;
	Fri, 29 Aug 2025 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481860;
	bh=1D+KKEVMrSYTaxz25aM5XfBdCuC1VdSpDaU+c8DEwFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R6q5PNE+cEAEH+7JIhevtWU+ym8Utaq6iEFv5FWmZ+cSV7dBwzkXl2JUC9U8ujVBS
	 A1/IvYT5RvY3xbiWgP7kypXeoVaPYGRV6B87iFlJr+4wZGIaqIPZBZbGZFbf/rvWqf
	 RfhK55t1LINEALEbKziQ/dT0DoogSbhgG0dIj2GCNjREfM45XMZpSHe4/84FLC8GE3
	 oZCSWibHTXUqhwdpBly9Hf25/CnncwuqOecUx6Penb7+j9zXtPvnBrgXlzCujynP7P
	 GHdpSQQeAOzo7BuF7EFk8vTBPxFfcfXjBCIKlt2XxM3rTQFA2oOTvF4wNhJ3Ndph8S
	 I++CPRlY+nXxg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:37:27 +0200
Subject: [PATCH v3 3/4] nvme-fc: refactore nvme_fc_reconnect_or_delete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-nvme-fc-sync-v3-3-d69c87e63aee@kernel.org>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead using if else blocks, apply the 'early return' and 'goto out'
pattern. This reduces the overall complexity of this function as the
conditions can be read in a linear order.

The only function change is that always the next reconnect attempt
message will be printed.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e6c79bf0bfd3884867c9ebeb24771323a619934..5d9e193bd2525ae1a2f08e2a0a16ca41e08a7304 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3249,7 +3249,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	struct nvme_fc_rport *rport = ctrl->rport;
 	struct nvme_fc_remote_port *portptr = &rport->remoteport;
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
-	bool recon = true;
 
 	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
 		return;
@@ -3259,38 +3258,43 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
-		recon = false;
+		goto delete_log;
 
-	if (recon && nvmf_should_reconnect(&ctrl->ctrl, status)) {
-		if (portptr->port_state == FC_OBJSTATE_ONLINE)
-			dev_info(ctrl->ctrl.device,
-				"NVME-FC{%d}: Reconnect attempt in %ld "
-				"seconds\n",
-				ctrl->cnum, recon_delay / HZ);
-		else if (time_after(jiffies + recon_delay, rport->dev_loss_end))
-			recon_delay = rport->dev_loss_end - jiffies;
+	if (!nvmf_should_reconnect(&ctrl->ctrl, status))
+		goto delete_log;
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
-	} else {
-		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
-			if (status > 0 && (status & NVME_STATUS_DNR))
-				dev_warn(ctrl->ctrl.device,
-					 "NVME-FC{%d}: reconnect failure\n",
-					 ctrl->cnum);
-			else
-				dev_warn(ctrl->ctrl.device,
-					 "NVME-FC{%d}: Max reconnect attempts "
-					 "(%d) reached.\n",
-					 ctrl->cnum, ctrl->ctrl.nr_reconnects);
-		} else
+	if (portptr->port_state != FC_OBJSTATE_ONLINE &&
+	    time_after(jiffies + recon_delay, rport->dev_loss_end))
+		recon_delay = rport->dev_loss_end - jiffies;
+
+	dev_info(ctrl->ctrl.device,
+		 "NVME-FC{%d}: Reconnect attempt in %ld seconds\n",
+		 ctrl->cnum, recon_delay / HZ);
+
+	queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
+
+	return;
+
+delete_log:
+	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
+		if (status > 0 && (status & NVME_STATUS_DNR))
 			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: dev_loss_tmo (%d) expired "
-				"while waiting for remoteport connectivity.\n",
-				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
-					(ctrl->ctrl.opts->max_reconnects *
-					 ctrl->ctrl.opts->reconnect_delay)));
-		nvme_fc_ctrl_put(ctrl);
-	}
+				 "NVME-FC{%d}: reconnect failure\n",
+				 ctrl->cnum);
+		else
+			dev_warn(ctrl->ctrl.device,
+				 "NVME-FC{%d}: Max reconnect attempts "
+				 "(%d) reached.\n",
+				 ctrl->cnum, ctrl->ctrl.nr_reconnects);
+	} else
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: dev_loss_tmo (%d) expired "
+			 "while waiting for remoteport connectivity.\n",
+			 ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
+					   (ctrl->ctrl.opts->max_reconnects *
+					    ctrl->ctrl.opts->reconnect_delay)));
+
+	nvme_fc_ctrl_put(ctrl);
 }
 
 static void

-- 
2.51.0


