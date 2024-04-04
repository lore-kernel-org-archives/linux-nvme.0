Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFD9CD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fSbXXcSSklifC3qRuVfvgMQabPrygTQ76B8nYgKM5vk=; b=K8Pk1sVBzhaBoKuypMYrlSoTVu
	I7yW255aEvCyPXKd3wmqI/SLkbdEKmeVHbOO9S93YbJZtt+BWW52l8PzwXSxazJ62iMQmMBbKX/Lo
	d3r9pqa+c8ldd1NiqGmxJ2XVBqCcTAzRBVFjEinhmKUz6FswcswgKrtWUCumic/YrLq6gi5nLrGp2
	xL5tJTvBoU1P99rtEMPnttjP2e5o6lCkuY5EyvlGsQUJJT8VreElyuCT1xajvlAS5WBParZraHtor
	KMO6X8sHs2NnCG8Z+S6K5b+nl1FLaZnKgd1WyVmK8awdx4P37w2ZUEDTGAx19CGU+JQA+kU530pzH
	wJfwqepw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPHE-00000003IGO-1Kvk;
	Thu, 04 Apr 2024 15:45:20 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPH5-00000003IAj-31r2
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 15:45:14 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F2FD37CFF;
	Thu,  4 Apr 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE1D139E8;
	Thu,  4 Apr 2024 15:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HZrYBQXLDmYOIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:45:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 4/5] nvme-tcp: short-circuit reconnect retries
Date: Thu,  4 Apr 2024 17:44:59 +0200
Message-ID: <20240404154500.2101-5-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404154500.2101-1-dwagner@suse.de>
References: <20240404154500.2101-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2F2FD37CFF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_084512_017538_7009F3F5 
X-CRM114-Status: GOOD (  17.87  )
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

Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
association was established and we have received a status from the
controller; consequently we should honour the DNR bit. If not any future
reconnect attempts will just return the same error, so we can
short-circuit the reconnect attempts and fail the connection directly.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 17 +++++++++++++++++
 drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 882967365108..654d8d1a4d29 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -701,6 +701,23 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }
 
+/*
+ * Evaluate the status information returned by the LLDD in order to
+ * decided if a reconnect attempt should be scheduled.
+ *
+ * There are two cases where no reconnect attempt should be attempted:
+ *
+ * 1) The LLDD reports an negative status. There was an error (e.g. no
+ *    memory) on the host side and thus abort the operation.
+ * 2) The DNR bit is set and the specification states no further
+ *    connect attempts with the same set of paramenters should be
+ *    attempted.
+ */
+static inline bool nvme_ctrl_reconnect(int status)
+{
+	return status > 0 && (status & NVME_SC_DNR) ? false : true;
+}
+
 /*
  * Fill in the status and result information from the CQE, and then figure out
  * if blk-mq will need to use IPI magic to complete the request, and if yes do
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..7e25a96e9870 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2155,9 +2155,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
+		int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+	bool recon = nvme_ctrl_reconnect(status);
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -2165,13 +2167,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
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
@@ -2252,10 +2255,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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
@@ -2268,7 +2273,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2315,6 +2320,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2328,14 +2334,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
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


