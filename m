Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D00C982EA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jjZqkSxtF056SbAAw5d/uzyUYxqOIAwzrV4C8XoM0U=; b=a3xeYIIam/HLtzM9WJ5lNz8cke
	Zd8HgPjEZXcrIUt+ksCJ3jOdJCvIUFSh076m5jOwbgg0kjcag71Lv+JQ7CO4tp23RgAF0FlPOTIHy
	4REph/QVDOGrgcVVaIXSirEqgyXRcgAXf8BOQhLqnDP9/j2ewTvucpe+X6KFUdlfxk6yki51EIgzc
	iEls9XBPUDpMZLKJzxKYlO2qXQRWzJiA4RfS5MWvVvieoFrDFHz96aHjALYvkS+5QyyEHRMTP852+
	fuvHxDg+k9sMNVULDYDJcz/PCGKmbSt+E2UresCrquE4BxkQ3KATAoFdtsO4Ij8ixj+2DLPOhbY94
	0GCBvfwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJM-00000000EHD-1aQD;
	Sun, 20 Sep 2026 18:30:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJK-00000000ECW-1Uzs
	for linux-nvme@bombadil.infradead.org;
	Sun, 20 Sep 2026 18:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7jjZqkSxtF056SbAAw5d/uzyUYxqOIAwzrV4C8XoM0U=; b=Hl7H3eOlLiI6g9AdSHScZ6t8QA
	NKJBEG2HZWKNABrahlXyEG0cL1fcDposTfPy6bE0t1cBW7lM7oBbXLvtpMm+50pLgmPfoWcZcXJMx
	1MXPqkHYP7avbxlGD3MUDutPcyUvxyYHheyA168bDRAPIQNz3VL9LjKswSZmdbPBgsnKCmkag9I1r
	ilxAyXcPqsuxYNMLakyAQfZz1vHicj15/lhguWohOCIhjSLKBvR7jugFAlUm3AfFAx/AmGPPTCYzS
	VIvVwSZ3g5s7nDHE4sCDuS+y/N3ziT2SZgqF2vUlamQbFGyhni5QOdkqCI4U21MOV1CUsJLEeBQDz
	9r2ZqOwQ==;
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8MJG-0000000BXiO-2MVF
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:44 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c3304784so1990756a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929040; x=1790533840; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jjZqkSxtF056SbAAw5d/uzyUYxqOIAwzrV4C8XoM0U=;
        b=AulVF+7n1TamiiaD6sbzO3AI30lDbFPDZQMoCNqz3ACat9WBp/SWgGZMV00d7+JkQg
         4QtZJZXHkRsxrRkz/5TG/4E8B+eBBcZu1mGIHvA3Hd+SYZkgn/1ztaZBTBBhZfnKc/gg
         tIi2QRayheVTs4xjdezaBKLVpd98eDnCE98Yg1Oa5sn+q0fnOoWvGNS0n3i3ww1GVYQI
         kHVogKGIXk0p/yjIKGxHOzB3JCUeJnNjCpWmtlRfLKdZJBkaVWn8dNMVzDRaSJBQW0P9
         SG/VMfH1C+lf0FDOW47obajC+ZxWxnNchYMLvRdcCm3ofCMgWrVxofYuOfXcAGA3wkTo
         o2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929040; x=1790533840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jjZqkSxtF056SbAAw5d/uzyUYxqOIAwzrV4C8XoM0U=;
        b=gxu7b/mONmvtww0i1H0LpdVwT04d0Nh4AC4Nrme9H/n8WFeOWyKAha7SUieB5y1rgo
         XoaxKMVZMed5t/12flg3iz7ah3I1Xm6uv+imr+OJEQKK0Vwm7bmp8QzzvHfks5hjDdZr
         bmFofpCHHz30KjPX8xhHZF2UAdWa0uxiV83KZR2HFheW4Q63j11l6oqjNFyhbWeGZ+km
         CIUjwlYp9yhot1ULgbrPE1WlWGdU7Mj6NrDEU97KQkGSXNkWgMkjT1KcgrNnJlWhXUSW
         dcQUS2e4FXxy0LUsG6ddU5bc4HkJRqie7vm0R5skyG/gSGcNt0I4uzvRKYQYAzbM0AA8
         TVYg==
X-Forwarded-Encrypted: i=1; AKwUvByFPUUmwsPNQfrDGTIe2YIoaCsO3BdeoFcHuP5MiDrA+LSms2McGP67XEeAWIWw0gISf70LvLHKQPST@lists.infradead.org
X-Gm-Message-State: AFuF++lX2ICkaLL2rTdZa4fxaWRukwyb2F2Ric1VpMS0n70/0PAszqdt
	b6yYsrd4DboquywF0OnvXeNGaeIMq9FHLuxZO/fBcDhnETsMTDiTZWNxyZagEP4G9l0=
X-Gm-Gg: AYBFou2MZI+Nzw78S0kd82T+8UUHXhWMMtvgjd2Umpn9E53Zl7ci1Zv4tF2notuLFkO
	K8wf9fmtOvUt0WtkVTT/ZEEwJeqR8waaPJr13s2NCwQ/Hlxiwq0IODjiw8dNvWSf+7xDDGMoQWG
	g2m2f/ammmZz5bNfy1YUyacmbZcDDmHdTFxGL3q4Zj3wE5xqvXxR4dtl0nR5mAgva/ujP92zUxs
	AHUCHVutpt8tCobPbhSw+eB2E8Nrf6cMow/KQAU4fBLxXKN5dS7EMUwwPhuP7ycf+L7dmn4XAKf
	WptqKFmcPJbNMxikQMg71pbRLRqkACHw+eaG548aGB7LMFXHWSrXqV9clEbS9qN48AipcEDu+KV
	Nd3Pmm9cVRxBeAy3K3/+RyoADIyP3AxuDkOwzxCw/AwWdN7ppYA6SwuC5w/BnqqaWg3aT7w71Up
	PBMnzPhsr3dFLNM1PkEeTY6WuJXVNDivjzbxZrKtU6SfHjjyMPhjtt4P6a
X-Received: by 2002:a05:6a21:1f82:b0:3dd:a197:cf29 with SMTP id adf61e73a8af0-3dda197d873mr6832729637.77.1789929039375;
        Sun, 20 Sep 2026 11:30:39 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:38 -0700 (PDT)
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
Subject: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in FENCING state
Date: Sun, 20 Sep 2026 11:28:13 -0700
Message-ID: <20260920182936.2317916-16-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_193042_770296_9E3306DD 
X-CRM114-Status: GOOD (  28.04  )
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

With the association torn down at the start of nvme_fc_fencing_work(),
canceling the held requests inside nvme_fc_delete_association() would
complete them at fence START, letting them fail over to other paths
before CCR/CQT guarantees the target can no longer execute the original
commands - defeating the hold this patch introduces.

Split nvme_fc_delete_association() into __nvme_fc_teardown_association()
(LLDD-facing teardown, no request completion) and
nvme_fc_flush_held_requests() (cancel tagsets + unquiesce queues).
nvme_fc_fencing_work() now runs only the teardown half up front and
flushes the held requests on the FENCING -> FENCED transition. The
queues stay quiesced across the fence so nothing new reaches the dead
association.

Update nvme_fc_fcpio_done() to not complete aborted requests or requests
with transport errors. Held requests cannot be forced out mid-fence by
the block layer, nvme_fc_timeout() always returns BLK_EH_RESET_TIMER and
nvme_fc_start_ioerr_recovery() is a no-op in FENCING state. Every held
op is FCPOP_STATE_COMPLETE before the fence starts (aborts drained,
synchronize_rcu() done), so the flush never touches the LLDD.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 116 +++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 42671cca439f..a6e0fa2dc341 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -172,7 +172,7 @@ struct nvme_fc_ctrl {
 
 	struct kref		ref;
 	unsigned long		flags;
-	u32			iocnt;
+	atomic_t		iocnt;
 	wait_queue_head_t	ioabort_wait;
 
 	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
@@ -991,7 +991,8 @@ static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
 static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
-static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
+static void __nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl);
+static void nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1826,7 +1827,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 		atomic_set(&op->state, opstate);
 	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
 		op->flags |= FCOP_FLAGS_TERMIO;
-		ctrl->iocnt++;
+		atomic_inc(&ctrl->iocnt);
 	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -1856,20 +1857,29 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
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
@@ -1885,12 +1895,14 @@ static void nvme_fc_fencing_work(struct work_struct *work)
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
@@ -2003,7 +2015,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool terminate_assoc = true;
+	bool op_term, terminate_assoc = true;
+	enum nvme_ctrl_state state;
 	int opstate;
 
 	/*
@@ -2043,6 +2056,9 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	 * association to be terminated.
 	 */
 
+	/* Pairs with synchronize_rcu() in __nvme_fc_teardown_association() */
+	rcu_read_lock();
+
 	opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
 
 	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
@@ -2136,20 +2152,44 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
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
 		nvme_fc_start_ioerr_recovery(ctrl, "io error");
+
+	rcu_read_unlock();
 }
 
 static int
@@ -2802,7 +2842,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		 * cmd with the csn was supposed to arrive.
 		 */
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 
 		if (!(op->flags & FCOP_FLAGS_AEN)) {
 			nvme_fc_unmap_data(ctrl, op->rq, op);
@@ -3260,25 +3301,25 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
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
-	ctrl->iocnt = 0;
+	atomic_set(&ctrl->iocnt, 0);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
@@ -3287,11 +3328,18 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_abort_aen_ops(ctrl);
 
 	/* wait for all io that had to be aborted */
+	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
 	spin_lock_irq(&ctrl->lock);
-	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irq(&ctrl->lock);
 
+	/*
+	 * Wait for a started nvme_fc_fcpio_done() to complete before we
+	 * proceed with cancelling inflight requests. This guarantees a
+	 * request is completed by one of the two codepaths, not both.
+	 */
+	synchronize_rcu();
+
 	nvme_fc_term_aen_ops(ctrl);
 
 	/*
@@ -3323,13 +3371,37 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
 	nvme_fc_free_queue(&ctrl->queues[0]);
 
+	nvme_fc_ctlr_inactive_on_rport(ctrl);
+}
+
+/* Complete the requests held in __nvme_fc_teardown_association() */
+static void
+nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl)
+{
+	nvme_cancel_tagset(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
+
 	/* re-enable the admin_q so anything new can fast fail */
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	/* resume the io queues so that things will fast fail */
 	nvme_unquiesce_io_queues(&ctrl->ctrl);
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
2.55.0


