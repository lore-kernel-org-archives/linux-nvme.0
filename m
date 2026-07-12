Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8670C43458
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HnswPJ/Ga8FPm48i1AzqQaejGi0bjeeJj42xEdxHH0=; b=NQwwY33YsMSkjYSuWPZJLRIAvu
	/YwuyfvwcaCQkOTPheGsVha7i/PC7++a3mw7aHl7S0nEy4wZZL04lb5h7hTWbnJt2qPLVkJz/IcLY
	121+CrKahjCviv3IknJ59v4Pey4auGGlgmio+ehKiUFozspONM0KormYhRyebNYgbi1MuSaokL+Zc
	RgXm6Irq8kNPjXKOE3Jp5/kTjLY36bGr/XBJlx1hV62tkonjXzpyzRU0k1Yg7ESVEdfLzPtTMUUnB
	RaeIYIPMWVqitMQNqnCRpmvZer/LvYEjyi72nTB7FAgVkAUCfSD8KEkKl3OQcb+L9lZcLHJaYpgvQ
	vmUuoHKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijt6-000000071st-1W52;
	Sun, 12 Jul 2026 02:25:48 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijt0-000000071l1-3NcP
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:47 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso2368875a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823142; x=1784427942; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HnswPJ/Ga8FPm48i1AzqQaejGi0bjeeJj42xEdxHH0=;
        b=HcMvsAQ7k94VsX/jA9op30Jm0wI0AxYBSuT0zCFRjfq3NwGX4R2YrcnoVm6rBORwdc
         E7Hp1CJ3AX117jZYVa9kbuDb+B+JmepZt18GO9sunJlF2e+1Fuj7p4vF5mCFD5FG/68k
         e5dNQPOaPahvpFBfh7DJWIQQKvP4yhonxfrLe4h5JUPEJJqiGJLXarM/qXCnwXSPjdWM
         HwP8/TwwdTK1IRyaaZoIbqj5bALOea/PeFeQtXeaCqMOmm0gUzhG14C2Ifni5DO36gBC
         2kTo0dYkBqCjTXYa47pUIJU5frZ1FSyBQhIvAsomt0xjsZOGJlNNoY82NUUIbV9blKv+
         b/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823142; x=1784427942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HnswPJ/Ga8FPm48i1AzqQaejGi0bjeeJj42xEdxHH0=;
        b=ET5/jJ+4IfgTimtMqOyo5o5x7dwB1cza4zHYsjvPIeOrXyn0n27Uw2dDkrwiR/Imlk
         BXpweXNWvsKGNQ46XE3mpeQqrJhIP+XowCNIIXnBD3xtu/s97tVoh1CcskYVFG3/0t6v
         cwiYBPkJOJWmdHVc4GKQHmy2LnRgFwn/nDpef/Ka41gqgTpC5id3/WBOlhBvn5ppgUKw
         OXJo2uZlgFngWyzjyCP6zKc/QuvxuLUZTJJIgCaZTH2MyfkMsi3k2aGGjUn0F6E4rcGP
         Ksfvx5LKc0OPWxabs9UNaS/284TfCZ8bek/8tfMkOunQFj87CqqCrFo6jJl38ajFa+6m
         ZaVg==
X-Forwarded-Encrypted: i=1; AHgh+Rpt8hq3sYofxHi5cnsaPEdq6PJRE/KSG7N67P4iKrvtPyrNsyH2gnktmkRAvCpqqEOHuYVkb0tdRdfM@lists.infradead.org
X-Gm-Message-State: AOJu0YwquJ8NzYlvAXrIP7H2U8KSdW3XNCiP/kBzFIDXirfKXY3iP/Aw
	iLhEUgQzYwrObbCULr7d+yYgmereGyHWTq3VWokh7u8DzS6ZSQrJD43DDRLpCfc1tnU=
X-Gm-Gg: AfdE7cmQvHo1yptWj4lUIYVMVWv7oAvK3lVTzdsG3DpkpLTys/F1FZnQY9ISvrCSK9m
	cJ5QZQ7mPbww0Fd6F9f60K+pufQY+3baZ2Gjw8ngmWbkAH6gUDzsE5WROPwh2p33BDflwMT8p5Y
	YBhwglGMVQyai/VvRr9+dsFjJC9N9YZO/CJIkot2OeqAuIyAEIiKJ8x4YrKbnoepWfTCx6hvUDg
	G9YuVYypWYN9aX83KxOQ1Rlxh8izxoGW01ZeWXqSUXMxmLLsifeu3f9cWU1mobFmFhWcPO9Q7fK
	q7UFRJm2e0587KIKTFWLb0kRr4cMs9nsURluT2w/wy09ffiy7IMIkYs99MRWpNtLIyh3lC9Ty1W
	8wPng3QlRK+gA8ok5jPVvOM4lHF8l7vCHNUokFXVPEs8ZTk5KU+PuH6iPgopgSfWFgcZTpF19+p
	nPWStZ
X-Received: by 2002:a17:90b:4c49:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-38dc774cd5cmr3948680a91.19.1783823141858;
        Sat, 11 Jul 2026 19:25:41 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:40 -0700 (PDT)
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
Subject: [PATCH v5 14/16] nvme-fc: Hold inflight requests while in FENCING state
Date: Sat, 11 Jul 2026 19:23:35 -0700
Message-ID: <20260712022437.3743117-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192542_847560_8C1BDC0D 
X-CRM114-Status: GOOD (  22.29  )
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

While in FENCING state, aborted inflight IOs should be held until fencing
is done. Update nvme_fc_fcpio_done() to not complete aborted requests or
requests with transport errors. These held requests will be canceled in
nvme_fc_delete_association() after fencing is done. nvme_fc_fcpio_done()
avoids racing with canceling aborted requests by making sure we complete
successful requests before waking up the waiting thread.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: James Smart <jsmart833426@gmail.com>
---
 drivers/nvme/host/fc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03b6c3649210..006b5a984dfe 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -172,7 +172,7 @@ struct nvme_fc_ctrl {
 
 	struct kref		ref;
 	unsigned long		flags;
-	u32			iocnt;
+	atomic_t		iocnt;
 	wait_queue_head_t	ioabort_wait;
 
 	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
@@ -1823,7 +1823,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 		atomic_set(&op->state, opstate);
 	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
 		op->flags |= FCOP_FLAGS_TERMIO;
-		ctrl->iocnt++;
+		atomic_inc(&ctrl->iocnt);
 	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -1853,20 +1853,29 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
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
 
 static void nvme_fc_fencing_work(struct work_struct *work)
@@ -1966,7 +1975,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool terminate_assoc = true;
+	bool op_term, terminate_assoc = true;
+	enum nvme_ctrl_state state;
 	int opstate;
 
 	/*
@@ -2099,16 +2109,38 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
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
@@ -2747,7 +2779,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
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
2.54.0


