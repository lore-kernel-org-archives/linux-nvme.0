Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA2710F3DC0
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DRU+bZBKSxxT2z3L8VYfITXheQuE4BxzAm+ofkPTK8s=; b=CVzE6gDmijvqYjzKlm+i55a3U/
	0hlq2AJnMst1ApROKM0XJtFm1x6f4ejSOXVUK7xBuzdEgUNdWssQvyN+fRZYBRAYSiopBniWP7qpr
	2B0F+ErNcu78L5jdCtGji2mNH8of+iboZtq9UHUxjBw5iLcS56FtakXrpnaDu773wc8OzdMhcbIrs
	fiNKyzDFq7ptOb6EqlN67SCpKEBuo+m7RAYhLYwFcSQ8ykNHZ4XDc1S6KAUarLq0kusm74hkUmKZl
	XqZohzGh1R62jfG0ALGSPun678W2BHrSkuerWMkU6++ornO58e3Fa6Hh1wat0AZBV5EpKgjD3eRP6
	Dq7uslKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Hog-00000008ODl-35sR;
	Sat, 28 Mar 2026 00:46:18 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Hob-00000008O4a-0aBg
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:15 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2aaf43014d0so18074255ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658772; x=1775263572; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRU+bZBKSxxT2z3L8VYfITXheQuE4BxzAm+ofkPTK8s=;
        b=N+YWoV+DQhMnaXV0oevBuLr1jVxJe5ZUt6i00kRk7mcQKLVr7TKV/rtg7NTJDooB7J
         Lj/oN+vqO0tRAeXOQ/ZOZYGaJQvmnmtQolGG1LyooFfXiKtV8ELS+Gb4ondFZbUdRwfT
         WhfR94A9B/RFEhnYdqsQGiR//I17jw2DQzxn+03ichuDle9cfdVYGBL9R7FKs013ScWw
         dHsPQ+St7vtVBqL7rn+Xodsv9TdzSSb4LWfLDahs+1U7WOp+QW/xLw7pYjt0MYf6/pfv
         YbfEDKswv3hoQZgdGOP9czEsTSpcIrQPIwaRFucriYFZ7yIt+jRSQtQXTazNRWazZakj
         w8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658772; x=1775263572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRU+bZBKSxxT2z3L8VYfITXheQuE4BxzAm+ofkPTK8s=;
        b=lcVC9koDwopUAD4PNXMR2QwUztUVzpCT7iOQIdu8UpIflmb580RGfvOsGRZeTajSly
         a01kk+0wzEdgGxeG5C1/ckIbmZFJF/WZ3Y5QZ1wu0Ax2LsZQvF8dl7IM745UBylEMmdg
         I4qFsprIIwCAejZS+0/dXki+cdcYDzmpMp+LD9is8axmHyEAAaHSIlT0QOcazX8CJJKR
         1jP04pK0YORofGQIUMXfg+RCHEOwk6mEKdHxy5IhGI/z+Aj20wwmB4MquCuEQpgveChD
         IYUyrx/AZ/QxgwgIK+q+rWbR1JAaMD3+B3skF/UI38xHAYONA3eLAnc58JetiTkItWWg
         DAIA==
X-Forwarded-Encrypted: i=1; AJvYcCUFcswdRpRf6CghibbDTw53wJfQ5ZHYJWdDnREY04nhUJNVULN+1EH8fElr6FABdJbdYw3/j4BkEd0h@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3vJ4yw/AsQTPXE5yP06odTS3aTrWid5wiFVmoDw0uyZBhPub8
	w9V2m3WlKnPhsTJE0w3WLc2hluB8f9zBHIpneL3Yn33O0N3CtvGz0RP8bSGF16e9Rlg=
X-Gm-Gg: ATEYQzwMxA1G+OnU6VZeXMyDYICAf2aBjC3QScTR41G+tb8Ki5swEukPfQODKkuotf0
	nO7TisYLeZhqqxukr2is/URwQD3XPMZ23b51P5QJyO3YyANU1Vx8McYa7DnMQa8woe5syHKM5lP
	RXdDuV+iuYJwo3UimpDTmHKt07VreEAYx3wNQO8AVsyJqPAsE18TGvxtTIxyR2ohVhmljEOsEfN
	3fRebXoPR6fR1XMNahStso3T12TeHJcSioXzZL9EL7lQsGPvfmgA71ABYTya7ZNziKmArmodFgi
	+kgvtASIjZhCELRRufYhEYodqpwL1O9S/gt4oMvxE/TJMPFogBqQ4uzV56zArkpYYo5slBy6uF4
	ahPFbEN7nly+qshn2UU/NQN3zofTWj2+2Nr7kswI9fjRM7HToJWGFJbX6Cnc7HC11q6ogKsBCm/
	mOftDNmd0=
X-Received: by 2002:a17:903:984:b0:2b0:58a8:5f9b with SMTP id d9443c01a7336-2b0cdd2137emr47738495ad.49.1774658771480;
        Fri, 27 Mar 2026 17:46:11 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:11 -0700 (PDT)
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
Subject: [PATCH v4 14/15] nvme-fc: Hold inflight requests while in FENCING state
Date: Fri, 27 Mar 2026 17:43:45 -0700
Message-ID: <20260328004518.1729186-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174613_220529_42F1FB18 
X-CRM114-Status: GOOD (  21.88  )
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
index 9f6b95415f25..eea5a90d936b 100644
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
@@ -3216,7 +3249,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(FCCTRL_TERMIO, &ctrl->flags);
-	ctrl->iocnt = 0;
+	atomic_set(&ctrl->iocnt, 0);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
@@ -3225,11 +3258,19 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
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


