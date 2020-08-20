Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF8FC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3968A2072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xZIJ1l0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3968A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+otviMRsXFRlSbX1NvttFxOwis6qmHrzHDwulztufQ=; b=xZIJ1l0fgRID0/i63Hh8CxRVWk
	8laCXSzNCQIAxOglwrxnnoJMafUFKKK0+hTS7zvv7wExdUgtk5HnEtRskX2aMDHrbKHxJTpQ/pt/q
	DRbF0Eglz6FsYjoEvLugWZlSUw4vaA0iDd6Kgib/np0FV/QEG6dCHCMpyhHqMCvepMyGYGQMV1Pd8
	ffX70GMcvi/Z9R4PTf+iuY1TyOqkZY3uQQZzJDUdmGXkcIMRcOct6wBYDYps4gTG3dB9hMuMdLcQM
	Z36XBLFlD1GGGICQNHOyyrkEdylylpYCsft6/pU6MwWgywrP8Zue5I/83/o6Toym+gNUECw0SjlF2
	78DbFp1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dGO-0000iH-SH; Thu, 20 Aug 2020 05:37:24 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dGM-0000gv-3I
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:22 +0000
Received: by mail-wr1-f49.google.com with SMTP id z18so810514wrm.12
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=41LvvSVbbbK1rBGMjNytETfyk1E2Huz/BJtnQEWDYuc=;
 b=hY2Sb4XLYksON0tYpx+CI7fYNctjzrlJoWrDHjIb2d6CUmuPGHsDEz6fhsH49unGln
 KK2yEkiE2nOssdFfHgpO7erQuD4N7iaZP6zFNl1nM3uFcNS1X3FwVXR5G8BlndQsyOjP
 euQU+/CaPtRuKQ9A65ycSzLuMkSDw1XtaQWhOdJYDi1dknEji8mlqPUAoKfhb4w4eoS2
 CfX6/Uko1UxjM8YSAr6iuFKv0ol2Irp8BnPEtohNbN6C2bwTaPkHJULjP8MLY38dXABu
 kEkcu2Pg0P7MX+H5uVbMILlW/OfoyDoQlGFDasdmp+rsiX6/UCVP9ud0wl1os+jk59c4
 1gcg==
X-Gm-Message-State: AOAM532hz7gBuA6ZuYwZhcsuxSBNe5EhWYAeVn51cvGt5MSwZtnIZhdl
 Z7j/j16ti/OVpLG2MfrfSA2sn+myiyTMYQ==
X-Google-Smtp-Source: ABdhPJzC63EVMIouVKwMr7pYGyckKqrRYxYGevIPCGpy8o1F6BkxC0LYUdheMp9RMbXzm6+/jOSItg==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr1407571wrm.275.1597901840694; 
 Wed, 19 Aug 2020 22:37:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:20 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 5/9] nvme-tcp: fix timeout handler
Date: Wed, 19 Aug 2020 22:36:47 -0700
Message-Id: <20200820053651.197057-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013722_175593_B5513646 
X-CRM114-Status: GOOD (  21.19  )
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
---
 drivers/nvme/host/tcp.c | 56 ++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d58a6e2a4ab1..dbb661b899ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -465,6 +465,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
@@ -2155,40 +2156,55 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
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
