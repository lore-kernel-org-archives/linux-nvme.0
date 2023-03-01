Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575CDC64ED6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Mar 2023 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QJU+yvZV9n9apA/7iSBhNRTLTL0G0pnh4KcC4fvwM4=; b=RahHFURVWkO739qH5exf6gyAxk
	f4HvHjE3jrYZMVuR58g9SLql+mG2YBKpEiEvZw4p+YWc6vSBBKJRxZTdhEOtD82Y7PXGMgKTS25cA
	VNQKMUsK2BvGIDUW6Y8iyUxMqKQJDeSDQ96gMeo8l28cag2+m0QDesQDZM4RbjpSr09QY+2nNLa61
	E8dJjf/LfN2JZVrrYhNKOnroSfCQd1Ja5uC8tzJYasksoJY6EnfPsPWhAvzeksYGgA7eo/OCqylLz
	YpRe8+9Dxlkc5hYCN4dUu9og90fYL/Wyg7OgX4Vz1O1c3rQO3aV7b09sf79/8jEmLlAzzbZFK5JQ/
	xVq9RG9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXHoj-00FS4J-Qu; Wed, 01 Mar 2023 08:28:05 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXHoT-00FRy4-NU
	for linux-nvme@lists.infradead.org; Wed, 01 Mar 2023 08:27:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB1EF1FE16;
	Wed,  1 Mar 2023 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677659265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QJU+yvZV9n9apA/7iSBhNRTLTL0G0pnh4KcC4fvwM4=;
	b=ywDMwX6vtOCOwrfwau0jXvXz2CJBjX9s6mzW2sYrQZJTopI6KhKnAWgu78nD6nbpGjMZVn
	kj7W9OuhRG88T/urqHQLqEilRYJGh9ECea20xb+mlF3DL5Xu+JKNxKsHZNjFmj4sH2VwWh
	j+dIQ+o9Fzm6RJaWUON7lSA3QMrxLmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677659265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QJU+yvZV9n9apA/7iSBhNRTLTL0G0pnh4KcC4fvwM4=;
	b=BYHA80pL4NOzQsFtOo02X02llpW9S2JgzZ78W7XRlxT04l6Se+zDQ7mav52pQyZs4PBcU4
	iNd3MHb2yga5bKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD92C13A3E;
	Wed,  1 Mar 2023 08:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gLk/KoEM/2PfZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 01 Mar 2023 08:27:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 3/3] nvme-fabrics: move configure admin queue code to fabrics.c
Date: Wed,  1 Mar 2023 09:27:37 +0100
Message-Id: <20230301082737.10021-4-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301082737.10021-1-dwagner@suse.de>
References: <20230301082737.10021-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_002749_954525_6B719E1C 
X-CRM114-Status: GOOD (  21.87  )
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

The two transports for tcp and rdma share a lot of o common code, which
handles the controller states and is not transport specific.

The fabrics.c file contains helper functions to be used by the transport
This limits what the common code in fabrics can do. Any transport
specific allocation/initialization (e.g comand size for admin_tag_set)
has either be parameterized via the function call or we
introduce callbacks for parameterizing.

The third options is to introduce an intermediated type e.g. struct
nvme_fabrics_ctrl, but that would mean a lot of code refactoring and
restructuring just to avoid passing in arguments to functions.

The callback approach has another benefit, as it allows to add hooks to
the generic code for the driver to do allocate additional transport
specific resources.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 52 ++++++++++++++++++++
 drivers/nvme/host/fabrics.h | 12 +++++
 drivers/nvme/host/nvme.h    |  3 ++
 drivers/nvme/host/rdma.c    | 77 +++++++++---------------------
 drivers/nvme/host/tcp.c     | 94 +++++++++++--------------------------
 5 files changed, 115 insertions(+), 123 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..b09195c4a366 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1134,6 +1134,58 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	return ERR_PTR(ret);
 }
 
+int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
+{
+	int error;
+
+	error = ctrl->fabrics_ops->alloc_queue(ctrl, 0);
+	if (error)
+		return error;
+
+	error = ctrl->fabrics_ops->init_queue(ctrl, 0);
+	if (error)
+		goto out_free_queue;
+
+	if (new) {
+		error = ctrl->fabrics_ops->alloc_admin_tag_set(ctrl);
+		if (error)
+			goto out_deinit_admin_queue;
+
+	}
+
+	error = ctrl->fabrics_ops->start_queue(ctrl, 0);
+	if (error)
+		goto out_remove_admin_tag_set;
+
+	error = nvme_enable_ctrl(ctrl);
+	if (error)
+		goto out_stop_queue;
+
+	nvme_unquiesce_admin_queue(ctrl);
+
+	error = nvme_init_ctrl_finish(ctrl, false);
+	if (error)
+		goto out_quiesce_queue;
+
+	return 0;
+
+out_quiesce_queue:
+	nvme_quiesce_admin_queue(ctrl);
+	blk_sync_queue(ctrl->admin_q);
+out_stop_queue:
+	ctrl->fabrics_ops->stop_queue(ctrl, 0);
+	nvme_cancel_admin_tagset(ctrl);
+out_remove_admin_tag_set:
+	if (new)
+		nvme_remove_admin_tag_set(ctrl);
+out_deinit_admin_queue:
+	ctrl->fabrics_ops->deinit_queue(ctrl, 0);
+out_free_queue:
+	ctrl->fabrics_ops->free_queue(ctrl, 0);
+	return error;
+}
+EXPORT_SYMBOL_GPL(nvmf_configure_admin_queue);
+
 static struct class *nvmf_class;
 static struct device *nvmf_device;
 static DEFINE_MUTEX(nvmf_dev_mutex);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6e22116e139..30b7e388c8e8 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -172,6 +172,16 @@ struct nvmf_transport_ops {
 					struct nvmf_ctrl_options *opts);
 };
 
+struct nvme_fabrics_ops {
+	int 	(*alloc_queue)(struct nvme_ctrl *ctrl, int qid);
+	void	(*free_queue)(struct nvme_ctrl *ctrl, int qid);
+	int	(*init_queue)(struct nvme_ctrl *ctrl, int qid);
+	void	(*deinit_queue)(struct nvme_ctrl *ctrl, int qid);
+	int	(*start_queue)(struct nvme_ctrl *ctrl, int qid);
+	void	(*stop_queue)(struct nvme_ctrl *ctrl, int qid);
+	int	(*alloc_admin_tag_set)(struct nvme_ctrl *ctrl);
+};
+
 static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
@@ -214,5 +224,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new);
+
 
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..e58211802031 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -244,6 +244,8 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STOPPED		= 3,
 };
 
+struct nvme_fabrics_ops;
+
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
@@ -251,6 +253,7 @@ struct nvme_ctrl {
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
+	const struct nvme_fabrics_ops *fabrics_ops;
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
 	struct request_queue *fabrics_q;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d070d84b204e..0347d7909b1d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -887,61 +887,6 @@ static void nvme_rdma_deinit_queue(struct nvme_ctrl *nctrl, int qid)
 	}
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool new)
-{
-	int error;
-
-	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
-	if (error)
-		return error;
-
-	error = nvme_rdma_init_queue(&ctrl->ctrl, 0);
-	if (error)
-		goto out_free_queue;
-
-	if (new) {
-		error = nvme_alloc_admin_tag_set(&ctrl->ctrl,
-				&ctrl->admin_tag_set, &nvme_rdma_admin_mq_ops,
-				sizeof(struct nvme_rdma_request) +
-				NVME_RDMA_DATA_SGL_SIZE);
-		if (error)
-			goto out_deinit_admin_queue;
-
-	}
-
-	error = nvme_rdma_start_queue(&ctrl->ctrl, 0);
-	if (error)
-		goto out_remove_admin_tag_set;
-
-	error = nvme_enable_ctrl(&ctrl->ctrl);
-	if (error)
-		goto out_stop_queue;
-
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-
-	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
-	if (error)
-		goto out_quiesce_queue;
-
-	return 0;
-
-out_quiesce_queue:
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-out_stop_queue:
-	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-out_remove_admin_tag_set:
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-out_deinit_admin_queue:
-	nvme_rdma_deinit_queue(&ctrl->ctrl, 0);
-out_free_queue:
-	nvme_rdma_free_queue(&ctrl->ctrl, 0);
-	return error;
-}
-
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -1081,12 +1026,21 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	}
 }
 
+static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
+{
+
+	return nvme_alloc_admin_tag_set(ctrl, &to_rdma_ctrl(ctrl)->admin_tag_set,
+					&nvme_rdma_admin_mq_ops,
+					sizeof(struct nvme_rdma_request) +
+					   NVME_RDMA_DATA_SGL_SIZE);
+}
+
 static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
 	bool changed;
 
-	ret = nvme_rdma_configure_admin_queue(ctrl, new);
+	ret = nvmf_configure_admin_queue(&ctrl->ctrl, new);
 	if (ret)
 		return ret;
 
@@ -2330,6 +2284,16 @@ nvme_rdma_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static struct nvme_fabrics_ops nvme_rdma_fabrics_ops = {
+	.alloc_queue		= nvme_rdma_alloc_queue,
+	.free_queue		= nvme_rdma_free_queue,
+	.init_queue		= nvme_rdma_init_queue,
+	.deinit_queue		= nvme_rdma_deinit_queue,
+	.start_queue		= nvme_rdma_start_queue,
+	.stop_queue		= nvme_rdma_stop_queue,
+	.alloc_admin_tag_set	= nvme_rdma_alloc_admin_tag_set,
+};
+
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2341,6 +2305,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.fabrics_ops = &nvme_rdma_fabrics_ops;
 	INIT_LIST_HEAD(&ctrl->list);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6100a787d39..fdb8b6d0c3e1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1740,25 +1740,6 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
 	return ret;
 }
 
-static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
-{
-	int ret;
-
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
-	if (ret)
-		return ret;
-
-	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
-	if (ret)
-		goto out_free_queue;
-
-	return 0;
-
-out_free_queue:
-	nvme_tcp_free_queue(ctrl, 0);
-	return ret;
-}
-
 static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
@@ -1932,53 +1913,6 @@ static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 	nvme_tcp_free_admin_queue(ctrl);
 }
 
-static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
-{
-	int error;
-
-	error = nvme_tcp_alloc_admin_queue(ctrl);
-	if (error)
-		return error;
-
-	if (new) {
-		error = nvme_alloc_admin_tag_set(ctrl,
-				&to_tcp_ctrl(ctrl)->admin_tag_set,
-				&nvme_tcp_admin_mq_ops,
-				sizeof(struct nvme_tcp_request));
-		if (error)
-			goto out_free_queue;
-	}
-
-	error = nvme_tcp_start_queue(ctrl, 0);
-	if (error)
-		goto out_cleanup_tagset;
-
-	error = nvme_enable_ctrl(ctrl);
-	if (error)
-		goto out_stop_queue;
-
-	nvme_unquiesce_admin_queue(ctrl);
-
-	error = nvme_init_ctrl_finish(ctrl, false);
-	if (error)
-		goto out_quiesce_queue;
-
-	return 0;
-
-out_quiesce_queue:
-	nvme_quiesce_admin_queue(ctrl);
-	blk_sync_queue(ctrl->admin_q);
-out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
-out_cleanup_tagset:
-	if (new)
-		nvme_remove_admin_tag_set(ctrl);
-out_free_queue:
-	nvme_tcp_free_admin_queue(ctrl);
-	return error;
-}
-
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
@@ -2027,12 +1961,28 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 	}
 }
 
+static int nvme_tcp_init_queue(struct nvme_ctrl *ctrl, int qid)
+{
+	if (qid == 0) {
+		return nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
+	}
+
+	return 0;
+}
+
+static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
+{
+	return nvme_alloc_admin_tag_set(ctrl, &to_tcp_ctrl(ctrl)->admin_tag_set,
+					&nvme_tcp_admin_mq_ops,
+					sizeof(struct nvme_tcp_request));
+}
+
 static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 {
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	int ret;
 
-	ret = nvme_tcp_configure_admin_queue(ctrl, new);
+	ret = nvmf_configure_admin_queue(ctrl, new);
 	if (ret)
 		return ret;
 
@@ -2552,6 +2502,15 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static struct nvme_fabrics_ops nvme_tcp_fabrics_ops = {
+	.alloc_queue		= nvme_tcp_alloc_queue,
+	.free_queue		= nvme_tcp_free_queue,
+	.start_queue		= nvme_tcp_start_queue,
+	.stop_queue		= nvme_tcp_stop_queue,
+	.init_queue		= nvme_tcp_init_queue,
+	.alloc_admin_tag_set	= nvme_tcp_alloc_admin_tag_set,
+};
+
 static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2564,6 +2523,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.fabrics_ops = &nvme_tcp_fabrics_ops;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
-- 
2.39.2


