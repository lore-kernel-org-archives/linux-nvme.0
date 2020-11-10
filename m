Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EE1C55ABD
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:54:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25EE20731
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wXLXrNs8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRxKOBeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25EE20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5bhYmRbHfyqjep1I4IoZVqr7tDup30ktDsoDszpjCQU=; b=wXLXrNs8Tn1IE+7DTP3+tzt2u
	amzlYhfoXebB6PFsRWbqWZKetwWpvYLdddaz4ftBOUo2C8MBwhFY2t5oQPInk1hI+/jdEKKt+qf3z
	t8KGOA/zm/c9vlQR6frkU2YEiuQLz1JRts045KJAmNRA2yJOFQtx8Pnc2UjXt+I1Ie2RYApm4Eq01
	PvFQPSNHAiRat3WWQRIC/WrMEdjBsrdTnJnfk/xhueZxlAS6Z1N3uTB1zRheMGE43WdLPe5xpMefs
	ZRAbHxBXGVN9nW/7x586ZJFHGmVIbpG0ecT5Ma+gLi3+k0H46+BBgEqThLZ9NyKOXVDFsVWqBbeUt
	rJ/63wcGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcKjS-0001gV-B3; Tue, 10 Nov 2020 03:54:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcKjO-0001eV-Ll
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 03:54:07 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39B6520731;
 Tue, 10 Nov 2020 03:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604980446;
 bh=wWidYz1e1o2UJQ0GthRXvkMgbsaoM/+a6bk4jWTvJPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sRxKOBeoprJwzG6mHBtpZtHmCjJTP08NFrJSqqwVoqgYBvN9y9y90s7u5CRQrfwFf
 UVzHz8/+0e/cMxsw2m47wsNlbH9/45zX/tza4FBjhhQTvqAYfuzEvca8mrqsxD38lP
 A8SjH/Vt+2IJJLrS/UxV0OPkhs/l8Q+BjcB8Hct0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 33/55] nvme-rdma: avoid race between time out and
 tear down
Date: Mon,  9 Nov 2020 22:52:56 -0500
Message-Id: <20201110035318.423757-33-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035318.423757-1-sashal@kernel.org>
References: <20201110035318.423757-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_225406_892063_2049402A 
X-CRM114-Status: GOOD (  16.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 3017013dcc82a4862bd1e140f8b762cfc594008d ]

Now use teardown_lock to serialize for time out and tear down. This may
cause abnormal: first cancel all request in tear down, then time out may
complete the request again, but the request may already be freed or
restarted.

To avoid race between time out and tear down, in tear down process,
first we quiesce the queue, and then delete the timer and cancel
the time out work for the queue. At the same time we need to delete
teardown_lock.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 116902b1b2c34..18321c4517549 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -122,7 +122,6 @@ struct nvme_rdma_ctrl {
 	struct sockaddr_storage src_addr;
 
 	struct nvme_ctrl	ctrl;
-	struct mutex		teardown_lock;
 	bool			use_inline_data;
 	u32			io_queues[HCTX_MAX_TYPES];
 };
@@ -1010,8 +1009,8 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&ctrl->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (ctrl->ctrl.admin_tagset) {
 		blk_mq_tagset_busy_iter(ctrl->ctrl.admin_tagset,
@@ -1021,16 +1020,15 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (remove)
 		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
-	mutex_unlock(&ctrl->teardown_lock);
 }
 
 static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&ctrl->teardown_lock);
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		if (ctrl->ctrl.tagset) {
 			blk_mq_tagset_busy_iter(ctrl->ctrl.tagset,
@@ -1041,7 +1039,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, remove);
 	}
-	mutex_unlock(&ctrl->teardown_lock);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -1967,16 +1964,12 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
-	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	/* fence other contexts that may complete the command */
-	mutex_lock(&ctrl->teardown_lock);
 	nvme_rdma_stop_queue(queue);
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
-	mutex_unlock(&ctrl->teardown_lock);
 }
 
 static enum blk_eh_timer_return
@@ -2311,7 +2304,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
-	mutex_init(&ctrl->teardown_lock);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
