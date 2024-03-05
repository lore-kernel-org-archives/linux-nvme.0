Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1718C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UvsGLk8b6qDgUt88sZXK3lmITZIAGLFxi1Lnbm2V6E=; b=QTyc3QbHret3aqUUaoTs72UcPj
	SqK2KApsrMU6oTIUVUePA1E5Mz5pgVdTOX3k7NIsNIFBXlGrF2Ma+HoudzkwlAB6ZpbVOjI0V2ICM
	BmFVtDeb2VvKd8jVOquZnNxqnAWBrUgFP9siPm6cp2VfkXR9FHljj/5GdNij/+vvx31+sXdAGPUKV
	4srih09N8497GONIiVmHPfqGXfvDdSVexBDoRORguvyyX6zP3p4g2JpEWBvC7TRMTtO+6lVNnNO0C
	/YplFOWPWH8ShQ8nhfZaA1tZoDrQijthJ8y+bE9/kbGf13obSlWfqQIJtGEUX2vDQuddho5M9qreb
	TZqDSB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhPih-0000000CUQt-1D8U;
	Tue, 05 Mar 2024 08:00:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhPie-0000000CUP4-2TQ4
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 08:00:14 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 082D068351;
	Tue,  5 Mar 2024 08:00:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E937C13A5D;
	Tue,  5 Mar 2024 08:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3AxINwnR5mW9UQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 08:00:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 1/2] nvme-tcp: short-circuit reconnect retries
Date: Tue,  5 Mar 2024 09:00:04 +0100
Message-ID: <20240305080005.3638-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305080005.3638-1-dwagner@suse.de>
References: <20240305080005.3638-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 082D068351
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_000012_882340_6741A071 
X-CRM114-Status: GOOD (  15.17  )
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

From: Hannes Reinecke <hare@suse.de>

Returning an nvme status from nvme_tcp_setup_ctrl() indicates
that the association was established and we have received a status
from the controller; consequently we should honour the DNR bit.
If not any future reconnect attempts will just return the same error, so
we can short-circuit the reconnect attempts and fail the connection
directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3b20c5ed033f..f9ad5904ed62 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2149,9 +2149,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
+		int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+	bool recon = status > 0 && (status & NVME_SC_DNR) ? false : true;
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -2159,13 +2161,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(ctrl)) {
+	if (recon && nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
+		dev_info(ctrl->device, "Removing controller (%d)...\n",
+			 status);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2246,10 +2249,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 			struct nvme_tcp_ctrl, connect_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	int ret;
 
 	++ctrl->nr_reconnects;
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
@@ -2262,7 +2267,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2289,7 +2294,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2309,6 +2314,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2322,14 +2328,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.44.0


