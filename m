Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B24C77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZ0cClgnu8/kTFVRND7u+HMm+91w0te/Vhixjfj7uYY=; b=vrCJhbpvzobSoh1hMCxwDAQhsp
	MCceuxUBn6iPTAJ9YIjnVgprahLo6mHnbL/4EUemRSGuPwzb95NCTyd6dGEusbND/sgyRFyEQZxAY
	4jTQMi/40jBG80dECEIEtyR42oSBWXkEj9tdRkLnMl4oN60U8An8zoT2Pfz+i/rtnK3c2AYL2EQ8T
	1MCd04kqUhwn/E1T63942k0xVAvC0nRob0AG8/RlM087yWukAQNucLjBHX1rYMdP6SJ3Zvvx29C8U
	EMqBld8jpa+MAtNVRnYYtMuc4skH507bPoOAz3IjGKEv3AxoSqLnYApwiDSLT7/A3FdDueHtFEVYW
	BxcyEyaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puV1e-007Dqt-16;
	Thu, 04 May 2023 09:13:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puV1U-007DfG-1D
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 09:13:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEA66209AB;
	Thu,  4 May 2023 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683191585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ0cClgnu8/kTFVRND7u+HMm+91w0te/Vhixjfj7uYY=;
	b=Us//lxegiQ+pNUvT0WoLCczQmKTkH6RAwHncUN5IfoCVQnTgp+9WGZF8XJr/bgIK6lJQP/
	tw1FhR22z35sL/EB+DMcg8CMf6JY9GbY38AvUJMbhqLatlWF6sJpvOhaPsterX7JEg7bU9
	Ff2t/VaHiODUS0XVjjDKUaXr3NodOZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683191585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ0cClgnu8/kTFVRND7u+HMm+91w0te/Vhixjfj7uYY=;
	b=DHe+CDDNgUcq91cspWZJQ0DTo81yecLB9XtVMmP6Xug8X8HL56VgiGAuSQSUnNq6HriJBx
	MLo0BCDbyyWaZyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0B6413444;
	Thu,  4 May 2023 09:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wdJQJyF3U2TgTwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 4/9] nvme-rdma: use error and connect work from nvme_ctrl
Date: Thu,  4 May 2023 11:12:54 +0200
Message-Id: <20230504091259.29100-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504091259.29100-1-dwagner@suse.de>
References: <20230504091259.29100-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_021312_572633_E7906BF3 
X-CRM114-Status: GOOD (  12.95  )
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

Use common data structures from nvme_ctrl so that we are able to use
them in fabrics.c later.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a78c66278b19..b0ab5a9d5fe0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,12 +106,9 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -1036,8 +1033,8 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	flush_work(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
+	flush_work(&ctrl->ctrl.err_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -1069,7 +1066,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		nvme_delete_ctrl(&ctrl->ctrl);
@@ -1167,8 +1164,9 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+	struct nvme_ctrl *nctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	++ctrl->ctrl.nr_reconnects;
 
@@ -1190,8 +1188,9 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+	struct nvme_ctrl *nctrl = container_of(work,
+			struct nvme_ctrl, err_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
@@ -1217,7 +1216,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
+	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
@@ -2369,9 +2368,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-- 
2.40.0


