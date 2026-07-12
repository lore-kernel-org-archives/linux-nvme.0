Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE705C44501
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k17NZK3iZiYWXEcv1S1Cll44Lxae4D1042zuaqAzmEs=; b=PP/Kfc8hDfSwYaJlwD9EOM/Pmt
	WGTKTx7yTMRFxnf89KgvhvpFUyEYaWPx9Bz3siOuL2kmFZdQ8EomzoGkuegszogGr40PkYDNrKqUv
	zX7AYryzqVQAf3hr2fX0eo8Kbe8qmyitGdu99R+yB1Pp66SGiVspsxmS+wB96CblHzqXBwsBFQCKE
	IMC8AEh1ZnS4Nz8Ws6DNyusb/slA/W7y7UfD4I+fSB6BVCbwMjLuzzcVl6OoOxiU+17cWDEl29EyR
	y4sVUVEoOicPRuGHJvsZuYv32MrLZRj/fLg4jnBYU1eeyj7czV1kN6N6X8kCldZbbqG7rhEsccNEZ
	rfT9o3lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsz-000000071j4-217D;
	Sun, 12 Jul 2026 02:25:41 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsw-000000071eZ-3jiN
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:40 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1605121a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823138; x=1784427938; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k17NZK3iZiYWXEcv1S1Cll44Lxae4D1042zuaqAzmEs=;
        b=AuaiZshQfPfryIISIQsuyvftMcCBfhf0relbn22I6NHQRYjc5QIcAkIPFoJeGlWkK8
         1pVQO6O/DqUXxJzEPHVY1SGroNbUvTZkEqb66eQIkQYKmSApqIf0KnPBP3YxQXoTfv0s
         r/o936zQC5gIw17/H6BpX9f9qgYFT1lnJkCA7ZM44s93u1vT+B+3fwwLqQpwxoDVAGNg
         sBQ6drgugxRTEWsqiDeT5/G6zMCzRufgSumF16/PKcEdl6z2u3/TZ0tYZqKQ4CmY2wK9
         3BBFIqOH2o0mEe2UZz1uw2Uddk5g2ASVRpnyq55+Qr9kcgY/iWu+5FRNM/lvIO4ZXYe6
         2tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823138; x=1784427938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k17NZK3iZiYWXEcv1S1Cll44Lxae4D1042zuaqAzmEs=;
        b=fpKFcmejI2FdZsuuGUJaOuZr8HB12HKoZkbCkmL7YanF+JhhP4eKq78WCNxEtNfiJF
         0U+QAlcgs/W7yKo8i7NgdxrX3/CqYTaSX+qOuKIICjAOYQ7D0+tFcOF4wtPF3NYDIuc1
         ot7lpOBmBuH6C+exRzg2P92bEaHXkObo760+/cGvbN9+h0xNiPysP5Rw0hTloVzbVzLG
         7dOdq9V9x3JhBl3qyk0eujYy9gOLvsK+26Ws+iSylHTruRW/uUy89iZz9dhje58SKgtN
         8lZrFte5Aqy4Qvm6cun/65qXOn+qYTqZY/qOZrw3JbJBNVF3eJTzhGy02571DKiR3mJC
         vUdA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4DMpfLQq7tcIBRKpewvEImbWQ3LwKOQXZNXwRhJFKOTDIN6cn2M0dRY7bPedb0q3D9fzHM+7I7qjr@lists.infradead.org
X-Gm-Message-State: AOJu0YwW2ouTYMN7UIj+mMkzLLwInBWzABjbq3Z7yvL4nIutH/HsjGTf
	RyZTowrvC+CW7J6rpy4mMztZrgMwvvQHhebFZOUhckMP7EjTRw8ChNURKw/6mm4ou4E=
X-Gm-Gg: AfdE7cnP7KrX50CRfnxjJf7icC+C7wCKp6DOITcwfBg84k7GwywsQV5PngaPjyEGV1G
	YCb45VFJaaXh4wSvOIpNBTmdO/LeU+eZuTFLjiC51NMSsi/L4UjtxH7QCQH/q6q+4WYAJ+H/8d3
	Bpbi7Tsf/7OW3JX4YuWGGSr9gMTdkREa00ZvXbAs4Ne2LmPeH62CKk9xVtq776KJzcTZPpNMr0U
	y95MHohfvEzny/mCOuAXS/r+K0mOmESx9q0Qm/9lY4FcD7i3YPut1VGABCGGNnEN/MWgg0A8Z/H
	FYpePfJL27ZkrsQFORmkZgB6w0qu5rWZwDZwxxfup/DwNc82pYisivLQXa9bkl2oxlKkzMaOYwG
	kTXyvx7ratycQh357M5qYTC3vT4QMShcTgPPTOTcPBzL/XasQRI5K7/DP221qZG/YdFAvI1mFa0
	PaAy29
X-Received: by 2002:a17:90b:5870:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-38dc75faef0mr3582950a91.19.1783823138013;
        Sat, 11 Jul 2026 19:25:38 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:37 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 12/16] nvme-fc: Refactor IO error recovery
Date: Sat, 11 Jul 2026 19:23:33 -0700
Message-ID: <20260712022437.3743117-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192538_938750_29F33451 
X-CRM114-Status: GOOD (  22.37  )
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

Added new nvme_fc_start_ioerr_recovery() to trigger error recovery
instead of directly queueing ctrl->ioerr_work. nvme_fc_error_recovery()
now called only from ctrl->ioerr_work has been updated to not depend on
nvme_reset_ctrl() to handle error recovery. nvme_fc_error_recovery()
effectively resets the controller and attempts reconnection if needed.
This makes nvme-fc ioerr handling similar to other fabric transports.

Update nvme_fc_timeout() to not abort timed out IOs. IOs aborted from
nvme_fc_timeout() are not accounted for in ctrl->iocnt and this causes
nvme_fc_delete_association() not to wait for them. Instead of aborting
IOs nvme_fc_timeout() calls nvme_fc_start_ioerr_recovery() to start IO
error recovery. Since error recovery runs in ctrl->ioerr_work this
change fixes the issue reported in the link below.

Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 119 +++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..54a09db9716d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -227,6 +227,10 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg);
+static void __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl,
+					    bool start_queues);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -788,7 +792,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"Reconnect", ctrl->cnum);
 
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	nvme_reset_ctrl(&ctrl->ctrl);
+	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
 }
 
 /**
@@ -985,7 +989,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
+static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1567,9 +1571,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	 * for the association have been ABTS'd by
 	 * nvme_fc_delete_association().
 	 */
-
-	/* fail the association */
-	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
+	nvme_fc_start_ioerr_recovery(ctrl,
+				     "Disconnect Association LS received");
 
 	/* release the reference taken by nvme_fc_match_disconn_ls() */
 	nvme_fc_ctrl_put(ctrl);
@@ -1871,7 +1874,22 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 			container_of(work, struct nvme_fc_ctrl, ioerr_work);
 
-	nvme_fc_error_recovery(ctrl, "transport detected io error");
+	/*
+	 * if an error (io timeout, etc) while (re)connecting, the remote
+	 * port requested terminating of the association (disconnect_ls)
+	 * or an error (timeout or abort) occurred on an io while creating
+	 * the controller.  Abort any ios on the association and let the
+	 * create_association error path resolve things.
+	 */
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_CONNECTING) {
+		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: transport error during (re)connect\n",
+			 ctrl->cnum);
+		return;
+	}
+
+	nvme_fc_error_recovery(ctrl);
 }
 
 /*
@@ -1892,6 +1910,24 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg)
+{
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+	if (state == NVME_CTRL_CONNECTING || state == NVME_CTRL_DELETING ||
+	    state == NVME_CTRL_DELETING_NOIO) {
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+		return;
+	}
+
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
+		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	}
+}
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
@@ -2049,9 +2085,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2495,39 +2530,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 		nvme_unquiesce_admin_queue(&ctrl->ctrl);
 }
 
-static void
-nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
-{
-	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
-
-	/*
-	 * if an error (io timeout, etc) while (re)connecting, the remote
-	 * port requested terminating of the association (disconnect_ls)
-	 * or an error (timeout or abort) occurred on an io while creating
-	 * the controller.  Abort any ios on the association and let the
-	 * create_association error path resolve things.
-	 */
-	if (state == NVME_CTRL_CONNECTING) {
-		__nvme_fc_abort_outstanding_ios(ctrl, true);
-		dev_warn(ctrl->ctrl.device,
-			"NVME-FC{%d}: transport error during (re)connect\n",
-			ctrl->cnum);
-		return;
-	}
-
-	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (state != NVME_CTRL_LIVE)
-		return;
-
-	dev_warn(ctrl->ctrl.device,
-		"NVME-FC{%d}: transport association event: %s\n",
-		ctrl->cnum, errmsg);
-	dev_warn(ctrl->ctrl.device,
-		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
-
-	nvme_reset_ctrl(&ctrl->ctrl);
-}
-
 static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
@@ -2536,24 +2538,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
 
-	/*
-	 * Attempt to abort the offending command. Command completion
-	 * will detect the aborted io and will fail the connection.
-	 */
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
 		"x%08x/x%08x\n",
 		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
 		nvme_fabrics_opcode_str(qnum, sqe),
 		sqe->common.cdw10, sqe->common.cdw11);
-	if (__nvme_fc_abort_op(ctrl, op))
-		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
 
-	/*
-	 * the io abort has been initiated. Have the reset timer
-	 * restarted and the abort completion will complete the io
-	 * shortly. Avoids a synchronous wait while the abort finishes.
-	 */
+	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -3359,6 +3351,27 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	}
 }
 
+static void
+nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
+{
+	nvme_stop_keep_alive(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
+
+	/* will block while waiting for io to terminate */
+	nvme_fc_delete_association(ctrl);
+
+	/* Do not reconnect if controller is being deleted */
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
+		return;
+
+	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
+		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
+		return;
+	}
+
+	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
+}
 
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
-- 
2.54.0


