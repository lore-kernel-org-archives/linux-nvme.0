Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DBC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086AF2068F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="URyVQXlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086AF2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F54uGXVcbovWRMMkv8A8FEBGR2IjxD1AzXSfSPkmA4U=; b=URyVQXlGdCpP6WLv2BOYHYPRUK
	r0MGal5A4oFCND/zw7dcfxSZnr8YvDSugVbwRi/4p4ISiesmklDkwve0jrbWyHvutgeF0u9uOkVer
	Evk+bPxVL/7BvaK1hLQJdF95xyGKNfRfv+AlZGeMCQwAo1rjL+aHxxj6k5AOTIlZRnI9v2VV+ZxhV
	mbIuXgxtvx9yZKIbayuFGgjfN8gzQ9IXezG+opBV+6mcZfjGa8V7kCzncwcxFzKjABxBPjsF39OHt
	fQiLQwZ7FU2HLV51jYN/IqBXvCgwGoy/Y9ATcEMOLvB6YZMNa9DJAm7G+6qcK8EzWElEU/r9IN3gP
	rF3lM9pQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2URG-0004xL-8J; Mon, 03 Aug 2020 06:59:14 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2URC-0004vV-H8
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:11 +0000
Received: by mail-wm1-f66.google.com with SMTP id 9so13278173wmj.5
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4R0AM1gHuaSOqMLd7H4LMUthXyBBMYs0M4v7QS2FEyo=;
 b=aZUxrjVqkTDseS2buvtmXjcKpsCBPb+yIzuFUXfpoymw4ImHFUUQoaqvDdo7BJmhb9
 9RpH1qMAjJW8IF5mXDrvHEoiqroBNqK8iPKl41JV/9stegoqt4yIF7UgWpUeeDthrtKr
 gEBoWxgSb4mykDMVZvjNryo2gnELj7J8JQNOkfTPzYGLYgsqhn1U/DJin+vI9LKtcfph
 nMNsd0vRYM+LBYhbL9I77enqycMVq+c8WNU5rA5A+PZObgobxrsHCcPfriIoJDEks0kS
 pxe3ZNQbd+c1pG5hiZjEyFCNeJWwMKwdJ+BzBa+eTW+jyxK9HoxCIrii/3gE/tbnDmEh
 zbWQ==
X-Gm-Message-State: AOAM532/vYJeaPqKZjFC9ci6p4BWdVFyc5fn4/ZyPkKw3K/b4KP//qvX
 iKkV4KqG+ru4ApQ7d6Ft7ff1M49j
X-Google-Smtp-Source: ABdhPJwZx5MOFQKKa0C50rzcgktb3fs4AuWFl/RylakY6CXOrfwyJpjSxf81+RetHHkz9SArsVHWMQ==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr15271124wmb.51.1596437949328; 
 Sun, 02 Aug 2020 23:59:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:59:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 5/6] nvme-rdma: fix timeout handler
Date: Sun,  2 Aug 2020 23:58:51 -0700
Message-Id: <20200803065852.69987-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803065852.69987-1-sagi@grimberg.me>
References: <20200803065852.69987-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025910_686317_6B2F917C 
X-CRM114-Status: GOOD (  19.40  )
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
 drivers/nvme/host/rdma.c | 67 +++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 44c76ffbb264..a58c6deaf691 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1180,6 +1180,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
@@ -1946,6 +1947,22 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
+static void nvme_rdma_complete_timed_out(struct request *rq)
+{
+	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+
+	/* fence other contexts that may complete the command */
+	flush_work(&ctrl->err_work);
+	nvme_rdma_stop_queue(queue);
+	if (blk_mq_request_completed(rq))
+		return;
+	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
+	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+	blk_mq_complete_request(rq);
+}
+
 static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
@@ -1956,29 +1973,43 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
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
