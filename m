Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F7DC5ACB3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oqXT9nkNr0lFc+cGuj2v97f69qIZmIOWeUTda2QHW/g=; b=jC/Q2jb3lTdOsozWsG0au0QiNa
	3N5E+/Q6cecndjkFL3r5i/j3lLUZoVj+RYeO1rsfqUfFfC7AtRtoP2DPxaSCLbk2o6nCeHYHlgNNw
	BOrtO+HaVtOUKFyJDxeHOHA3To42tq4JmlzAFU9oCA/r6xjhMDNfy6nJxaq/ytqoRfeH4nXWdoKfc
	gT4uyVq6K40vIczR3kunuSI7WjtLHK4ZAbgOzSifNq1yOpjY5aQL7tdnOpetMfseLMckZJMkifr3P
	KsW1wQdNLx373srnLWB/WP4sjnrJYhFLIOy/TUzG5wStVeXXxf+KrBdfOQcso+PPIylyXRBa0te+x
	VkZrnetg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Lh2-00FxUG-1q;
	Tue, 21 Nov 2023 08:01:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Lgy-00FxT7-2a
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 08:01:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 30A0E1F8AB;
	Tue, 21 Nov 2023 08:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700553666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oqXT9nkNr0lFc+cGuj2v97f69qIZmIOWeUTda2QHW/g=;
	b=G3fuBeWx5Uc/qLbJqGb6Qy4+Xu3TDXY+iYn5WUAvWATXiFte5hMhHijtAiLzT5FJVZy5Bd
	BmtdQAA+N1SimTasiCb0rrMfzflU9rwVXNJF+HWr+gc47WEHqMRA7G77+V/XrMmZGEXWwA
	pzaEsYctqgNsGHtvZRUvIPUvhn2qIec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700553666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oqXT9nkNr0lFc+cGuj2v97f69qIZmIOWeUTda2QHW/g=;
	b=ASTM6qAb8NZ+W48hjQcktW4ZAjuDqDbIZuW/fAJoHAluLB84Uz3Zd9orzqjusjRdkwZAJN
	2+HKWmRHtC8WBIDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 310E32C149;
	Tue, 21 Nov 2023 08:01:05 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 583D751ED755; Tue, 21 Nov 2023 09:01:05 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: move nvme_stop_keep_alive() back to original position
Date: Tue, 21 Nov 2023 09:01:03 +0100
Message-Id: <20231121080103.23355-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [18.99 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 30A0E1F8AB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_000108_989172_ED649916 
X-CRM114-Status: GOOD (  15.99  )
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

Stopping keep-alive not only stops the keep-alive workqueue,
but also needs to be synchronized with I/O termination as we
must not send a keep-alive command after all I/O had been
terminated.
So to avoid any regressions move the call to stop_keep_alive()
back to its original position and ensure that keep-alive is
correctly stopped failing to setup the admin queue.

Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/fc.c   | 19 ++++++++-----------
 drivers/nvme/host/rdma.c |  1 +
 drivers/nvme/host/tcp.c  |  1 +
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd28e6b6574c..46a4c9c5ea96 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -482,7 +482,6 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
 
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(ctrl);
 	if (ctrl->admin_tagset) {
 		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
 				nvme_cancel_request, ctrl);
@@ -4355,6 +4354,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
+	nvme_stop_keep_alive(ctrl);
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 49c3e46eaa1e..9f9a3b35dc64 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2530,12 +2530,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * clean up the admin queue. Same thing as above.
 	 */
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
-
-	/*
-	 * Open-coding nvme_cancel_admin_tagset() as fc
-	 * is not using nvme_cancel_request().
-	 */
-	nvme_stop_keep_alive(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
@@ -3138,11 +3132,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
-	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
-		ret = -EIO;
 	if (ret)
 		goto out_disconnect_admin_queue;
-
+	if (test_bit(ASSOC_FAILED, &ctrl->flags)) {
+		ret = -EIO;
+		goto out_stop_keep_alive;
+	}
 	/* sanity checks */
 
 	/* FC-NVME does not have other data in the capsule */
@@ -3150,7 +3145,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
 				ctrl->ctrl.icdoff);
 		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		goto out_disconnect_admin_queue;
+		goto out_stop_keep_alive;
 	}
 
 	/* FC-NVME supports normal SGL Data Block Descriptors */
@@ -3158,7 +3153,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		dev_err(ctrl->ctrl.device,
 			"Mandatory sgls are not supported!\n");
 		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		goto out_disconnect_admin_queue;
+		goto out_stop_keep_alive;
 	}
 
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
@@ -3205,6 +3200,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 out_term_aen_ops:
 	nvme_fc_term_aen_ops(ctrl);
+out_stop_keep_alive:
+	nvme_stop_keep_alive(&ctrl->ctrl);
 out_disconnect_admin_queue:
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a7fea4cbacd7..6d178d555920 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1080,6 +1080,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 destroy_admin:
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6ed794815517..ddcd23fb8b75 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2237,6 +2237,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_tcp_destroy_io_queues(ctrl, new);
 	}
 destroy_admin:
+	nvme_stop_keep_alive(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	return ret;
 }
-- 
2.35.3


