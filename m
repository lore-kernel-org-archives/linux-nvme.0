Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EF0D10374
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Fd+Dwjm4hhF+0ivkrKhAcPCv0eUGO971dYvnW029ds=; b=hI+q+TKG28xadqwI++guTutypE
	7zb+tU81xe6CThZbKWjKTK59qbBxQKZh3IPuF3xx8OnTbmcSr+g6Gc1rZmXD/KnJ8YzNFEztEx9ii
	ML5RaPTLpaSl2G2GwsT33eL5BcC3JX64wL8bWzWldGmflH4WZPu5/Rsho0qZqKvxuxtX6ihZZ6BQN
	U9zfXRbATG+KUA4gmRoYf8dekg5rpyB7AJ6IolfGLjtu2nXPmwdimKXk+7YCBPTz/Vz2B+ZOpbc+0
	bs/GClFRxdkn1JDbgmDOraNAEUO0Yg5iHPndE0RmUnrd9+xzVSvRDrj+xc0RiWszC9Ar5RNEh3sjv
	YPd1u7uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52J-0000000EDcj-3FCV;
	Wed, 26 Nov 2025 02:13:39 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52D-0000000EDSB-2shq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:35 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2955623e6faso72382755ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123213; x=1764728013; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fd+Dwjm4hhF+0ivkrKhAcPCv0eUGO971dYvnW029ds=;
        b=eNIPHTalO6lSHCBYrDUycQGTtvCelVvA0stBzU/9cYI9DNzwDu2qw5d/zR6vafPHra
         rJxelmX5fP/1YcHt1U02cacx59Y5TjL+s+IKAF/IibD/gfq4ngdcNhTSrx5ONIpIbXRI
         5EhAscOXqwORQZzwjqf/KUKR0NesDHBM5YaQRRlEDYtnLTfDq8M/yW42Kk/UjJgO/oQK
         PKz5SNlkPuOi/GCgoqLLHD6C8nyzapYSliSaiaEb2xUDgK2GmXxtzMbcJgLZAaPP/QHw
         /biUEcQdMZy0AP9oqQxeUbgepaKhLw/e5ndPfyanxouIBasuM/+dDzTamOKUODd1kUw5
         AheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123213; x=1764728013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Fd+Dwjm4hhF+0ivkrKhAcPCv0eUGO971dYvnW029ds=;
        b=O7dpDts10Bsu4vdCXFqvIgFY0aZT+UvULrxMpIWkC561VWdg68NEliXfE6KsAMDEUl
         WONlDus6ieC6Oy3kSghhzFytl8UHKApoo4qP6jCd+oCNFzS0u/tN+xoTrHUU9x9EcScv
         y3K/drO5igN9Cwt2GfxA1NTJqVOtiZq+6ANxNqJWGVILBk34YajOmLk9Jeb4fd2b2iVs
         1AaKywA/b5nUgPhgD94df1aPxhzxjy43fCjh7bEGED0U0gx4hGq7piUzQHcz8jBid7bz
         6yUb2aGk4JQCSqNyZlj2N7fTm2swXoTLrIsKXTBI9t6pB+MMme8tYIdvq+fPY6MtsXbk
         5/+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIT21PubgVTzOWdSX+oBsKDsbtklzISfHwEXYzIUkuNn8Jrgva6kcoZMn9kv0NqmoMqxY7b18Wm2VV@lists.infradead.org
X-Gm-Message-State: AOJu0YxupgbO3wgOQFhWbCc3PN3XUOEHuzYChTyPRxL5gwg/h9HlbCYX
	R0y0eD14xHYoI5zU0WVE+G8dlgfSuU69R6T26wD/EDET0QH4XQqtyQG7TNY9lNHhh2I=
X-Gm-Gg: ASbGnctVqHe+9ORBIovoxlBFSS0bUH6tS64mDemRjuIU8uXIWxnd6/Xlr1OQgoKgJhz
	RFAq25mkuG9vOv7RVjMvrtFVQXbvfDTSDUI/kjS0vQ3QOC/BD+V8ZoVPj2Iy40VQY2dMl/tOR95
	FCkr7wPzoJt/kiA1ZT10JZAFSFQTmrHiscbGFu9DPDbjiynGtWENOoAOzLJIt7LMPiKKvBK6sgm
	FKPV1dSXX+oYD/JkpJRKn+CJHO9jiy9u5RVyvf5VRojFrsMqezvzPYYMrdwPlYILX3H7vq4OLLm
	09XxJyiAezWaRu2+K9mDrJfSJlnAMzTuKuvaT+utxGDol4UxVgym1LhNpxDhRjy3s1yYCwudhuQ
	/pB8dJLKflvYdrK13A0elMNc7b7qnfqOzS88bvJ+wXJUbM1BbFTqa6844hJYwgEnH0uIyHXPiGF
	HZoAQCUOWdpw8rovEIRpZd08j0nsvB5jOyPA==
X-Google-Smtp-Source: AGHT+IEftWKL8xzdyQ8vZoIcNNhpVSoMt6pt3C9ZSmpbTsmF4pmZ3geOTTgQi7gfbDCvEYXRw4ggSw==
X-Received: by 2002:a05:7022:2510:b0:11b:9386:a386 with SMTP id a92af1059eb24-11cbba8496fmr3723350c88.41.1764123211315;
        Tue, 25 Nov 2025 18:13:31 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:31 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 12/14] nvme-fc: Decouple error recovery from controller reset
Date: Tue, 25 Nov 2025 18:11:59 -0800
Message-ID: <20251126021250.2583630-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181333_762512_0FC3EB79 
X-CRM114-Status: GOOD (  21.53  )
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

nvme_fc_error_recovery() called from nvme_fc_timeout() while controller
in CONNECTING state results in deadlock reported in link below. Update
nvme_fc_timeout() to schedule error recovery to avoid the deadlock.

Previous to this change, if controller was LIVE, error recovery resets
the controller. This did not match nvme-tcp and nvme-rdma. Decouple
error recovery from controller reset to match other fabric transports.

Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 94 ++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..8b6a7c80015c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -786,7 +788,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"Reconnect", ctrl->cnum);
 
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	nvme_reset_ctrl(&ctrl->ctrl);
+	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
 }
 
 /**
@@ -983,7 +985,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
+static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1563,9 +1565,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
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
@@ -1867,7 +1868,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 			container_of(work, struct nvme_fc_ctrl, ioerr_work);
 
-	nvme_fc_error_recovery(ctrl, "transport detected io error");
+	nvme_fc_error_recovery(ctrl);
 }
 
 /*
@@ -1888,6 +1889,17 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg)
+{
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+		return;
+
+	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
+		 ctrl->cnum, errmsg);
+	queue_delayed_work(nvme_reset_wq, &ctrl->ioerr_work, 0);
+}
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
@@ -2045,9 +2057,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2497,39 +2508,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
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
@@ -2538,24 +2516,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
 
@@ -3347,6 +3315,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	}
 }
 
+static void
+nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
+{
+	nvme_stop_keep_alive(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
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
2.51.2


