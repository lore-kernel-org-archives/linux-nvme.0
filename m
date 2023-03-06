Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C0FC678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xuw8L5gMKWD3Gy518lfad5yBrttUWE2LmCxNRMB48mA=; b=i3h94/5qXe7QAfAlkkxRYfKvd5
	ON+2MWut4l3cDca+iJcO47LeEhPm7lSJr5OLvvGA6y6PCrfYF71dzyqKo6rdNxKcUft/JH0yrtXLU
	ClcQZtllQnEg55qLw1lwse9yYg/9j1+mArmaBffpXXqT5ZaQdHuotoq2+Ewq+A6L9Xwja1RrYzoVy
	wwRk1OzfQs6mvcK7WvCV4N/+Noa81Mxj5txb6D5U5/vLgjXBJiUUtKYdCmGQn22mvA2uhz2gGH+NY
	d1+QpNZVu0FWZEPKeBdPRfdOCiVDc31EgQbpwzzQQb4HcEexfrxUWtVsTMaegmDRKU5mkDPn1qNj8
	QnPYE5IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7DH-00C66Y-VT; Mon, 06 Mar 2023 09:33:00 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7D8-00C62n-N4
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 823881FDE3;
	Mon,  6 Mar 2023 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xuw8L5gMKWD3Gy518lfad5yBrttUWE2LmCxNRMB48mA=;
	b=j02a2kGmUqDk1iZiLzoJ4Z021FJKvQySAZHKtQiRf5MDVQBIO+16hTsZ0M4NPgHdvnBWq4
	tFQ9xgUy5aMAES/HmQeHA4+mO9rYR7u+hygXeBdy6IndMcRASRCPRJTcr2KNGfP1CJyH4O
	iRA/P6bK2SXm4Jn2+z266H+GIsZ5gyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xuw8L5gMKWD3Gy518lfad5yBrttUWE2LmCxNRMB48mA=;
	b=nhJYYnTXC7cQUfR5L2uoH7ratLKIhRRbYxMfQOiFWxXSfEcTcjPmQ6h/pNjKr5UzzPr0cj
	S9V+elyMrymx4eDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6992013513;
	Mon,  6 Mar 2023 09:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id k2fEGUGzBWR6YAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 4/6] nvme-rdma: use error and connect work from nvme_ctrl
Date: Mon,  6 Mar 2023 10:32:42 +0100
Message-Id: <20230306093244.20775-5-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306093244.20775-1-dwagner@suse.de>
References: <20230306093244.20775-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013250_921560_910F7B8A 
X-CRM114-Status: GOOD (  12.47  )
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
index d070d84b204e..cc9a019381f8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -107,12 +107,9 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -1041,8 +1038,8 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	flush_work(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
+	flush_work(&ctrl->ctrl.err_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -1074,7 +1071,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		nvme_delete_ctrl(&ctrl->ctrl);
@@ -1172,8 +1169,9 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+	struct nvme_ctrl *nctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	++ctrl->ctrl.nr_reconnects;
 
@@ -1195,8 +1193,9 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+	struct nvme_ctrl *nctrl = container_of(work,
+			struct nvme_ctrl, err_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
@@ -1222,7 +1221,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
+	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
@@ -2376,9 +2375,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
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
2.39.2


