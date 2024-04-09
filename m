Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6875C67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxdJHldvtb4AJ69Nd3nVQlKfguhjZz+w+tWOzCDW70o=; b=gjRDDNJSJ4tSSZ8L0D4QMTzeTO
	O6YAsqoy84F8z3t4Bt/JPIKjiwXeFPwRdFsK73/iMmfcBqxpbjYzCX6QIluwLJVj9k0Nik4IMZVmH
	/JfQfr0k91zB2ZhD6T6y4Pe0xz/vEuVG8JZs+zT1twIlBDbYLP6V4BcAghcF5P3481CTGRN5G5sap
	FsbyJ2BgSz7Xo87pHSJ0klEHGyS2Jw2pRiY092CCg531Inf+oeFrDDSTFRbaV63sKCAtRQPgrixQg
	x5CLvUFqvVpVcrGGCa0Oo+6iyvGC0lsFsXlU6jbIZ2v6lmj0NI8RdzYcj2q26z0EWuTMbmV8j/95W
	0TXQVWYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7tW-00000001Egw-0Vtl;
	Tue, 09 Apr 2024 09:35:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7sy-00000001EOp-2uf5
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 09:35:35 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57610338F4;
	Tue,  9 Apr 2024 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxdJHldvtb4AJ69Nd3nVQlKfguhjZz+w+tWOzCDW70o=;
	b=GR+6BA+gt9jzxRwFF7o8DvJFlk8Xu6fFtvP1XiGm9YYqVaOCAiV8jQqVNhI6M6HSivumeV
	FQ0NAFzbIRdHXkOp5HqZFkW3g7JzggTP1rdwsbIAAY+ioErA1fFKHYukmEskQELeLlvjia
	6htsbGFU68CzfyVDQ93EMLRnTZBnc0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxdJHldvtb4AJ69Nd3nVQlKfguhjZz+w+tWOzCDW70o=;
	b=MB/x5k7pmkVo1xFt5zRInBA02DNqTJPVPNuh1sD7MH8/Rtb/WI6e/VPa8GF7xkjS0+A1v3
	apXo0Cy4B2vaLcBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxdJHldvtb4AJ69Nd3nVQlKfguhjZz+w+tWOzCDW70o=;
	b=ODI1VUlGmTuPKcVNfvRHUuDfcbkHhS385L1Ao0/029+UBVF5wHvJwQOmGM2RbaWGXmmCz5
	o8p57RB3jMdH8MwQvl75NDmM2KfxuI3xMktkearGPr1HALVQmcjKLLbS+yGvLT9m7O5eIc
	TJTseJ85tW1ik+7+v5bKEy5pK9baJ2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxdJHldvtb4AJ69Nd3nVQlKfguhjZz+w+tWOzCDW70o=;
	b=AmGbopbocLhJmRoSqOd8TEIu6PESOLfhwXcSGYB8mxQUSL0quDPS01j0wPDvDUrVOMTa0B
	LK2jI0en6VIvHHDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B631332F;
	Tue,  9 Apr 2024 09:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AWZSD9ULFWatRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Date: Tue,  9 Apr 2024 11:35:08 +0200
Message-ID: <20240409093510.12321-5-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>
References: <20240409093510.12321-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_023524_967312_A35A2A4B 
X-CRM114-Status: GOOD (  14.89  )
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

Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
association was established and we have received a status from the
controller; consequently we should honour the DNR bit. If not any future
reconnect attempts will just return the same error, so we can
short-circuit the reconnect attempts and fail the connection directly.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 366f0bb4ebfc..53d51df26ae1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -982,9 +982,11 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl,
+		int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+	bool recon = nvme_ctrl_reconnect(status);
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -992,12 +994,14 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
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
@@ -1104,10 +1108,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
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
@@ -1120,7 +1126,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
@@ -1145,7 +1151,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -2169,6 +2175,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -2179,14 +2186,15 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
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
2.44.0


