Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5EEE6BF3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTBUoAOZYxgVE0n+ViXy9ucpXp3tnYCH0vZJ2uE2fAg=; b=V0Nnm5IHtNPDov0VGdTBgNJl7n
	K3CA6FSi+/xyRCweaBDgsPyhZkc2coKzBNm9yCFN+FPuI5LHug4kO/ZOgSDYRAq9BXiWJrb/Y754s
	0VSdLHA8dtOmbEJUUvN7/LKry2l3fJyoQ+7rob8FeX1eSv/iyYb2szWcLLkWVkZ+PK0TZy4vtb/d1
	Unqd9a2UOHDjVN4wVxJ7BtPygNH6s4WZcxozBd/EGMaJKpJIojzsv8xNhRI4ktsz//Q4CuS8lKXLk
	6pptfzMew43mQG8KQjM7WflktzIVgGffBclb9N2UQBcSCnAkrz+guNcc039e6Qhdo9rgUsA41mnXp
	40Gu4A0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6e-0000000238l-13cu;
	Fri, 30 Jan 2026 22:36:48 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6T-000000022uC-2GsU
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:39 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1233b953bebso3581382c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812597; x=1770417397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTBUoAOZYxgVE0n+ViXy9ucpXp3tnYCH0vZJ2uE2fAg=;
        b=JWMWcvI+X2muEpp/dnoYoG0pfk7V7SBbcYtsy7+6JAif2Lo9PuLxKgdAZZtILW1lAz
         /bGq5wzH0WoaDvxIoMFjEHmKRSxvG+V7s4LYqg6MrtpQ4ZratGtonZaZP9qWTf7itSU2
         S9Mjotrr4m87zX8PtCZW289CQ/iYFO9dWrsiclryLJJFmgrp90EZEFnmUGTv8/f0c4Jg
         FfHufvwWqSuB+DvtjL6jlyGlhu3sQ4vIfupVAtv9rg1IcLpfqESglhK0denLXn934dRO
         +52d8FGD+3gyPGy8daDM0OwebkjX5k61DSE12MKFB/T/McG/JqDTWHTrykMNPUwXeISD
         9fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812597; x=1770417397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uTBUoAOZYxgVE0n+ViXy9ucpXp3tnYCH0vZJ2uE2fAg=;
        b=HS/LwGPss0CutFbKhxfQx5ASC9lCmTgxX72UdsDp9uN7O9vECdrRHhnFkMre8cr0TY
         MLte65Vm5VpqyqOTHHA988l4BNtsINXG8n5zOfmOLUTrYa+jzr8xSDbMiCw+EdXrVTWG
         EOmModnTicaK9uACTV5ucM8CfPiEHLK/Lia44zAP/eTTxMG9PaLbM47QBaEoiV8zIhjE
         zKnOBYa8MPpyHC5Is/H1Aiv1pF8gXmYtigHOyQjb+rQqJiKXMrscyi9Uc+TaRtn/C/5s
         q8xLMxsXBLIITSrXW/GNvJNbcDzQbW+M3Ky4mgeiKdr2rPdWIMKWYnCWaIVOXCEl6zHl
         PvTA==
X-Forwarded-Encrypted: i=1; AJvYcCWlglzfLMV0TrhEKzp5txDSh7E/KroE4tQokANmiXxSFuB9KNlaDo9Z3Wb6CQSy3t/IULlsf/+pxu1B@lists.infradead.org
X-Gm-Message-State: AOJu0YyTJUumiB6yAw2qwZgGv7psZJ4C1oHXMazyYMbRPzUTr6+Ko1Jl
	8SjjS+V44fUE91H2VOijlSG8we/Kk0NXrxRkaU5vwShx5pQ4+STJze1qKaA+hZSMdhA=
X-Gm-Gg: AZuq6aLFz1GGpP9fNWRR4uhG/uNRL3CPJWnk0vn1qL41G5/BBYNtImQWITlwPrwvuKd
	W0qT+BB15HNFPh/O0eCZvkxhBETu/uyeI7uNdITIsQcMIh31y0CuHck5XET/WKsggE3Ba4fZzPD
	RNJBRpadMC28bEsV7TO62QRtVDv/3umO07qJ6DiTSDbK6v46CMoRI7EZ+4IFK5zlRNrWjAQxcl6
	y919mnFYXustfW2+WZIsMlLPczMgiaDi4ZZuuwM3CzDejZQhGecrZwGP15gC6cOGP5bpL3rzFJj
	vT4pMdlsdoU4cZlV5OngImNLpTZFFv9PJOn5djcED1I/Ic/WaHjKBy6fjHrbu6B9wiyvd+kdeBN
	zlSvGOEiTUhuYkkgh2XDatsxxUkXlzdwD6LgBt+oXG4i3/e8aeXI4S7XrDgPKofRZNawH59GEC9
	jWw7FczFzlHF3QCFc1y7KdJuZcp7wYVRZE6g==
X-Received: by 2002:a05:7022:6709:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-125c10298e3mr2035531c88.48.1769812596583;
        Fri, 30 Jan 2026 14:36:36 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:36 -0800 (PST)
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
Subject: [PATCH v2 14/14] nvme-fc: Hold inflight requests while in FENCING state
Date: Fri, 30 Jan 2026 14:34:18 -0800
Message-ID: <20260130223531.2478849-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143637_603305_FCDCF01B 
X-CRM114-Status: GOOD (  22.46  )
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

While in FENCING state aborted inflight IOs should be held until fencing
is done. Update nvme_fc_fcpio_done() to not complete aborted requests or
requests with transport errors. These held requests will be canceled in
nvme_fc_delete_association() after fencing is done. nvme_fc_fcpio_done()
avoids racing with canceling aborted requests by making sure we complete
successful requests before waking up the waiting thread.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3a01aeb39081..122ebd7085b1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -173,7 +173,7 @@ struct nvme_fc_ctrl {
 
 	struct kref		ref;
 	unsigned long		flags;
-	u32			iocnt;
+	atomic_t		iocnt;
 	wait_queue_head_t	ioabort_wait;
 
 	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
@@ -1822,7 +1822,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 		atomic_set(&op->state, opstate);
 	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
 		op->flags |= FCOP_FLAGS_TERMIO;
-		ctrl->iocnt++;
+		atomic_inc(&ctrl->iocnt);
 	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -1852,20 +1852,29 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
 }
 
 static inline void
+__nvme_fc_fcpop_count_one_down(struct nvme_fc_ctrl *ctrl)
+{
+	if (atomic_dec_return(&ctrl->iocnt) == 0)
+		wake_up(&ctrl->ioabort_wait);
+}
+
+static inline bool
 __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 		struct nvme_fc_fcp_op *op, int opstate)
 {
 	unsigned long flags;
+	bool ret = false;
 
 	if (opstate == FCPOP_STATE_ABORTED) {
 		spin_lock_irqsave(&ctrl->lock, flags);
 		if (test_bit(FCCTRL_TERMIO, &ctrl->flags) &&
 		    op->flags & FCOP_FLAGS_TERMIO) {
-			if (!--ctrl->iocnt)
-				wake_up(&ctrl->ioabort_wait);
+			ret = true;
 		}
 		spin_unlock_irqrestore(&ctrl->lock, flags);
 	}
+
+	return ret;
 }
 
 static void nvme_fc_fenced_work(struct work_struct *work)
@@ -1973,7 +1982,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool terminate_assoc = true;
+	bool op_term, terminate_assoc = true;
+	enum nvme_ctrl_state state;
 	int opstate;
 
 	/*
@@ -2106,16 +2116,38 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 done:
 	if (op->flags & FCOP_FLAGS_AEN) {
 		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 		atomic_set(&op->state, FCPOP_STATE_IDLE);
 		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
 		nvme_fc_ctrl_put(ctrl);
 		goto check_error;
 	}
 
-	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+	/*
+	 * We can not access op after the request is completed because it can
+	 * be reused immediately. At the same time we want to wakeup the thread
+	 * waiting for ongoing IOs _after_ requests are completed. This is
+	 * necessary because that thread will start canceling inflight IOs
+	 * and we want to avoid request completion racing with cancellation.
+	 */
+	op_term = __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+
+	/*
+	 * If we are going to terminate associations and the controller is
+	 * LIVE or FENCING, then do not complete this request now. Let error
+	 * recovery cancel this request when it is safe to do so.
+	 */
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	if (terminate_assoc &&
+	    (state == NVME_CTRL_LIVE || state == NVME_CTRL_FENCING))
+		goto check_op_term;
+
 	if (!nvme_try_complete_req(rq, status, result))
 		nvme_fc_complete_rq(rq);
+check_op_term:
+	if (op_term)
+		__nvme_fc_fcpop_count_one_down(ctrl);
 
 check_error:
 	if (terminate_assoc)
@@ -2754,7 +2786,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		 * cmd with the csn was supposed to arrive.
 		 */
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 
 		if (!(op->flags & FCOP_FLAGS_AEN)) {
 			nvme_fc_unmap_data(ctrl, op->rq, op);
@@ -3223,7 +3256,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(FCCTRL_TERMIO, &ctrl->flags);
-	ctrl->iocnt = 0;
+	atomic_set(&ctrl->iocnt, 0);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
@@ -3232,11 +3265,19 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_abort_aen_ops(ctrl);
 
 	/* wait for all io that had to be aborted */
+	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
 	spin_lock_irq(&ctrl->lock);
-	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irq(&ctrl->lock);
 
+	/*
+	 * At this point all inflight requests have been successfully
+	 * aborted. Now it is safe to cancel all requests we decided
+	 * not to complete in nvme_fc_fcpio_done().
+	 */
+	nvme_cancel_tagset(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
+
 	nvme_fc_term_aen_ops(ctrl);
 
 	/*
-- 
2.52.0


