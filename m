Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A15606A8B9
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H762j5x/;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=bFJ/oLnk;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Z96IqWWh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sPGugwP5a+NZDPLjjDFcrKI3MvgB5lVarOa98f6lAQY=; b=H762j5x/ZRv5BP
	YrP1/28KC+pGm1bgMbJjdZty7qPCjhvWlWiGdOd3TEAIeneX8srrMyefZUTB6sKMLGjiouOJtmW1b
	Nv8LL7hzeSUm6ssDH+f9Gbl0h46IgB+rsVki/OOVqwxnGSvDUeT1O8T2gDq1IzpX5Dlwvqqjgj9rr
	JHwAzj1+Npr1ghSehnDHLpEwdFl1e+xk+fwHY6QViKEMIaevmaL4rZUKG7kqvv+U/X4aZzxR3yKxu
	Bc30mvZnqYfM+x54ys+Wrv4Qi4GleWa86/gJvOxgXbx0554ASygCQIE4qQ9L+4TtoHviitom6wKbI
	KAyzA34pFxRhs/fo2zig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS460-0000000FAdD-2ktc;
	Sat, 14 Nov 2026 03:06:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45s-0000000FATJ-10tI
	for linux-nvme@bombadil.infradead.org;
	Sat, 14 Nov 2026 03:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sPGugwP5a+NZDPLjjDFcrKI3MvgB5lVarOa98f6lAQY=; b=bFJ/oLnkY5Bq4eLnKjTX7stCHP
	xtmLKrVwZvHSNYbSR8IE39YHJlGVZk8JOfQzZSVw85VKT1yDGPrz8B+Yucu1QO0t4shxhfC//594l
	5WMl2OHBxXaHK7RJvT/QmQtVdB2kW27NMPt9ZngKHzofZY6+Y/2B6ZunEaxgiMuiI6IwRu6yJJhse
	o/dRiAq3f8W8YOTX8/YsdhjeSAFPi3SC1kFVxo6dtbU2r5K/yk6lJ/qOLMQnqdWGIX1d4WLBS1UcM
	vRuVVadzkHbz12PYwgnrTqEdrgwfwCQwjBk58VsFiyLsnNFl+UKNEddw2KfxNSFMSG0wearykc1F3
	2xOgTg7g==;
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45h-0000000C5Zi-1L8N
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:18 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-37628596783so2860708eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625567; x=1795230367; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPGugwP5a+NZDPLjjDFcrKI3MvgB5lVarOa98f6lAQY=;
        b=Z96IqWWhlTjv4DPyjASlVpUjqpqAqXwi/yeakJ42ybXSlRjjKLXNCPcy1kjXtQUd/n
         ujBzSW0L0KPXpLhbqNauNwQrVsq/UOXZReqaJ1ef+A7usHKNNRPw3ZzgFZKVJfBSkJaH
         qcRiHwV/X1A9/Uudqr/M8zaxLIFWEpKcIaWQTwdzakCZoPOFrpYSMEjS+4uMhrMN5dGh
         ercFDA6MN1wiQZP1Sy2IxqBjrWDEGF2ZeWVxBUzSAlJqP2i1Ua6z3qeB5y3O8hyAfHHw
         ocEWdV4IYp5xHgAO8TmLC338sgDGnWnQ2ZwWEKatt4ys/G1jDArWDyEdjSUpPjTUEp9b
         s65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625567; x=1795230367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPGugwP5a+NZDPLjjDFcrKI3MvgB5lVarOa98f6lAQY=;
        b=D2P9TjY/7TeBQN+XLRSOrKw+4RHW1rIAP7FC/mTrvC2jateWgPFERAMns8/IWcge3G
         Yg5elaa7OMEWARJksQpAa1kXKbeCX4cXHt+RjUbBm0I29+zBONprt3wxVWx9XEqILIfP
         YuO3yPeMbY+fr6m/37hzB+2bW+0eFHiP/tgKgz4gHZ3vjh+cmhFiy9rTy9//oBFIdAZK
         yCNrgF/tDUcux71TYzzmP83PxTD4DEIEP2lYCs66fWvgZzfahfs3T2BmmMRW4r2HcZXE
         S0nO2vZA3KSpt4CMY/w1IGbM25YmGiBBbyfw92FcgGAVjJ5ujdOBlYQuZna8C5nx9ZDS
         CjWA==
X-Forwarded-Encrypted: i=1; AL+hErGuLMx3t6da3Vd93V+T93r5bVVtHhspB4LLUZPzEuEzm5wKRGEcwmANOfOJ+dma9Rdfd0al8mQP/Iej@lists.infradead.org
X-Gm-Message-State: APuU4Z8khi5UumOgKqKrDjyGM0vxTeIqioulp1mH9xa/6u+Kg3z9e0rr
	OsrMdyw5X1JWItXZ+0dzqxy2FMR/KKR49/BnqgZmNjps2SN6sEmSPHnrLJL87dxbbWI=
X-Gm-Gg: AYBFou3P2gTGylKdFCyOpfWvbfX3bKDyG9U7VcQAbozIWWhjaCzZjwRArlQdEJak9xo
	8RqnRBSZKM/CZ9NsIAkKVnnDHSLFuXYIPiZx6GbmnqTRndrBbmqjg2RWR91i36poC1mnrozExAd
	UycoCWmYR5os8oGA1nF+YoYKRUX5a64Nsp8/hrGVzmInqeiRxeel56CnJzLHDM9f6xbs9j+849R
	98zo4ij91BIkrAvLa7EFjIxRKw0PWhBEk/WDRZo5Vs7TI2VXGoAH2P+FIEwGl43DPMu1XrRp0qg
	JxMeqEBJUiqCF4v16y/2XOiHLi/+u9AEWGHfN1eeIQd0903zN2I1JO7TscEz8vWg1su4Opqp1JO
	26Du8zDUckFvG5HsW54rquxBdtL88MPMVRRIPelhHZp/0jDoylRkKcTSUoW409VlBmLKdqKaH9P
	HSygsSKI1zzdKfzxQh+yYixraJnsPlzI9mvOpWQJtvaS734iPA6i33SZPa96v9kdhuHFuCaSfOy
	wjq0rJhymW4irvmHXqG9Tws6i80weJvPlZuQMv2dx4sX32PXEKSz6zm9HSxx9f0KRjEDcarKYyA
	+dPdU+mkOX/LuvPqnwcGQBq29vfPF/rldOGSjqiI4Nio/6GVAKdR
X-Received: by 2002:a05:7022:c89:b0:1b5:227:7d1f with SMTP id a92af1059eb24-1b5030d765dmr3707627c88.11.1794625566343;
        Fri, 13 Nov 2026 19:06:06 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:06:05 -0800 (PST)
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
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 15/17] nvme-fc: Hold inflight requests while in FENCING state
Date: Fri, 13 Nov 2026 19:04:29 -0800
Message-ID: <20261114030454.2836543-16-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_030609_922605_E966A323 
X-CRM114-Status: GOOD (  36.00  )
X-Spam-Score: -0.2 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a controller enters FENCING, its inflight requests must not be
completed until CCR or CQT guarantees that the target can no longer
execute them. Completing them earlier lets multipath resubmit them on
another path while the original command may still run on this one.

nvme-fc currently cannot hold requests across the fence.
nvme_fc_fencing_work() tears the association down first, so the LLDD
can finish unregistering the remoteport/localport, and
nvme_fc_delete_association() completes all requests as part of the
teardown. nvme_fc_fcpio_done() also completes requests that finish with
an error, which happens to every request aborted by the teardown.

Split nvme_fc_delete_association() in two:

 - __nvme_fc_teardown_association() aborts outstanding ios, waits for
   the aborts to drain, sends Disconnect, deletes the hw queues and
   marks the controller inactive on the rport. It completes no
   requests.

 - nvme_fc_flush_held_requests() completes the held requests and
   unquiesces the queues.

nvme_fc_delete_association() calls both, as before.
nvme_fc_fencing_work() calls the teardown up front and the flush only
after nvme_fence_ctrl() returns, before moving to FENCED. The queues
stay quiesced in between, so nothing new reaches the dead association.

In nvme_fc_fcpio_done(), start recovery first and hold the request
only if the controller is FENCING afterwards, since a held request is
completed only by the flush that fencing_work runs. If the claim fails
because a reset, a delete, or a connect in progress owns the controller,
the request is completed at once and that owner finishes the teardown.
A held request cannot be completed behind the fence's back because
nvme_fc_timeout() returns BLK_EH_RESET_TIMER while FENCING, and
nvme_fc_start_ioerr_recovery() does nothing in FENCING.

Track held requests explicitly in op->state with a new
FCPOP_STATE_HELD, and have the flush complete only those. An op enters
HELD only through cmpxchg(COMPLETE -> HELD) in nvme_fc_fcpio_done().
For each busy request, the flush does cmpxchg(COMPLETE -> IDLE) and
cancels the request only if it saw HELD. This settles the race with an
nvme_fc_fcpio_done() that has already moved its op to COMPLETE but has
not yet decided whether to hold it. Teardown does not wait for such an
op, since it was no longer ACTIVE when the aborts were issued:

 - nvme_fc_fcpio_done() wins: the op is HELD and the flush cancels it.
 - The flush wins: the op is IDLE, the hold cmpxchg fails and
   nvme_fc_fcpio_done() completes the request itself.

The flush must use a single cmpxchg. Reading the state and then acting
on it would let the op become HELD in between and leave the request
with nothing to complete it.

Both cases rely on the flush being the only thing that can move an op
out of COMPLETE behind nvme_fc_fcpio_done(), so make
__nvme_fc_abort_op() use cmpxchg(ACTIVE -> ABORTED). It used
xchg(ABORTED) and then restored the old value if the op was not ACTIVE,
so for a moment such an op read as ABORTED. A hold cmpxchg that ran in
that moment would fail and complete the request in the middle of the
fence.

Count an aborted op down only after nvme_fc_fcpio_done() has completed
or held its request, so that teardown, once it stops waiting, knows
every aborted request has been decided. The count-down now runs outside
ctrl->lock, so make ctrl->iocnt an atomic_t and wait for it with
wait_event().

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 171 +++++++++++++++++++++++++++++++++--------
 1 file changed, 139 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 095adc9011cc..5e8977ad51cf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -83,6 +83,7 @@ enum nvme_fcpop_state {
 	FCPOP_STATE_ACTIVE	= 2,
 	FCPOP_STATE_ABORTED	= 3,
 	FCPOP_STATE_COMPLETE	= 4,
+	FCPOP_STATE_HELD	= 5,
 };
 
 struct nvme_fc_fcp_op {
@@ -172,7 +173,7 @@ struct nvme_fc_ctrl {
 
 	struct kref		ref;
 	unsigned long		flags;
-	u32			iocnt;
+	atomic_t		iocnt;
 	wait_queue_head_t	ioabort_wait;
 
 	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
@@ -990,6 +991,8 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
+static void __nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl);
+static void nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl);
 static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
 static void nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status);
 
@@ -1828,12 +1831,11 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 	 * path, must not still be in progress in the LLDD then.
 	 */
 	spin_lock_irqsave(&ctrl->lock, flags);
-	opstate = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
-	if (opstate != FCPOP_STATE_ACTIVE) {
-		atomic_set(&op->state, opstate);
-	} else {
+	opstate = atomic_cmpxchg(&op->state, FCPOP_STATE_ACTIVE,
+				 FCPOP_STATE_ABORTED);
+	if (opstate == FCPOP_STATE_ACTIVE) {
 		op->flags |= FCOP_FLAGS_TERMIO;
-		ctrl->iocnt++;
+		atomic_inc(&ctrl->iocnt);
 	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -1863,19 +1865,27 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
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
-		if (op->flags & FCOP_FLAGS_TERMIO) {
-			if (!--ctrl->iocnt)
-				wake_up(&ctrl->ioabort_wait);
-		}
+		if (op->flags & FCOP_FLAGS_TERMIO)
+			ret = true;
 		spin_unlock_irqrestore(&ctrl->lock, flags);
 	}
+
+	return ret;
 }
 
 static void nvme_fc_fencing_work(struct work_struct *work)
@@ -1894,12 +1904,14 @@ static void nvme_fc_fencing_work(struct work_struct *work)
 	 */
 	nvme_stop_keep_alive(ctrl);
 	cancel_work_sync(&ctrl->async_event_work);
-	nvme_fc_delete_association(fc_ctrl);
+	if (test_and_clear_bit(ASSOC_ACTIVE, &fc_ctrl->flags))
+		__nvme_fc_teardown_association(fc_ctrl);
 
 	rem = nvme_fence_ctrl(ctrl);
 	if (rem)
 		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
 
+	nvme_fc_flush_held_requests(fc_ctrl);
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
@@ -1982,7 +1994,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool terminate_assoc = true;
+	bool op_term, hold = false, terminate_assoc = true;
 	int opstate;
 
 	/*
@@ -2113,22 +2125,58 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	terminate_assoc = false;
 
 done:
+	/*
+	 * Start recovery before completing or holding anything. A held
+	 * request is only completed by nvme_fc_flush_held_requests(), which
+	 * fencing_work runs once the fence is over, so a request may only be
+	 * held once FENCING has been claimed and fencing_work is guaranteed
+	 * to run. If the claim fails because a reset or a delete already owns
+	 * the controller, the request is completed below and that owner
+	 * tears the association down.
+	 */
+	if (terminate_assoc) {
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
+		hold = nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_FENCING;
+	}
+
 	if (op->flags & FCOP_FLAGS_AEN) {
 		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 		atomic_set(&op->state, FCPOP_STATE_IDLE);
 		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
 		nvme_fc_ctrl_put(ctrl);
-		goto check_error;
+		return;
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
+	 * If the controller is FENCING, do not complete this request now.
+	 * Move the op to HELD and let nvme_fc_cancel_held_requests() cancel
+	 * it when it is safe to do so. HELD is only reachable from COMPLETE
+	 * through this cmpxchg: if the cancellation has already walked the
+	 * tagset it moved the op out of COMPLETE, the cmpxchg fails and the
+	 * request is completed here instead. Either way exactly one path
+	 * completes it.
+	 */
+	if (hold && atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
+				   FCPOP_STATE_HELD) == FCPOP_STATE_COMPLETE)
+		goto check_op_term;
+
 	if (!nvme_try_complete_req(rq, status, result))
 		nvme_fc_complete_rq(rq);
 
-check_error:
-	if (terminate_assoc)
-		nvme_fc_start_ioerr_recovery(ctrl, "io error");
+check_op_term:
+	if (op_term)
+		__nvme_fc_fcpop_count_one_down(ctrl);
 }
 
 static int
@@ -2803,7 +2851,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		 * cmd with the csn was supposed to arrive.
 		 */
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 
 		if (!(op->flags & FCOP_FLAGS_AEN)) {
 			nvme_fc_unmap_data(ctrl, op->rq, op);
@@ -3261,22 +3310,22 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	return ret;
 }
 
-
 /*
- * This routine stops operation of the controller on the host side.
- * On the host os stack side: Admin and IO queues are stopped,
- *   outstanding ios on them terminated via FC ABTS.
- * On the link side: the association is terminated.
+ * This routine tears down the association on the link side and releases
+ * all LLDD resources: outstanding ios are terminated via FC ABTS, hw
+ * queues are deleted and the controller is marked inactive on the
+ * rport. Requests that nvme_fc_fcpio_done() decided to hold are NOT
+ * completed here, the caller must follow up with
+ * nvme_fc_flush_held_requests() once it is safe to release them.
+ *
+ * The caller must own the ASSOC_ACTIVE bit (test_and_clear_bit()).
  */
 static void
-nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
+__nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmefc_ls_rcv_op *disls = NULL;
 	unsigned long flags;
 
-	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
-		return;
-
 	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
@@ -3287,8 +3336,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_abort_aen_ops(ctrl);
 
 	/* wait for all io that had to be aborted */
+	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
 	spin_lock_irq(&ctrl->lock);
-	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irq(&ctrl->lock);
 
@@ -3323,13 +3372,71 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
 	nvme_fc_free_queue(&ctrl->queues[0]);
 
+	nvme_fc_ctlr_inactive_on_rport(ctrl);
+}
+
+static bool
+nvme_fc_cancel_held_request(struct request *req, void *data)
+{
+	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
+	struct nvme_ctrl *ctrl = data;
+
+	/*
+	 * A single cmpxchg decides who completes this request. If the op is
+	 * HELD, nvme_fc_fcpio_done() is done with it and we cancel it. If it
+	 * is still COMPLETE, nvme_fc_fcpio_done() has not decided yet: move
+	 * it to IDLE so its own cmpxchg to HELD fails and it completes the
+	 * request itself (nvme_fc_complete_rq() sets IDLE anyway). Doing this
+	 * as read-then-cmpxchg would let the op become HELD in between and
+	 * leave it with no one to complete it.
+	 */
+	if (atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
+			   FCPOP_STATE_IDLE) == FCPOP_STATE_HELD)
+		nvme_cancel_request(req, ctrl);
+
+	return true;
+}
+
+static void
+nvme_fc_cancel_held_requests(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
+{
+	if (!set)
+		return;
+
+	blk_mq_tagset_busy_iter(set, nvme_fc_cancel_held_request, ctrl);
+	blk_mq_tagset_wait_completed_request(set);
+}
+
+/* Complete the requests nvme_fc_fcpio_done() held during the fence */
+static void
+nvme_fc_flush_held_requests(struct nvme_fc_ctrl *fc_ctrl)
+{
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+
+	nvme_fc_cancel_held_requests(ctrl, ctrl->tagset);
+	nvme_fc_cancel_held_requests(ctrl, ctrl->admin_tagset);
+
 	/* re-enable the admin_q so anything new can fast fail */
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(ctrl);
 
 	/* resume the io queues so that things will fast fail */
-	nvme_unquiesce_io_queues(&ctrl->ctrl);
+	nvme_unquiesce_io_queues(ctrl);
+}
 
-	nvme_fc_ctlr_inactive_on_rport(ctrl);
+/*
+ * This routine stops operation of the controller on the host side.
+ * On the host os stack side: Admin and IO queues are stopped,
+ *   outstanding ios on them terminated via FC ABTS.
+ * On the link side: the association is terminated.
+ */
+static void
+nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
+{
+	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
+		return;
+
+	__nvme_fc_teardown_association(ctrl);
+	nvme_fc_flush_held_requests(ctrl);
 }
 
 static void
-- 
2.56.0


