Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE6E6BF3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/D5ucSFT3TCGsev1HjV6na9ZT2ASzYHwLoVd/attJt0=; b=yi1TFXR88ISeg56mlBabSPEhe1
	BphrDO+EJWi0++VwehwdPQ6t87n4bbBXUWPeUb4IM/G7qogW11DgJUaARUwqCi06/t3N9mIQc+h/J
	+hBn+j6NVOLhLUrwCdLtBbNjHe3onBwJ4JzZY5FL474/uORWGhq1wJpdG+LMBSUjYI5IXlPEWDhw0
	1YbXAK1X+FcD1TP3vuHHle/FFjtzqSItpGo2Q/Vdf0SFOOEikS3wOPn4H95UT0+/n0IVhJg4GcvZ7
	AmcF0YoR4n+6nR/cdCRzk3r6IxEPh7j731Ahr2GRyJ+x/gTvHXSKBZiVBZtsIOieEDFTtyD6XRSYH
	gePsLU7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6a-0000000233p-06DS;
	Fri, 30 Jan 2026 22:36:44 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6R-000000022rH-3GkE
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:38 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1233bc1117fso2472905c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812595; x=1770417395; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D5ucSFT3TCGsev1HjV6na9ZT2ASzYHwLoVd/attJt0=;
        b=Qs0UWHFM6hAW3KURMvgkOt29ewrpxrq9o73xacXrcWvCjvwo7aoiDXzLGhQABHjv1g
         Ng4KRhC5pSLp3IUvGFg1wBVG1gkxN8Lbh5b/BQmiAM2inEiCYv2MZC0jd85xxhXFOuhC
         6Ktoya6ALYLMnGRseQyGJUPKODLcoLRioFRjb1F4rD4LvDmi1lHiYtwxkwYSx7AQdYlu
         w1vCOAw+VJbeQbcbOzCsp0kFCy1qnmHUEhVykC45n9fgHCVEIAcEhw69KFYCBzGbvVq5
         GofLwojvJcnjl/OLb6L1ydtr54GKk4e9yVCXcBAqDMfzNWi/ndE/6KPd2qFinWg1z91D
         s8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812595; x=1770417395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/D5ucSFT3TCGsev1HjV6na9ZT2ASzYHwLoVd/attJt0=;
        b=vTv8IRFKYEwJbpa//+SLxlruAWPhVxVEVTCDEUGQHTr9YXCSPhf3CoJe0n1UZeW8WU
         28S+xqCdP7YwkWkMwEmvuFnCmBBWxTyRR0Rr7OVOO0Q58tzaj9rSCvoXKQlhk0OOpfs1
         fPosIuEWFHidm9ufqbV+5yuIW80OMNBqVHpyJLxscxWdv6wwrN3kzAxH9Som23vDHpOE
         xnzCWqjzDyOx8oaF72jzGo3DghtRIIueZHTFSpOQssQ/E9ZgTF4NGc27aRFONb5OQt/3
         esc4rU+ZF056aLQtt50p8Slfg5C3hGzandqaMoP/eVRNozEHU8tMdTelpCkVyTLlB2YZ
         Hnug==
X-Forwarded-Encrypted: i=1; AJvYcCXIj46gcq7i8RV3jCO3ctxVYKXdK1WFFoGELy7QimsMW9C4fXDU/QGxofASAgAyZN0QztGA2wJu/lUM@lists.infradead.org
X-Gm-Message-State: AOJu0YxVOIffjMClDr4hcyvmNkH+7cIwuixWOzMWx5J4D+mnWVp9pg+D
	LZ/nDdVT9utfEawtNTuxivDX8yVZMFt9be45hfZqleH+pv2wAEuHV02SP50vr5mCL/o=
X-Gm-Gg: AZuq6aIGCM3qrDFYuHPvi9p7PttaL8lEAMflVWh2vkynmRlU2YOMAvjFFa72NaZUCqy
	2AZtssnP/OpzzErWxp2U1cFqeg3JgKlK1mFgNgsDIaFkKjt24O3NaNtwgnuXy/MjKF0hbzEx2wL
	GsWjoaXXF3nfEHZiwY4w+rAdn59Gh1iK30kFtC5m9YWKhu+rXwaLw8JIQwc2Urp5zAOx409mtge
	UQxkdOZgH2EOV1ypyYGfb0/yW8jz9b69vUqSB51udzmMJj9cyxmj5RNY/Ai670t4ZyyRVqQp1XC
	tA9p1JFKLT90PCOjm8K2wyR6KqaQA0ROEoITVF8XxPfLurYbPYpNvPn1Icz9fg9kendcwa4W90Q
	AhO02eV1Kv+6EKpHieH9B+B7LT8Ve6nGex4Q7iaHyDBDw9lOcxB8EH3MHYOrghqqUf8wZYSBfVo
	a/FLTvs4GGvfMPCBpTtADe2VDDDl26Aw1buA==
X-Received: by 2002:a05:7300:a890:b0:2ab:9d23:f0b1 with SMTP id 5a478bee46e88-2b7b1848daemr3392185eec.13.1769812594644;
        Fri, 30 Jan 2026 14:36:34 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:34 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 12/14] nvme-fc: Decouple error recovery from controller reset
Date: Fri, 30 Jan 2026 14:34:16 -0800
Message-ID: <20260130223531.2478849-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143636_671668_0CBE6A51 
X-CRM114-Status: GOOD (  20.73  )
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
 drivers/nvme/host/fc.c | 94 ++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6948de3f438a..f8f6071b78ed 100644
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
@@ -985,7 +987,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
+static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1567,9 +1569,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
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
@@ -1871,7 +1872,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 			container_of(work, struct nvme_fc_ctrl, ioerr_work);
 
-	nvme_fc_error_recovery(ctrl, "transport detected io error");
+	nvme_fc_error_recovery(ctrl);
 }
 
 /*
@@ -1892,6 +1893,17 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
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
+	queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+}
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
@@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
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
@@ -2536,24 +2514,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
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
 
@@ -3352,6 +3320,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
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
2.52.0


