Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B177FC43461
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D4F21973
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PiojMTUA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWddUZQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D4F21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3kffztGi+FCWzq029kEXtP496zSuR//hlqR68QovTXQ=; b=PiojMTUAWyPbqBLl8EuYsQWEz
	P/G/tiO26sSQPMDtVSyMXVBStTLKzE7szvGFmAksESXI1ymv7JzM6U+1i483HzWFjac7U0XGiGd2r
	aIgpqOORxNNwR6KlH6p8nYUg0CG+bYGPpGc7U2jz11yWoYHUt3Chk9DcI3VQIF5m0SQ6DZfa+v3AM
	cnu1rANDndgnVPiYIDgI8xCZZA0Exr0BDK+zkn+Suv1seWs7tJp4V+xNXOputGtSyKXNY1w22J5Bg
	e9zah1EZ9igR37M7CGa3KascCuyJzJ8zrM/23dZDZmtWeySEBm2dXhd3A48Jo3xxdZkyAO/a4245C
	TlYS5j6iQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFK4q-0005Lc-Fo; Mon, 07 Sep 2020 16:33:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK4i-0005Hz-U8
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:33:02 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C919D21897;
 Mon,  7 Sep 2020 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496380;
 bh=2p/t9dnfb8IB8c8f34rPsMaenMrvGi+vMteKncxt6/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rWddUZQlVcQEiFe7k09NLAk+ZzuE0AOAYof4RoWwYnbAdaiLFlv1NSCX/DDxqva3s
 EQA8dM3I+XMPyxQ4170XMMN4RbeuyaeYJjUbex+YwoaDwpJfjKG8v+3m1LK4AJvr9p
 aXERXsl5UjJd/ruhpEGhe5SkqNAN2WD6oOxwIoU0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 31/53] nvme-tcp: fix timeout handler
Date: Mon,  7 Sep 2020 12:31:57 -0400
Message-Id: <20200907163220.1280412-31-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123301_459417_37E1EA57 
X-CRM114-Status: GOOD (  20.94  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 236187c4ed195161dfa4237c7beffbba0c5ae45b ]

When a request times out in a LIVE state, we simply trigger error
recovery and let the error recovery handle the request cancellation,
however when a request times out in a non LIVE state, we make sure to
complete it immediately as it might block controller setup or teardown
and prevent forward progress.

However tearing down the entire set of I/O and admin queues causes
freeze/unfreeze imbalance (q->mq_freeze_depth) because and is really
an overkill to what we actually need, which is to just fence controller
teardown that may be running, stop the queue, and cancel the request if
it is not already completed.

Now that we have the controller teardown_lock, we can safely serialize
request cancellation. This addresses a hang caused by calling extra
queue freeze on controller namespaces, causing unfreeze to not complete
correctly.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 56 ++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d1e5b27675b1b..65a3bad778104 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -448,6 +448,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
@@ -2125,40 +2126,55 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
 
+static void nvme_tcp_complete_timed_out(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
+
+	/* fence other contexts that may complete the command */
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
+	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (!blk_mq_request_completed(rq)) {
+		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		blk_mq_complete_request(rq);
+	}
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
+}
+
 static enum blk_eh_timer_return
 nvme_tcp_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
 
-	/*
-	 * Restart the timer if a controller reset is already scheduled. Any
-	 * timed out commands would be handled before entering the connecting
-	 * state.
-	 */
-	if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
-		return BLK_EH_RESET_TIMER;
-
-	dev_warn(ctrl->ctrl.device,
+	dev_warn(ctrl->device,
 		"queue %d: timeout request %#x type %d\n",
 		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
 
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
-		 * Teardown immediately if controller times out while starting
-		 * or we are already started error recovery. all outstanding
-		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 * If we are resetting, connecting or deleting we should
+		 * complete immediately because we may block controller
+		 * teardown or setup sequence
+		 * - ctrl disable/shutdown fabrics requests
+		 * - connect requests
+		 * - initialization admin requests
+		 * - I/O requests that entered after unquiescing and
+		 *   the controller stopped responding
+		 *
+		 * All other requests should be cancelled by the error
+		 * recovery work, so it's fine that we fail it here.
 		 */
-		flush_work(&ctrl->err_work);
-		nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
-		nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
+		nvme_tcp_complete_timed_out(rq);
 		return BLK_EH_DONE;
 	}
 
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	nvme_tcp_error_recovery(&ctrl->ctrl);
-
+	/*
+	 * LIVE state should trigger the normal error recovery which will
+	 * handle completing this request.
+	 */
+	nvme_tcp_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
