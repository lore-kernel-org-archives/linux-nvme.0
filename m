Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E2CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFAB2068F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEbiDeXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFAB2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWnfaHAJ8LlI+g0P6U5TKinwD6VjDDq/bTdNlqxI+qg=; b=pEbiDeXvEzU/xs164WkMKHzWxx
	PJlgxtk6L/xN+JGSZK4jsDG0yuvLpkegpzBUvVB8qxtZK4VQuUIIZ350rUSBVv+ccw2Js1x4yxxjh
	iJt1L6W2ye//1Wbya0DJhvzkkek9UVDuBvEaflJ2ufMIWeUKaBEiA9GY7QNwEA7BlROJjxbHCwEUI
	hwFGytuKGkk22IOt2xosUe9UjYADqlZjr69Grkh/DCSSyedOW31eO+5rfVjRF2fGRkyW9S7czfcvE
	+PhdNGQOsER1im3BYnOT5IbjhzQIr84kR28OF1CcPzjcrba6gfA7ne95yiOx4avODuYPG+sotKIAg
	c6Sqh5ZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2URA-0004ua-Pm; Mon, 03 Aug 2020 06:59:08 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UR8-0004t1-MG
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:07 +0000
Received: by mail-wm1-f68.google.com with SMTP id 9so13278007wmj.5
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kEB+2qh6OYuNHm3+SkR3tnDUzHIzOO+7YPEQk2brq+A=;
 b=fI83s4r8Wq2PuCLRs9ip8g7VaO6SEF2z1pz6h5rtUvoqkSDvkzoiqZzvAATrtH6WK/
 kAGUuUvN5qR4QeQHDF95QSpNlCU1GN51T+a70lOrUKJvsIgLnp1cybwZkyHvFtto3/CZ
 2DbmJDmsaE+bKb2OWUswonx9vJ834Kz6aH/FcmJMkJq2+TSCs6Ed0dvkZ/rnAlUO1JXu
 PGWNMs2RueKxztJU+hsMJAPCztCU1zmLmhAOTaE9qFD+8Z2cwAWgbaHlAAKmv/5tCOFO
 uTfYSZE9hGKEA0dcduxr+hjKWo9fDmyJ1pFqCRW/L4wKy2jhnq1HNqDlBGMYYczru609
 8jcw==
X-Gm-Message-State: AOAM532fK2H37Roa55uBn3HRpENLaCcCsMuNZhrXDIJ+v9Kbi6HDFk8g
 OQp7XlBwkwGkHel9LjesF2vyEVQ3
X-Google-Smtp-Source: ABdhPJyM3R0f3s5Uhyxx67qBCNdmPy4PfOuVONgswzyRZ/9DJgUWAZ1cPlC0Hsvz6GCkVGwJN99oxA==
X-Received: by 2002:a05:600c:514:: with SMTP id
 i20mr14774790wmc.102.1596437944902; 
 Sun, 02 Aug 2020 23:59:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:59:04 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 3/6] nvme-tcp: fix timeout handler
Date: Sun,  2 Aug 2020 23:58:49 -0700
Message-Id: <20200803065852.69987-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803065852.69987-1-sagi@grimberg.me>
References: <20200803065852.69987-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025906_766772_9FEADFA5 
X-CRM114-Status: GOOD (  18.86  )
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

Moreover, we teardown the entire controller in the timeout
handler, which does more than what we really want and it causes
us to freeze the queues again. We need to only fence the I/O
queue and the error recovery teardown.

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
 drivers/nvme/host/tcp.c | 70 +++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62fbaecdc960..ddacfeaa2543 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -464,6 +464,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
@@ -2149,40 +2150,69 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }
 
+static void nvme_tcp_complete_timed_out(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
+
+	/* fence other contexts that may complete the command */
+	flush_work(&to_tcp_ctrl(ctrl)->err_work);
+	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (blk_mq_request_completed(rq))
+		return;
+	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
+	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+	blk_mq_complete_request(rq);
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
+	switch (ctrl->state) {
+	case NVME_CTRL_RESETTING:
+		if (!nvme_tcp_queue_id(req->queue)) {
+			/*
+			 * if we are in teardown we must complete immediately
+			 * because we may block the teardown sequence (e.g.
+			 * nvme_disable_ctrl timed out).
+			 */
+			nvme_tcp_complete_timed_out(rq);
+			return BLK_EH_DONE;
+		}
+		/*
+		 * Restart the timer if a controller reset is already scheduled.
+		 * Any timed out commands would be handled before entering the
+		 * connecting state.
+		 */
+		return BLK_EH_RESET_TIMER;
+	case NVME_CTRL_CONNECTING:
 		/*
-		 * Teardown immediately if controller times out while starting
-		 * or we are already started error recovery. all outstanding
-		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 * if we are connecting we must complete immediately
+		 * because we may block controller setup sequence
+		 * - connect requests
+		 * - initialization admin requests
+		 * - I/O requests that entered when unquiesced and
+		 *   the controller stopped responding
 		 */
-		flush_work(&ctrl->err_work);
-		nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
-		nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
+		nvme_tcp_complete_timed_out(rq);
 		return BLK_EH_DONE;
+	default:
+		/*
+		 * every other state should trigger the error recovery
+		 * which will be handled by the flow and controller state
+		 * machine
+		 */
+		nvme_tcp_error_recovery(ctrl);
 	}
 
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	nvme_tcp_error_recovery(&ctrl->ctrl);
-
 	return BLK_EH_RESET_TIMER;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
