Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A353C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0o84j8xSufTQv0uwmbi1ojlKcfH4O/4b52kYEP0uxOo=; b=ofsaBcsy5+LiL2GHVAJ1ormyMG
	QQYJDfH4AgNYMA6vv0doCnWG9n3ACo0puY8KwQ2EKUI8k6QcC35FRqmN4mx3NFVjRX8TqnSa0Oh4a
	Xkf/P+FdAEtKc4x7n9OPoYter+CY6kSNcj9ugBgmVkvczUBG3uEWplaRpbqdyrBKFPwOT63C5NbCx
	fup+FzUeQDWuV1pMbUFsDHuOFjkOM42vBl0CPjP2JtxSkb0YoIV/j2+rxH/i/UWyaIQpE7BDBZjG6
	DtkK0Z4ct4b0+xsDAUYQerSiqfEQtYIgV2hcRMIBHh3zsK/qPuM5G3Zdk6H11E5vqrUI7OQTxi8S6
	2FV9nkww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o971o-00B3Bh-BN; Wed, 06 Jul 2022 15:33:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o971g-00B37J-65
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:33:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7D96B61FF9;
	Wed,  6 Jul 2022 15:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F1DC36AE2;
	Wed,  6 Jul 2022 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657121593;
	bh=0FML8zziQm5o5Gv0XRhLDhuolhnJbtR+Wkd+wNGpKkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUZz0WFVyS2VafSenlGHHwvbUq6EXy2UVdZFWp11MR3hgkpql+NEvoVDhw9TtPOD/
	 a5y39T//yP0BMTn9Cqj9BXroNNVaqxUEggZ7bRISkTUYv3RcGfCz7J4xk5C97CWe5G
	 NOxFwXjJMVurQMpSnw+a+gJ8MgBVEib9p7Xo/l5IHLXsMJw3yeXM7cQhwYSLP/25Qz
	 Y4lw9NvYtHVON3u4gO0fW61fujf/VY+efNB9/Zx7Yo64gCW0Ba4dfDK17Kw3g3qaOZ
	 a/BLZrZoPQpkd2O7kv+3THp9sMXTUuvU0VyJETh8bIQ9LErgDeCqQ8arK1BeX6mi0w
	 g2+uE0g8EmJ+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <liruozhu@huawei.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 10/11] nvme: fix regression when disconnect a recovering ctrl
Date: Wed,  6 Jul 2022 11:32:55 -0400
Message-Id: <20220706153256.1598411-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153256.1598411-1-sashal@kernel.org>
References: <20220706153256.1598411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_083316_341035_F196CDF9 
X-CRM114-Status: GOOD (  18.16  )
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

From: Ruozhu Li <liruozhu@huawei.com>

[ Upstream commit f7f70f4aa09dc43d7455c060143e86a017c30548 ]

We encountered a problem that the disconnect command hangs.
After analyzing the log and stack, we found that the triggering
process is as follows:
CPU0                          CPU1
                                nvme_rdma_error_recovery_work
                                  nvme_rdma_teardown_io_queues
nvme_do_delete_ctrl                 nvme_stop_queues
  nvme_remove_namespaces
  --clear ctrl->namespaces
                                    nvme_start_queues
                                    --no ns in ctrl->namespaces
    nvme_ns_remove                  return(because ctrl is deleting)
      blk_freeze_queue
        blk_mq_freeze_queue_wait
        --wait for ns to unquiesce to clean infligt IO, hang forever

This problem was not found in older kernels because we will flush
err work in nvme_stop_ctrl before nvme_remove_namespaces.It does not
seem to be modified for functional reasons, the patch can be revert
to solve the problem.

Revert commit 794a4cb3d2f7 ("nvme: remove the .stop_ctrl callout")

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c |  2 ++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c | 12 +++++++++---
 drivers/nvme/host/tcp.c  | 10 +++++++---
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af2902d70b19..ab060b4911ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4460,6 +4460,8 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	if (ctrl->ops->stop_ctrl)
+		ctrl->ops->stop_ctrl(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e40a6306e53..58cf9e39d613 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -478,6 +478,7 @@ struct nvme_ctrl_ops {
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
+	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 };
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8eacc9bd58f5..b61924394032 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1057,6 +1057,14 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	}
 }
 
+static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->reconnect_work);
+}
+
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -2236,9 +2244,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
-
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	if (shutdown)
@@ -2288,6 +2293,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
 	.get_address		= nvmf_get_address,
+	.stop_ctrl		= nvme_rdma_stop_ctrl,
 };
 
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d5e162f2c23a..fe8c27bbc3f2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2135,9 +2135,6 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
-
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2177,6 +2174,12 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
+static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
+{
+	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
+	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+}
+
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
@@ -2499,6 +2502,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
 	.get_address		= nvmf_get_address,
+	.stop_ctrl		= nvme_tcp_stop_ctrl,
 };
 
 static bool
-- 
2.35.1


