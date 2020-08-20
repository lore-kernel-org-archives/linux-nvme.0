Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D1C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3F82072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BnXhiJX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3F82072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uptJDeNPaX/cvLnU/vbrN/XpRv2Xp4Stt5icO5csYO4=; b=BnXhiJX9tNMQ7WmovRgyn0bnhO
	XHycFh1ppv3eGr0f4Eyfqk5ZEdrO2g4KrIrqWoNOcQKBQtTyZyyvX9cPFM3aNIS5iSxABNE85GFyG
	wUMbktr6+ACO9wm5P3YAT6O7ANOs87w6wKBaxTJ4lFn8yXfEu6qKkzWzA3uD73BBJEprmLSkLC+Og
	7/LNxOOnseFPnYmNVHhE7huHEN8f+rV3cDwhPVwhXwZ/qVyXGiutPe0he8UA5ZMXMJfCnqr7sAMVZ
	9UCERPn+XslFADQr5pwbUhj/fMll79JfG8/Ip+hi5+1yBGUetyiMIKc/wgmBknrikuLCtJWtnH6kl
	zw33zzKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dGa-0000oM-DG; Thu, 20 Aug 2020 05:37:36 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dGW-0000m6-8u
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:33 +0000
Received: by mail-wm1-f68.google.com with SMTP id p14so504915wmg.1
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wpOKJ6QjpHxSk8GJN8+X/MWAQBNFkI88Bv7jxVJHHtM=;
 b=AdwQiusYP6Zg0XB1ZytNL9wUtFYu+dz3xxCmKZf8zoMijJpo86D0ijKure8cXvaqEz
 Zh9tZAH+NDzLNmOiG3+2p3hd2LxE33rCxNXnNgRUMo4GGLVieEMCorWxvXiP4W5m46K4
 OVhbaXyBeePlNcSjSI+2HKxCFykp4Ns28VxY+93fG7fSZ/r7jHuS90DZKnltZBATijXe
 Q/sGTyVo9tfvQwtMKAGxrZ3U3tjsyVRR7BtEKPW87j0DN5NXmsJGeoaqjkEdE9oxgZ+t
 a7u/7oB/lRXYbRBdJfQT3hMrCUdlNS+QxIL68fhf9qcz+mS03EMaFc9gtIC+6k4JvVh2
 90GA==
X-Gm-Message-State: AOAM533QDj8eSrea2aqSgQC+22HgM1uZxeuSOVOkpX9eyjC7++xbFe8x
 H0MfyZ0Rx04C+PzyidUc+QqtgmnfhrsIfg==
X-Google-Smtp-Source: ABdhPJzkRJg7KN6yOvalS6P/+M89VoPJFOMzKmpCuPGLWzji8K7mQTJ2BV96vMH5stpcEjPhEOCmVg==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr1590083wmb.96.1597901850924; 
 Wed, 19 Aug 2020 22:37:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:30 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 8/9] nvme-rdma: fix timeout handler
Date: Wed, 19 Aug 2020 22:36:50 -0700
Message-Id: <20200820053651.197057-9-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013732_375089_D4B85BD7 
X-CRM114-Status: GOOD (  21.14  )
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
 drivers/nvme/host/rdma.c | 49 +++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ed387f61f8f7..cb8731f4b316 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1185,6 +1185,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
+	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
 	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
@@ -1951,6 +1952,22 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
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
+	if (!blk_mq_request_completed(rq)) {
+		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		blk_mq_complete_request(rq);
+	}
+	mutex_unlock(&ctrl->teardown_lock);
+}
+
 static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
@@ -1961,29 +1978,29 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
 		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	/*
-	 * Restart the timer if a controller reset is already scheduled. Any
-	 * timed out commands would be handled before entering the connecting
-	 * state.
-	 */
-	if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
-		return BLK_EH_RESET_TIMER;
-
 	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
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
-		nvme_rdma_teardown_io_queues(ctrl, false);
-		nvme_rdma_teardown_admin_queue(ctrl, false);
+		nvme_rdma_complete_timed_out(rq);
 		return BLK_EH_DONE;
 	}
 
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
+	/*
+	 * LIVE state should trigger the normal error recovery which will
+	 * handle completing this request.
+	 */
 	nvme_rdma_error_recovery(ctrl);
-
 	return BLK_EH_RESET_TIMER;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
