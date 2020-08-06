Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D3C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F7E2086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pxqjrSYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F7E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ObdO0b0y+aRgde0M3iZMjokReojzIWFgPqmBqfPRcIk=; b=pxqjrSYtEGuxg4tcDwBnt7yb6d
	I8tphTd64wOLRRH3nRYclacBkzUXv+as1k2583szjyVRzT+MDAdeYMckH6trgx3ut9mAp44XxM5EO
	YKQUpKkJBip1YsG1R+ZegfR40jDgrJAbb8HvTkY+AKPdNUtDCVLTu8Rq4yETxvqwSrzERUajLm5Ab
	pir7ESXt/z0S4jERl5MaUQRZ+fkuXu6JBSnV0mq0Lb05aFG06ngCxVgryWdBf87pzGXmFAE5iPSsN
	ByMoc0v7ToTDliFEqUoVErrQZJl/d3mOmloKJD/wUxpxoPUy+GU9XY3ZbPiHLeGTUGwudAvnNHcqU
	ZDQWEdLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIp-0008FD-2w; Thu, 06 Aug 2020 19:11:47 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIf-0008A7-2g
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:38 +0000
Received: by mail-pj1-f67.google.com with SMTP id c6so7359140pje.1
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bUCNMKoRSnKXYaKpfp4pxdCSA4kz4OLQQ6GbxkPD5AU=;
 b=sU2MiCaR2lEWyzRT8Pc9t9I666zXNGcRrU5Y6LWe0qJx8tJVCRKgSIqQPrkOI0a6Ih
 jyU5azIm9i6zlNtCMHIMiJcq2Zpe1OQjT6r3J/2C3HIp+e0kT037aUnN2Za1qiqYokQC
 Jaqj84M6vnx//HzcA/z/YGoHiC84tbt4noxXmTAGtZPgieB525tXl707+MTbf8p03ksL
 mh8DO9fXlX+iMReQ1VWAcEiRXyvQxm1HaN/5lyktQVUUzFi5GmR21twn5vordRVS9EQH
 /MW1+2YH5nuT0fkVxOdWzQD2FHXkrTwW2LUMFJ4wlvB+Cwv+liUuhOjCCKCGIIrrNT9v
 k3uA==
X-Gm-Message-State: AOAM532PVBVm4wllogiDqjNpz1Cnl6ibOud9DT79W8mxs1qA4/Aa6n/V
 NuYjLDJRD3gPb65MrD1YR5LCbPpu
X-Google-Smtp-Source: ABdhPJzSFnzj2aRXyPveLAb55clZn2+WMdR5ZXjtlX5cFD0zKEUQ3xvydBSRLRmjEC2c6U1q/9gZOQ==
X-Received: by 2002:a17:902:8e89:: with SMTP id
 bg9mr9183381plb.126.1596741095938; 
 Thu, 06 Aug 2020 12:11:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 4/8] nvme-tcp: fix timeout handler
Date: Thu,  6 Aug 2020 12:11:23 -0700
Message-Id: <20200806191127.592062-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151137_222252_DE12F6F0 
X-CRM114-Status: GOOD (  19.21  )
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
 drivers/nvme/host/tcp.c | 71 +++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 80af1b287cd0..d472fb5e79fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -465,6 +465,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
@@ -2155,40 +2156,70 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }
 
+static void nvme_tcp_complete_timed_out(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
+
+	/* fence other contexts that may complete the command */
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
+	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (blk_mq_request_completed(rq))
+		goto out;
+	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+	blk_mq_complete_request(rq);
+out:
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
 		/*
-		 * Teardown immediately if controller times out while starting
-		 * or we are already started error recovery. all outstanding
-		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 * Restart the timer if a controller reset is already scheduled.
+		 * Any timed out commands would be handled before entering the
+		 * connecting state.
 		 */
-		flush_work(&ctrl->err_work);
-		nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
-		nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
+		return BLK_EH_RESET_TIMER;
+	case NVME_CTRL_CONNECTING:
+		/*
+		 * if we are connecting we must complete immediately
+		 * because we may block controller setup sequence
+		 * - connect requests
+		 * - initialization admin requests
+		 * - I/O requests that entered when unquiesced and
+		 *   the controller stopped responding
+		 */
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
