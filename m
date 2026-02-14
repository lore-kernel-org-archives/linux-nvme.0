Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B7EF99FF
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Imu19h/MshhAGpnKdw7Is91vPSU7w8nWppIzdQ0Ksj0=; b=kILI03PEWXv6fr+MqKnkl9BTSd
	pKy+x2ppAVtZ+yxc+HFXRtvWyLQcxuwN/oGbB55oRz+RvpTUiUAEZq2a9Sm9ZZaK20rIVJJ5IPaar
	WE6JoGjp2iSp2jbor6huR/KQl5ZPkeHNU1bl7Z+eadjrr8pCcfUVikUV0FavaPPxcBFisv5fUMcWw
	dJ4BN3duKENLqlju8mPwA+evOpiSssfxAG762VE9f1CZ9l8if9bq9ZVaKpe5p2F1wPeycmSSVxGag
	BvP5ci9eOTsP9u856Pn9RJSXEVZGgqnLKH+wwL5BdWsMa7ERaVEFzOwtinUm3BCRC4bxgXbvcy4X5
	cTV2SpDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gm-00000004FCs-1tww;
	Sat, 14 Feb 2026 04:28:36 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gi-00000004F3c-0ayp
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:33 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1270be4d125so3698306c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043311; x=1771648111; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imu19h/MshhAGpnKdw7Is91vPSU7w8nWppIzdQ0Ksj0=;
        b=DDLYKtaoRv77rKhx63BI0R0cvMsTy2+rBs6QR5d54piSpHyoK17ZZ9bivtdb2+CmYa
         l/WrfSdSPcFVjQ7YVbXfKggyMJj+0YY9YrUh6faspF6niV/oU0G76DmUrQcXDzrAc2rt
         HSAVy2C78YUlUtpoqG9IAIs98JsWs93ffi5ffG4edQ4RqPifho1p1ZMExz8pIxmaRHul
         xdV8XAd/nZQ/rMxP56IiIhM0k4MR30X2oMK9k1fCiP7DuiNwFpN/f17qmpwzFCqgbFIg
         R4QqT1XZ8bDBQjmPquBUS8sPYWQx5jHYpW7Rco5PR3IFY1NSzm7RKKwpIMVu09rzBBZm
         kgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043311; x=1771648111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Imu19h/MshhAGpnKdw7Is91vPSU7w8nWppIzdQ0Ksj0=;
        b=nvo0401KJbWDpUjQSzMFWhPVEUUkgPH6MPBynBEm9EHmGpp/cV2l/1/G3BkaZLdZW5
         rqjvwurJ911Lmy88dImXPzDUER4zE/s5ha7f2f20aW0w9tDqtwxHldXbDmcn1ZO1min5
         3guDsGZPZsX24wlf2h/iqgbg94F//ZUy6KBBz9p/sFznTf0KGgoLETqWarLb7NfJDJjD
         Gw2adi9H5NxZoewpbyrQqhY7FHb97EYWReFVb3By5KAmWkyiaUNAMW0GNMdI5yToJdLV
         UHtQ6hMWYr2ZHDOwy4NeELbtPA6foM0UazbEAcIPsVTf1bAiGDBoLUsoLaM0LE3/7ICI
         vaWw==
X-Forwarded-Encrypted: i=1; AJvYcCWsHhlvbhiWH8DXoMrN06/QQmo6lMK+4/99CynPwC3UmY1+/W85oRXtOtEhkvvPPHLGfJa7UEhcY5ff@lists.infradead.org
X-Gm-Message-State: AOJu0YxUuBeUDsflZsivSWcla9jH7qM0Mr4dVdhkVEwOlPy4NDOwm5PP
	DIgJJ7ncVwV3Gk8VyA1LBlKkDnJAHfvSbfYfA/AIQeONxSnCkzyTXLlqciIeLsUs3Oo=
X-Gm-Gg: AZuq6aIkxpEqnQVitqkZZNDHbFzlAVfgkS+62RmnUPsh6ot++MhmGOOQ/bOpfK+V5xG
	Dnj1n07tqoIUwQqaUFmf0XCafa2z9nr3+7vj3Mr08QoAl9Qig/9o4VEcImK1zq2kkpfxbcFzth5
	lG8jXhCmltxt3TdVht7eyGSw0w429V60ZuQ5ZRSNsD0a8lsyLBKIHFuJXplWlp3vACFINa9R3hZ
	6kA4HlJyBQPeBqC8JMUvLV9jfZogPs+MBE637qmlI3+93I8G7ct8Fud9uzwWsmPkE5liyL+rQwo
	z1Yq+Yuog1HF3zpnUBuljrnMXo5+CZMFz/yFdn9ew8qBmVNVkL8qISJ4+KAn7EG/j0PjJs+TmsE
	lq7Y7TqYUcht9bB9ZHI91/HqIjyz4eNHeflRkkK0gVD3z2E2C4bfAqICjb6Li2EurUHOxe5+OQj
	bcsAfn38bb7H41T2FaFs4nAv2vRtOb7ebpnO90ZWdG34uGow==
X-Received: by 2002:a05:7022:6897:b0:127:337e:3301 with SMTP id a92af1059eb24-12741b6fd42mr661529c88.12.1771043310981;
        Fri, 13 Feb 2026 20:28:30 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:30 -0800 (PST)
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
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 12/21] nvme-fc: Decouple error recovery from controller reset
Date: Fri, 13 Feb 2026 20:25:13 -0800
Message-ID: <20260214042753.4073668-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202832_192522_A86F6466 
X-CRM114-Status: GOOD (  21.05  )
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

Previous to this change if controller was LIVE error recovery resets
the controller and this does not match nvme-tcp and nvme-rdma. Decouple
error recovery from controller reset to match other fabric transports.

Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 120 +++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6948de3f438a..e6ffaa19aba4 100644
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
@@ -1892,6 +1910,25 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg)
+{
+	enum nvme_ctrl_state state;
+
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
+		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+		return;
+	}
+
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	if (state == NVME_CTRL_CONNECTING || state == NVME_CTRL_DELETING ||
+	    state == NVME_CTRL_DELETING_NOIO) {
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	}
+}
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
@@ -2049,9 +2086,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2495,39 +2531,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
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
@@ -2536,24 +2539,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
 
@@ -3352,6 +3345,27 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
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
2.52.0


