Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F400CC678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejWL7b3NmFrIhe6R++jA2tnihlFkLTvxCeu1yI2s8a0=; b=qYgfsl7ufTzlhpfUrzbskF9HTC
	WTVbr9VrzNcIefnFWRMjrmTJVuwF9f7doo7dYFM+lUYYBbZf0H3Lz3o9LHq05c28O8VmaHv0W1a4x
	2FimrRAK5miXYbsAAttzvT4liND9U1hFso+YJPaYTHHfQsOxakjTlppbsgPZbHGoWZ5XEpoQrtjId
	cDi+5LBPl7H9vRWAP/fdXbnYZXqiuXqiOuArFCpZwj/JpbKjocW9KfX/osR38FbH0Onu14uRkcsIo
	/DwQee8EL9vyA6T9XoDAcGDMtlcLlVeEFxadoDnBV3n4VCg0rEuokYvVXaxFfEf/6oVP4S/KNVpvx
	YoKg7EHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7Dl-00C6Gc-RR; Mon, 06 Mar 2023 09:33:29 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7D9-00C63E-D5
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 320661FDE4;
	Mon,  6 Mar 2023 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejWL7b3NmFrIhe6R++jA2tnihlFkLTvxCeu1yI2s8a0=;
	b=Zu0kFtB218Aaxy45mVTfkIyiMEajyPjGhQnhtpYSLTUFgiN5U1Y8flY5cWCO3miV/Cg0aQ
	eVpD7uDM9P8mjC0FdddXZswkHGbhZ0xyu1eaO3IjepNNTUsF86izFEcHNVsfDaGWkSH6Ph
	Rcto+NEZ3yWoaicnQNNO7dUJQqSdni4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejWL7b3NmFrIhe6R++jA2tnihlFkLTvxCeu1yI2s8a0=;
	b=x2eIDSgz2iX/jDm6WAwezb9o7PhnSqSyRMV7sI5L3ut5e+LqyJhwUj+OdvTEQ9HSlyMCRa
	RZs9TuxerC5EYzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2090D13513;
	Mon,  6 Mar 2023 09:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XkfsB0KzBWR+YAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:50 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 5/6] nvme-tcp: move nvme ctrl state machine code to fabrics.c
Date: Mon,  6 Mar 2023 10:32:43 +0100
Message-Id: <20230306093244.20775-6-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306093244.20775-1-dwagner@suse.de>
References: <20230306093244.20775-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013251_803590_34A838FF 
X-CRM114-Status: GOOD (  24.50  )
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
 drivers/nvme/host/fabrics.c | 434 +++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  21 ++
 drivers/nvme/host/nvme.h    |   3 +
 drivers/nvme/host/rdma.c    |  77 ++----
 drivers/nvme/host/tcp.c     | 498 ++++--------------------------------
 5 files changed, 526 insertions(+), 507 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..6525ce282039 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1134,6 +1134,440 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	return ERR_PTR(ret);
 }
 
+static int nvmf_start_io_queues(struct nvme_ctrl *ctrl,
+				    int first, int last)
+{
+	int i, ret;
+
+	for (i = first; i < last; i++) {
+		ret = ctrl->fabrics_ops->start_queue(ctrl, i);
+		if (ret)
+			goto out_stop_queues;
+	}
+
+	return 0;
+
+out_stop_queues:
+	for (i--; i >= first; i--)
+		ctrl->fabrics_ops->stop_queue(ctrl, i);
+	return ret;
+}
+
+static void nvmf_stop_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		ctrl->fabrics_ops->stop_queue(ctrl, i);
+}
+
+static int __nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i, ret;
+
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = ctrl->fabrics_ops->alloc_queue(ctrl, i);
+		if (ret)
+			goto out_free_queues;
+	}
+
+	return 0;
+
+out_free_queues:
+	for (i--; i >= 1; i--)
+		ctrl->fabrics_ops->free_queue(ctrl, i);
+
+	return ret;
+}
+
+static int nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	unsigned int nr_io_queues;
+	int ret;
+
+	nr_io_queues = ctrl->fabrics_ops->nr_io_queues(ctrl);
+	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
+	if (ret)
+		return ret;
+
+	if (nr_io_queues == 0) {
+		dev_err(ctrl->device,
+			"unable to set any I/O queues\n");
+		return -ENOMEM;
+	}
+
+	ctrl->queue_count = nr_io_queues + 1;
+	dev_info(ctrl->device,
+		"creating %d I/O queues.\n", nr_io_queues);
+
+	ctrl->fabrics_ops->set_io_queues(ctrl, nr_io_queues);
+
+	return __nvmf_alloc_io_queues(ctrl);
+}
+
+static void nvmf_free_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		ctrl->fabrics_ops->free_queue(ctrl, i);
+}
+
+int nvmf_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
+{
+	int ret, nr_queues;
+
+	ret = nvmf_alloc_io_queues(ctrl);
+	if (ret)
+		return ret;
+
+	if (new) {
+		ret = ctrl->fabrics_ops->alloc_tag_set(ctrl);
+		if (ret)
+			goto out_free_io_queues;
+	}
+
+	/*
+	 * Only start IO queues for which we have allocated the tagset
+	 * and limitted it to the available queues. On reconnects, the
+	 * queue number might have changed.
+	 */
+	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
+	ret = nvmf_start_io_queues(ctrl, 1, nr_queues);
+	if (ret)
+		goto out_cleanup_connect_q;
+
+	if (!new) {
+		nvme_unquiesce_io_queues(ctrl);
+		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+			ctrl->queue_count - 1);
+		nvme_unfreeze(ctrl);
+	}
+
+	/*
+	 * If the number of queues has increased (reconnect case)
+	 * start all new queues now.
+	 */
+	ret = nvmf_start_io_queues(ctrl, nr_queues,
+				   ctrl->tagset->nr_hw_queues + 1);
+	if (ret)
+		goto out_wait_freeze_timed_out;
+
+	return 0;
+
+out_wait_freeze_timed_out:
+	nvme_quiesce_io_queues(ctrl);
+	nvme_sync_io_queues(ctrl);
+	nvmf_stop_io_queues(ctrl);
+out_cleanup_connect_q:
+	nvme_cancel_tagset(ctrl);
+	if (new)
+		nvme_remove_io_tag_set(ctrl);
+out_free_io_queues:
+	nvmf_free_io_queues(ctrl);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvmf_configure_io_queues);
+
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
+static void nvmf_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+	nvmf_stop_io_queues(ctrl);
+	if (remove)
+		nvme_remove_io_tag_set(ctrl);
+	nvmf_free_io_queues(ctrl);
+}
+
+static void nvmf_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	ctrl->fabrics_ops->stop_queue(ctrl, 0);
+	if (remove)
+		nvme_remove_admin_tag_set(ctrl);
+
+	ctrl->fabrics_ops->free_queue(ctrl, 0);
+}
+
+static void nvmf_teardown_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	nvme_quiesce_admin_queue(ctrl);
+	blk_sync_queue(ctrl->admin_q);
+	ctrl->fabrics_ops->stop_queue(ctrl, 0);
+	nvme_cancel_admin_tagset(ctrl);
+	if (remove)
+		nvme_unquiesce_admin_queue(ctrl);
+	nvmf_destroy_admin_queue(ctrl, remove);
+}
+
+static void nvmf_teardown_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+	if (ctrl->queue_count <= 1)
+		return;
+	nvme_quiesce_admin_queue(ctrl);
+	nvme_start_freeze(ctrl);
+	nvme_quiesce_io_queues(ctrl);
+	nvme_sync_io_queues(ctrl);
+	nvmf_stop_io_queues(ctrl);
+	nvme_cancel_tagset(ctrl);
+	if (remove)
+		nvme_unquiesce_io_queues(ctrl);
+	nvmf_destroy_io_queues(ctrl, remove);
+}
+
+void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+	nvmf_teardown_io_queues(ctrl, shutdown);
+	nvme_quiesce_admin_queue(ctrl);
+	nvme_disable_ctrl(ctrl, shutdown);
+	nvmf_teardown_admin_queue(ctrl, shutdown);
+}
+EXPORT_SYMBOL_GPL(nvmf_teardown_ctrl);
+
+void nvmf_stop_ctrl(struct nvme_ctrl *ctrl)
+{
+	flush_work(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_stop_ctrl);
+
+int nvmf_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
+{
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ret;
+
+	ret = nvmf_configure_admin_queue(ctrl, new);
+	if (ret)
+		return ret;
+
+	if (ctrl->icdoff) {
+		ret = -EOPNOTSUPP;
+		dev_err(ctrl->device, "icdoff is not supported!\n");
+		goto destroy_admin;
+	}
+
+	if (!nvme_ctrl_sgl_supported(ctrl)) {
+		ret = -EOPNOTSUPP;
+		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
+		goto destroy_admin;
+	}
+
+	if (opts->queue_size > ctrl->sqsize + 1)
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			opts->queue_size, ctrl->sqsize + 1);
+
+	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
+		dev_warn(ctrl->device,
+			"sqsize %u > ctrl maxcmd %u, clamping down\n",
+			ctrl->sqsize + 1, ctrl->maxcmd);
+		ctrl->sqsize = ctrl->maxcmd - 1;
+	}
+
+	if (ctrl->queue_count > 1) {
+		ret = nvmf_configure_io_queues(ctrl, new);
+		if (ret)
+			goto destroy_admin;
+	}
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
+		/*
+		 * state change failure is ok if we started ctrl delete,
+		 * unless we're during creation of a new controller to
+		 * avoid races with teardown flow.
+		 */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		WARN_ON_ONCE(new);
+		ret = -EINVAL;
+		goto destroy_io;
+	}
+
+	nvme_start_ctrl(ctrl);
+	return 0;
+
+destroy_io:
+	if (ctrl->queue_count > 1) {
+		nvme_quiesce_io_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvmf_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
+		nvmf_destroy_io_queues(ctrl, new);
+	}
+destroy_admin:
+	nvme_quiesce_admin_queue(ctrl);
+	blk_sync_queue(ctrl->admin_q);
+	ctrl->fabrics_ops->stop_queue(ctrl, 0);
+	nvme_cancel_admin_tagset(ctrl);
+	nvmf_destroy_admin_queue(ctrl, new);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvmf_setup_ctrl);
+
+void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (ctrl->state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
+			ctrl->state == NVME_CTRL_LIVE);
+		return;
+	}
+
+	if (nvmf_should_reconnect(ctrl)) {
+		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
+			ctrl->opts->reconnect_delay);
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
+				ctrl->opts->reconnect_delay * HZ);
+	} else {
+		dev_info(ctrl->device, "Removing controller...\n");
+		nvme_delete_ctrl(ctrl);
+	}
+}
+EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
+
+void nvmf_error_recovery_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, err_work);
+
+	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
+	nvmf_teardown_io_queues(ctrl, false);
+	/* unquiesce to fail fast pending requests */
+	nvme_unquiesce_io_queues(ctrl);
+	nvmf_teardown_admin_queue(ctrl, false);
+	nvme_unquiesce_admin_queue(ctrl);
+	nvme_auth_stop(ctrl);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
+
+void nvmf_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, reset_work);
+
+	nvme_stop_ctrl(ctrl);
+	nvmf_teardown_ctrl(ctrl, false);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	if (nvmf_setup_ctrl(ctrl, false))
+		goto out_fail;
+
+	return;
+
+out_fail:
+	++ctrl->nr_reconnects;
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_reset_ctrl_work);
+
+void nvmf_reconnect_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
+
+	++ctrl->nr_reconnects;
+
+	if (nvmf_setup_ctrl(ctrl, false))
+		goto requeue;
+
+	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
+			ctrl->nr_reconnects);
+
+	ctrl->nr_reconnects = 0;
+
+	return;
+
+requeue:
+	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
+			ctrl->nr_reconnects);
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
+
+void nvmf_error_recovery(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		return;
+
+	dev_warn(ctrl->device, "starting error recovery\n");
+	queue_work(nvme_reset_wq, &ctrl->err_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery);
+
 static struct class *nvmf_class;
 static struct device *nvmf_device;
 static DEFINE_MUTEX(nvmf_dev_mutex);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6e22116e139..45bd918d89bb 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -172,6 +172,19 @@ struct nvmf_transport_ops {
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
+	int	(*alloc_tag_set)(struct nvme_ctrl *ctrl);
+	unsigned int	(*nr_io_queues)(struct nvme_ctrl *ctrl);
+	void	(*set_io_queues)(struct nvme_ctrl *ctrl, unsigned int nr_io_queues);
+};
+
 static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
@@ -214,5 +227,13 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+int nvmf_setup_ctrl(struct nvme_ctrl *ctrl, bool new);
+void nvmf_stop_ctrl(struct nvme_ctrl *ctrl);
+void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
+void nvmf_reset_ctrl_work(struct work_struct *work);
+void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
+void nvmf_error_recovery_work(struct work_struct *work);
+void nvmf_reconnect_ctrl_work(struct work_struct *work);
+void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5aa30b00dd17..fcea2678094c 100644
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
index cc9a019381f8..902506a5a255 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -884,61 +884,6 @@ static void nvme_rdma_deinit_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1078,12 +1023,21 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
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
 
@@ -2329,6 +2283,16 @@ nvme_rdma_existing_controller(struct nvmf_ctrl_options *opts)
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
@@ -2340,6 +2304,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.fabrics_ops = &nvme_rdma_fabrics_ops;
 	INIT_LIST_HEAD(&ctrl->list);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 75d9144faa1a..4d3b6252c921 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -518,15 +518,6 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->ddgst_remaining = 0;
 }
 
-static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
-		return;
-
-	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
-}
-
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -538,7 +529,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad cqe.command_id %#x on queue %d\n",
 			cqe->command_id, nvme_tcp_queue_id(queue));
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return -EINVAL;
 	}
 
@@ -580,7 +571,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x SUCCESS set but not last PDU\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return -EPROTO;
 	}
 
@@ -891,7 +882,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			dev_err(queue->ctrl->ctrl.device,
 				"receive failed:  %d\n", result);
 			queue->rd_enabled = false;
-			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 			return result;
 		}
 	}
@@ -939,7 +930,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 	case TCP_LAST_ACK:
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	default:
 		dev_info(queue->ctrl->ctrl.device,
@@ -1300,6 +1291,12 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	unsigned int noreclaim_flag;
 
+	if (qid == 0 && ctrl->async_req.pdu) {
+		cancel_work_sync(&nctrl->async_event_work);
+		nvme_tcp_free_async_req(ctrl);
+		ctrl->async_req.pdu = NULL;
+	}
+
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
@@ -1692,88 +1689,34 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	return ret;
 }
 
-static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
-{
-	if (to_tcp_ctrl(ctrl)->async_req.pdu) {
-		cancel_work_sync(&ctrl->async_event_work);
-		nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
-		to_tcp_ctrl(ctrl)->async_req.pdu = NULL;
-	}
-
-	nvme_tcp_free_queue(ctrl, 0);
-}
-
-static void nvme_tcp_free_io_queues(struct nvme_ctrl *ctrl)
-{
-	int i;
-
-	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_free_queue(ctrl, i);
-}
-
-static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_init_queue(struct nvme_ctrl *ctrl, int qid)
 {
-	int i;
+	if (qid == 0)
+		return nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
 
-	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+	return 0;
 }
 
-static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
-				    int first, int last)
+static void nvme_tcp_deinit_queue(struct nvme_ctrl *ctrl, int qid)
 {
-	int i, ret;
-
-	for (i = first; i < last; i++) {
-		ret = nvme_tcp_start_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
-
-	return 0;
-
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_tcp_stop_queue(ctrl, i);
-	return ret;
+	if (qid == 0)
+		nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
 }
 
-static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
+static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
 {
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
+	return nvme_alloc_admin_tag_set(ctrl, &to_tcp_ctrl(ctrl)->admin_tag_set,
+					&nvme_tcp_admin_mq_ops,
+					sizeof(struct nvme_tcp_request));
 }
 
-static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_alloc_tag_set(struct nvme_ctrl *ctrl)
 {
-	int i, ret;
-
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
-		if (ret)
-			goto out_free_queues;
-	}
-
-	return 0;
-
-out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_tcp_free_queue(ctrl, i);
+	return nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
+				     &nvme_tcp_mq_ops,
+				     ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
+				     sizeof(struct nvme_tcp_request));
 
-	return ret;
 }
 
 static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
@@ -1822,370 +1765,9 @@ static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
 	}
 }
 
-static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
-{
-	unsigned int nr_io_queues;
-	int ret;
-
-	nr_io_queues = nvme_tcp_nr_io_queues(ctrl);
-	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->device,
-			"unable to set any I/O queues\n");
-		return -ENOMEM;
-	}
-
-	ctrl->queue_count = nr_io_queues + 1;
-	dev_info(ctrl->device,
-		"creating %d I/O queues.\n", nr_io_queues);
-
-	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
-
-	return __nvme_tcp_alloc_io_queues(ctrl);
-}
-
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
-static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
-{
-	int ret, nr_queues;
-
-	ret = nvme_tcp_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	if (new) {
-		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
-				&nvme_tcp_mq_ops,
-				ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
-				sizeof(struct nvme_tcp_request));
-		if (ret)
-			goto out_free_io_queues;
-	}
-
-	/*
-	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
-	 * queue number might have changed.
-	 */
-	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
-	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	if (!new) {
-		nvme_unquiesce_io_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
-		}
-		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
-		nvme_unfreeze(ctrl);
-	}
-
-	/*
-	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
-	 */
-	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
-				       ctrl->tagset->nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
-
-	return 0;
-
-out_wait_freeze_timed_out:
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-out_cleanup_connect_q:
-	nvme_cancel_tagset(ctrl);
-	if (new)
-		nvme_remove_io_tag_set(ctrl);
-out_free_io_queues:
-	nvme_tcp_free_io_queues(ctrl);
-	return ret;
-}
-
-static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_queue(ctrl, 0);
-	if (remove)
-		nvme_remove_admin_tag_set(ctrl);
-	nvme_tcp_free_admin_queue(ctrl);
-}
-
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
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
-		bool remove)
-{
-	nvme_quiesce_admin_queue(ctrl);
-	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_admin_queue(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, remove);
-}
-
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-		bool remove)
-{
-	if (ctrl->queue_count <= 1)
-		return;
-	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
-}
-
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
-			ctrl->state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(ctrl)) {
-		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
-			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->connect_work,
-				ctrl->opts->reconnect_delay * HZ);
-	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
-		nvme_delete_ctrl(ctrl);
-	}
-}
-
-static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
-{
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	int ret;
-
-	ret = nvme_tcp_configure_admin_queue(ctrl, new);
-	if (ret)
-		return ret;
-
-	if (ctrl->icdoff) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->device, "icdoff is not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (!nvme_ctrl_sgl_supported(ctrl)) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (opts->queue_size > ctrl->sqsize + 1)
-		dev_warn(ctrl->device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			opts->queue_size, ctrl->sqsize + 1);
-
-	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
-		dev_warn(ctrl->device,
-			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->sqsize + 1, ctrl->maxcmd);
-		ctrl->sqsize = ctrl->maxcmd - 1;
-	}
-
-	if (ctrl->queue_count > 1) {
-		ret = nvme_tcp_configure_io_queues(ctrl, new);
-		if (ret)
-			goto destroy_admin;
-	}
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
-		/*
-		 * state change failure is ok if we started ctrl delete,
-		 * unless we're during creation of a new controller to
-		 * avoid races with teardown flow.
-		 */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		WARN_ON_ONCE(new);
-		ret = -EINVAL;
-		goto destroy_io;
-	}
-
-	nvme_start_ctrl(ctrl);
-	return 0;
-
-destroy_io:
-	if (ctrl->queue_count > 1) {
-		nvme_quiesce_io_queues(ctrl);
-		nvme_sync_io_queues(ctrl);
-		nvme_tcp_stop_io_queues(ctrl);
-		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
-	}
-destroy_admin:
-	nvme_quiesce_admin_queue(ctrl);
-	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, new);
-	return ret;
-}
-
-static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_ctrl, connect_work);
-
-	++ctrl->nr_reconnects;
-
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto requeue;
-
-	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
-			ctrl->nr_reconnects);
-
-	ctrl->nr_reconnects = 0;
-
-	return;
-
-requeue:
-	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
-			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
-}
-
-static void nvme_tcp_error_recovery_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(work,
-				struct nvme_ctrl, err_work);
-
-	nvme_stop_keep_alive(ctrl);
-	flush_work(&ctrl->async_event_work);
-	nvme_tcp_teardown_io_queues(ctrl, false);
-	/* unquiesce to fail fast pending requests */
-	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(ctrl);
-	nvme_auth_stop(ctrl);
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	nvme_tcp_reconnect_or_remove(ctrl);
-}
-
-static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
-{
-	nvme_tcp_teardown_io_queues(ctrl, shutdown);
-	nvme_quiesce_admin_queue(ctrl);
-	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
-}
-
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_tcp_teardown_ctrl(ctrl, true);
-}
-
-static void nvme_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, reset_work);
-
-	nvme_stop_ctrl(ctrl);
-	nvme_tcp_teardown_ctrl(ctrl, false);
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
-}
-
-static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-{
-	flush_work(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	nvmf_teardown_ctrl(ctrl, true);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
@@ -2308,7 +1890,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_tcp_error_recovery(ctrl);
+	nvmf_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2528,7 +2110,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
 	.get_address		= nvme_tcp_get_address,
-	.stop_ctrl		= nvme_tcp_stop_ctrl,
+	.stop_ctrl		= nvmf_stop_ctrl,
 };
 
 static bool
@@ -2548,6 +2130,19 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static struct nvme_fabrics_ops nvme_tcp_fabrics_ops = {
+	.alloc_queue		= nvme_tcp_alloc_queue,
+	.free_queue		= nvme_tcp_free_queue,
+	.start_queue		= nvme_tcp_start_queue,
+	.stop_queue		= nvme_tcp_stop_queue,
+	.init_queue		= nvme_tcp_init_queue,
+	.deinit_queue		= nvme_tcp_deinit_queue,
+	.alloc_admin_tag_set	= nvme_tcp_alloc_admin_tag_set,
+	.alloc_tag_set		= nvme_tcp_alloc_tag_set,
+	.nr_io_queues		= nvme_tcp_nr_io_queues,
+	.set_io_queues		= nvme_tcp_set_io_queues,
+};
+
 static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2560,15 +2155,16 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.fabrics_ops = &nvme_tcp_fabrics_ops;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
+			nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvmf_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
@@ -2629,7 +2225,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_uninit_ctrl;
 	}
 
-	ret = nvme_tcp_setup_ctrl(&ctrl->ctrl, true);
+	ret = nvmf_setup_ctrl(&ctrl->ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
-- 
2.39.2


