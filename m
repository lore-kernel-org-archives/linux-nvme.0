Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BCCC982EA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmH177YS3gZ19sjEKDEKKTFEFMiPIMvZkv9++g5knBc=; b=nXm7i+KBncMZ9HR5s3+xsk//Ju
	R0sxetckc8QZPvj4ufEwZRPZ44klS6/ZgEqVUu+80WX/icM91Sl8uvi43N2uDgtFFsW44zVppm7UR
	uFSRc7U9Dv8jwqj/cGArWol5GuJ4hgTNm/nFn6q18yTy3l0nF0qMwXHOVPSTjZbntRMe7dW/nzzqc
	mgYD08f2apxRteyxmOqNJ4Xt4uyrgvA48y0LQkZZ/rrmE7iMxxp+tBDDB4bB0qxIF1Df3le27C6ob
	WaZXoNSCylD/2k8BgsHq6ZT9lpNfMFRd8A5jt6HJ3+gAtuoNfQPLXAZJ6gKNhwIP/0+dc8dH7ubBM
	7gxDGAvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJE-00000000E3O-0OIP;
	Sun, 20 Sep 2026 18:30:40 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ9-00000000Dxa-363F
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:38 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1943523a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929035; x=1790533835; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmH177YS3gZ19sjEKDEKKTFEFMiPIMvZkv9++g5knBc=;
        b=e3DXyT1nzHYXLAQstHmHQxccvZq2xmgARMpCSfRARbfZmfyQRt8buqSuzo2hP/2cHQ
         xvv9WmfsS6jR1QzxDRA+bkSuGWOg16Rh6VMb2VBVlaprr0BAzeGbIMSoQi4KvQ8P7PXa
         4/K19oeyhQydNwaz0d5R6jqB0gG5iIzT5bZzOiXPREHdVQehJvGcRZIXg/onn7o83YBn
         KLwkaxkUUOt2ewbsXHA8txrz5RfEmfBlmBdvqNorqQ9/fZV7nqcgWNNViYjZOFBqUPfD
         ND8VIBo+WxZAJCrT67K3KhnY9LxgLDXkTjZrgSduVILW93jrfLWattfmkxMxehdmE8Or
         qUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929035; x=1790533835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmH177YS3gZ19sjEKDEKKTFEFMiPIMvZkv9++g5knBc=;
        b=zoPseXW2CZqwBGbBEpHHQgTcy7EbqkKMGwIjWUbR0sz/NJn9kA2JIiIJuVii/TMoZg
         lSX6GDftJm9uNNdwERh34O2Na1pYgMotuZwJtrJio1mHSNie39K1UNYgS7Z2/Ov9iw5B
         57DBtcxfLvptLCjWmLlTfGEpWtqnAkP95Tglok5Oc32Xow5ffrELFk7V4pKBI+ZW5UNi
         YPSC3DF0XvmPp47ClQhwUzZs/BnXaGJwhALQkNtjMSisCIoWNWkWHUl0JWsi7Lm2hoSE
         11o7brWlgw9DTQmu6VAWtKOiYKPihH53twBFMooLRxNyrwMJdHbnzXqZd1gg7Ash8nDQ
         VujQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO401vQ1uCYWRdbuO3/ESx6FEPs2Lv/I3jIZYHa4hIR8kp5zEB8TDmfFhOTaJKa1glDyKz1D5WByz7@lists.infradead.org
X-Gm-Message-State: AFuF++kaOjsAJHCOEVa/8//CeZleEsNyeYphyEElYLaMYlcmaZ/6kYW+
	2UG7g9PAhGaItQe/dtvJiEMCQA5VGmni9uUYOpAPTE68i4M4ign4KUTMFpWUSumlAB4=
X-Gm-Gg: AYBFou0yWlwjefLlPnc04Khp+DV0+smHpkwu4HD79cRSF9SNjcwKmPz5TwoXu5xX7ug
	QAWLnRbXkdMD4XgNX61PrcVkbOOOeCFXTAH/gG3tOHhygFF4ru3CHZvtB1aV7pzy4+vu+EKlnxf
	zMDLTuNgjfZsMYaOJ6jvLGsCO/Ej0eDvszeEjskI3R5wI1mmyT5AhLwwZl5edSFycsBGSbmA/ab
	xkwGoLTxGV0zeLR+tcrJ/p+tORjH45R61J31ROoUzZHTneXuggfoh3atNiRxgLLAewIlPiZ4Nmd
	73DHvJAvy8QagQV8S+jY5WucozePFyZGWo34k+LoPJPy6Rwa2zIycQQfEvgoFvhpCXwdiVC43W2
	TkS++vPNTWjWTs6PqVS7gu5+ojea9QyjQV0vySb0t9s2THXW6JyIODK0tI5gwG63npNricery49
	BzVDyUL2FeqtqJVw96gJSTVgGbVHpMuaiZv1St2wWAlEhAwSYCW+vQFfmX
X-Received: by 2002:a17:90a:e7c9:b0:39e:6c69:34c9 with SMTP id 98e67ed59e1d1-39e6c6935f5mr7688114a91.45.1789929034766;
        Sun, 20 Sep 2026 11:30:34 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:34 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/18] nvme-fc: start error recovery instead of aborting timed out IOs
Date: Sun, 20 Sep 2026 11:28:10 -0700
Message-ID: <20260920182936.2317916-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113035_783063_83287174 
X-CRM114-Status: GOOD (  23.44  )
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

Aborts issued from the timeout handler run outside the FCCTRL_TERMIO
window, so they are not counted in ctrl->iocnt and
nvme_fc_delete_association() does not wait for them. The association
can be torn down while the LLDD is still working on the abort.

Instead of aborting the timed out command, reset the controller like
the other fabrics transports do. All aborts now happen in
nvme_fc_delete_association(), where they are counted and waited for.

The new nvme_fc_start_ioerr_recovery() queues ioerr_work directly in
CONNECTING (abort the IOs so the connect attempt fails) and in
DELETING/DELETING_NOIO (tear down the association so the IOs the
delete path is draining get completed - the timeout handler no longer
aborts them, and a dead target would otherwise hang controller
deletion). In all other states it moves the controller to RESETTING
first. Connectivity loss, disconnect LS and IO errors now go through
the same entry point.

With nvme_fc_timeout() no longer aborts timedout IOs the reset code
in nvme_fc_reset_ctrl_work() needs to be updated to teardown the
association before stopping the controller. This is important because
nvme_stop_ctrl() waiting for ana_work or fw_act_work to be flushed can
get stuck forever.

Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48454cb7a0fc..6181cb7ea8ce 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -788,7 +790,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"Reconnect", ctrl->cnum);
 
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	nvme_reset_ctrl(&ctrl->ctrl);
+	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
 }
 
 /**
@@ -1569,7 +1571,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	 */
 
 	/* fail the association */
-	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
+	nvme_fc_start_ioerr_recovery(ctrl,
+				     "Disconnect Association LS received");
 
 	/* release the reference taken by nvme_fc_match_disconn_ls() */
 	nvme_fc_ctrl_put(ctrl);
@@ -1892,6 +1895,30 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
+static void
+nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
+{
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+	/*
+	 * In CONNECTING, ioerr_work aborts the outstanding ios so the
+	 * connect attempt sees the error. In DELETING/DELETING_NOIO it
+	 * tears down the association so IOs the core delete path is
+	 * draining get completed.
+	 */
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
@@ -2049,9 +2076,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2548,24 +2574,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
 
@@ -3348,10 +3364,12 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 
-	/* will block will waiting for io to terminate */
+	/* will block while waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.55.0


