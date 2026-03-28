Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547F110F3DC1
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sSkFes/5fA1bp01fQEuWfHcBjcSfktFD8AXFBwgiedE=; b=i/cswPkFiAp+Dy1CifwrYDgb+K
	bVclkxkg6iByzSX3g2uV2F2gVsEuirNPxHVQf6W45STM+osSeKk6srtggP34t9BTLBpXbmMYte04I
	LIILlMRE/Iz9xiSsviZfQDEwig46OF9WN+hduEQyzBZsLRcPyA/I2RvL3ESkSSlRzP0Z56mwhIEV1
	9bazaEzVTpAwqYV0ddWC8mnVUztOI44I8iphdo9R4rQh9CpkWkR4gl6N6lZFULwKZOdH2mBF3YIw/
	YZDjKQ3Sx4lPKWa6OARyIYxIEYlDydFhM4KxwujKyXCANfkCoTrA5sgN3s6/i0AEd5IO/bomUoFzJ
	Cg7hafGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Hoc-00000008O8p-3XQJ;
	Sat, 28 Mar 2026 00:46:14 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoX-00000008O1l-2RwA
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:12 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ab39b111b9so12319755ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658768; x=1775263568; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSkFes/5fA1bp01fQEuWfHcBjcSfktFD8AXFBwgiedE=;
        b=An060r94niMXxqEHTowOOW1tjt+7ObG1HrNN24QFBnWFsFRRV+K/l/njHj6F3HfRL+
         xbfBnu3EsYNautLVvBFIjxiyabtT2WbFYRDUJdzmLP+PFRTEf7fGtM1t2orNfAi5jhWs
         KDYbNTj5Z677pejJjqf3bp5cHh8NgAWlcm6ebeYhX8bEym5/xZKHoi0EeJW7Gs47G8xn
         Y/3tHC6pjOtQJ6u0Bq4Mibc1T3MQ8t1u29pehXeZj9KUA+ekAtxAP+JK1tFIkvRrEN66
         tOVTaHutXzmvd81W2Ll9tgLrfrHOFSUb3PNPRSqaqUwrWmOrqbqrBPwuEGb0IkCQCT15
         GTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658768; x=1775263568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSkFes/5fA1bp01fQEuWfHcBjcSfktFD8AXFBwgiedE=;
        b=ETLU+qW+uDROplxHtg9HG9yaSvoiXRzQ9zK8VH/nTexdC+DOPpoDRZNFTE5Wgo3J3m
         deAaY8eNsgCQlGYJQOO3M1uHUSNRGAbBejKl2dSyQKGSu1+trKXUKhVhT6sFa/hRCcEr
         l562AfPrlmqXKTZSD9ryEST6NwZ44xGnZllg+R6VYP4MSR3BM29d0I64OUzWBAnn/drd
         kZcVzr5knsj4N0ASPwxfAilLEFEiKZIYjEV5m782Txo4GSa8xkUoW6XFpmMCpey5gS7P
         sARRqrkh+tKW4K+3ZcDEWosd602ZbhhrdeVFMIUYxPDjMVMY6vWaTrcTLmcqZYtjr2ez
         z18g==
X-Forwarded-Encrypted: i=1; AJvYcCV3mA44j7f6t+0nUeMHiKhBPOT4ZTQRuk+mpNpBjQjTq/0vBH+/uOrhsW44Nem5kNZdQmcJ1f3LkZ1s@lists.infradead.org
X-Gm-Message-State: AOJu0YzZXuTVkXPG/2wxT+KKb91x0MKFSBD6Yucg9TQFiPWcSG7tFoi5
	EDSU3xv3ImFz2jFs9lRb9ycfh8HudYEYnn1qxcS5cxiwXbAtQK9WSLo7KTnS04Xwg1U=
X-Gm-Gg: ATEYQzwyi+OWcjFOwilQaEK4tgUKMqmXQI+A1sIe4YGme3WE13QZsjf1WOJKtXO6ANL
	PnkewP9VQFK6adeCTooDXzNZTxvDgXKzaL3diFu5jKScI2HUz2Byc2zFUNhSBZ3+/AB+3llbL2u
	T7oQUAqoM8ukI30q96A0GxaD2n/ej/yKC5jlbpzGA2RLKLfKqUF8Ul7yTbtHF+qWWO8Y1VThwOh
	+iaQj23RZzMgq+dJOFgqMgHWK8qJUDsP5AFMrZrv8Zaq8PYCAXjPS5wf/dgd46kWJZIg++cjvi1
	sESDPfiS/E9w8ZsBL7z6P3P8Uhoh8l32BLsV161pN+c6Pf60zs0SoxoFJcgfoeqH8VLaIE86KRJ
	jgx3WwxSs8+3gbj+7ZQnrRUOeNWqIqXZt222EK1OuYDjKeJ0CCwo/z/81zv+8XRzAFpsNSAUeE5
	ypIo+Qy60=
X-Received: by 2002:a17:902:c946:b0:2b0:7a27:bb2b with SMTP id d9443c01a7336-2b0cdcc6df4mr50453325ad.34.1774658768443;
        Fri, 27 Mar 2026 17:46:08 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:07 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
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
Subject: [PATCH v4 12/15] nvme-fc: Refactor IO error recovery
Date: Fri, 27 Mar 2026 17:43:43 -0700
Message-ID: <20260328004518.1729186-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174609_642113_1CBAE810 
X-CRM114-Status: GOOD (  21.87  )
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
index e1bb4707183c..6797eb17917f 100644
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
 
@@ -3352,6 +3344,27 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
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


