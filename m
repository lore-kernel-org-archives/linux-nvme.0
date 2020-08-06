Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62946C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6C62086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XP370RFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6C62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6COat+g7W24muY7J1dkeVky11/VhCAXydOC3dZTvV0=; b=XP370RFyRcYcrQcEHOgto7sd70
	nw2b1MhYeICR1PWmvhOHmpLslwRs7WKmGGGpYNwWIlkeq61ePAxctFY2mtle/PKXsKlR+YX4/xTMJ
	/OGEFTIBHjk4AgjnWaQiYuw5CIFDWoL36RZ2uc3xzwkvEVh/7D18bXthvg97PD8m2/D2Q0+pT9EX0
	BRAlUKk1kzPycV/n+dlN6sYc+IW+f3qBt1BrYE3kV0jIs6IA9v5irTOBkDEo225EB0or/8JBUh+m5
	WiM896OlenJMhUaxAFDzvxZZ3W0sjmodmXNNl8Xctw03VN34ofkhqJ8O/RMcg8ieaXQJf7wH7Si0k
	ItLtPcbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIv-0008In-U6; Thu, 06 Aug 2020 19:11:53 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIj-0008CE-QU
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:43 +0000
Received: by mail-pg1-f194.google.com with SMTP id t6so27458796pgq.1
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6bERrZpYJ30phbQ4r3VJr05sEdhV5bjoZBsB31ML+QI=;
 b=ns9gErDQzz1jvuUUrfm6TXhupHrV6RHJ9wQFXTFcRY2+YzignSn/Yl0E+Zln5BhHHZ
 ahNN+HElri47iChekOxWAL+wjijohW6PqlYArVptjSF03XcGM9grwUHK3FqtI1BPZFg6
 o86zVsOB1yeDeW398K4/PENvsOO9jZKUtmHzJGLfUasi6W0X7h0ejU0N66xxlDaVJBC2
 dmXJUYsX/ca3SG45Efi8wYVKkgc9rM3vAI0ZNl96GyAzV00eKuKcWFyhpRiA2GWipeX5
 F9k9kIFq+NDVWI0iizWM3bQ4KJaF/ztQbv8ykY1EerNNoAy05bMr5bHGzfaQWziKMwZJ
 frzQ==
X-Gm-Message-State: AOAM5322EdYUyN1vUmIFmT4ZqAegNMHvEL7aYmq/+EbgczRskVU4FZNh
 XX/8O/qATEm27D28rPRCQc6wSTxK
X-Google-Smtp-Source: ABdhPJz9UsEJF0I8gaZjkqmITm6mDdR9x/evSaF8kExrHhhUOKCSmvUvrT4gD3Yn+kR0EaocQrSYFQ==
X-Received: by 2002:a05:6a00:790:: with SMTP id
 g16mr9579723pfu.312.1596741100593; 
 Thu, 06 Aug 2020 12:11:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:39 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 7/8] nvme-rdma: fix timeout handler
Date: Thu,  6 Aug 2020 12:11:26 -0700
Message-Id: <20200806191127.592062-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151141_999369_5BB1F448 
X-CRM114-Status: GOOD (  19.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently we check if the controller state != LIVE, and
we directly fail the command under the assumption that this
is the connect command or an admin command within the
controller initialization sequence.

This is wrong, we need to check if the request risking
controller setup/teardown blocking if not completed and
only then fail.

The logic should be:
- RESETTING, only fail fabrics/admin commands otherwise
  controller teardown will block. otherwise reset the timer
  and come back again.
- CONNECTING, if this is a connect (or an admin command), we fail
  right away (unblock controller initialization), otherwise we
  treat it like anything else.
- otherwise trigger error recovery and reset the timer (the
  error handler will take care of completing/delaying it).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 68 +++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index abc318737f35..30b401fcc06a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1185,6 +1185,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
@@ -1951,6 +1952,23 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
+static void nvme_rdma_complete_timed_out(struct request *rq)
+{
+	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+
+	/* fence other contexts that may complete the command */
+	mutex_lock(&ctrl->teardown_lock);
+	nvme_rdma_stop_queue(queue);
+	if (blk_mq_request_completed(rq))
+		goto out;
+	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+	blk_mq_complete_request(rq);
+out:
+	mutex_unlock(&ctrl->teardown_lock);
+}
+
 static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
@@ -1961,29 +1979,43 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
 		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	/*
-	 * Restart the timer if a controller reset is already scheduled. Any
-	 * timed out commands would be handled before entering the connecting
-	 * state.
-	 */
-	if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
+	switch (ctrl->ctrl.state) {
+	case NVME_CTRL_RESETTING:
+		if (!nvme_rdma_queue_idx(queue)) {
+			/*
+			 * if we are in teardown we must complete immediately
+			 * because we may block the teardown sequence (e.g.
+			 * nvme_disable_ctrl timed out).
+			 */
+			nvme_rdma_complete_timed_out(rq);
+			return BLK_EH_DONE;
+		}
+		/*
+		 * Restart the timer if a controller reset is already scheduled.
+		 * Any timed out commands would be handled before entering the
+		 * connecting state.
+		 */
 		return BLK_EH_RESET_TIMER;
-
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+	case NVME_CTRL_CONNECTING:
+		if (reserved || !nvme_rdma_queue_idx(queue)) {
+			/*
+			 * if we are connecting we must complete immediately
+			 * connect (reserved) or admin requests because we may
+			 * block controller setup sequence.
+			 */
+			nvme_rdma_complete_timed_out(rq);
+			return BLK_EH_DONE;
+		}
+		/* fallthru */
+	default:
 		/*
-		 * Teardown immediately if controller times out while starting
-		 * or we are already started error recovery. all outstanding
-		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 * every other state should trigger the error recovery
+		 * which will be handled by the flow and controller state
+		 * machine
 		 */
-		flush_work(&ctrl->err_work);
-		nvme_rdma_teardown_io_queues(ctrl, false);
-		nvme_rdma_teardown_admin_queue(ctrl, false);
-		return BLK_EH_DONE;
+		nvme_rdma_error_recovery(ctrl);
 	}
 
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	nvme_rdma_error_recovery(ctrl);
-
 	return BLK_EH_RESET_TIMER;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
