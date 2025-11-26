Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906FDD10372
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FbK5fZiutYhedIPWYxEBAuO5w3UfHl/USBKz0oqynIM=; b=rJWzFn0fIiBkY+uXcyRQs5zFEY
	/ELsPKl2PRl01/giBBMWJdewULX91nzQ35tYFMNMsJ/DJ4Tn/jDfkAAM00QRI+JOr0Umt/svyZBcu
	Sv7Hu8D2qy4WcBFsqUkiBz0vpNXloqC4jLNoH8d/TMDpL6QtH2R9OySAGti+2rb6G4SuCsad7PzYS
	Ib0eeQ5dxKwBbDSs4cjkjzxd4EZm1MQTR17fKmLiUQswRjEzRpxO2QX7BJqKNAkxvkxNSG9+yEBo9
	RkHChIA1xnmr15W/86KC49UTUGBni4+hJTUk9bBf7dzQr2T89T85q0SsNz1CLc1L0ukW7uazfUS84
	BH6wWqfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52O-0000000EDhX-0dpv;
	Wed, 26 Nov 2025 02:13:44 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52F-0000000EDVw-2H68
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:36 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4625436b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123214; x=1764728014; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbK5fZiutYhedIPWYxEBAuO5w3UfHl/USBKz0oqynIM=;
        b=YEYKMyIkvlVXbvDJlVVVCbMrNxYIJXwt83R1qiFmoOKOHWCjqBVj3iQYYhCTmMl23H
         nB/C2XtAUJdRI1Oz/GWnB2ZwYLfi60DOPk4puZIedxZO57OQOldkfVxRmvUICIDztrSt
         sGrOeypOZKjHmPvx3xB7CDxPnf1p61X2I8F03h/HJu21E5hd2lLjLfPqZ8KQYbQ61cry
         wLTZAbHqxldBzYRiGEwmTVneLWPSswXHtOH5pXuJdv3GlCpe4h2sK+ihbtEG7BCQ5re0
         fCtIpddkQ7iu7tKdmbxNQx3GZ4UxpuLTPD2Pdq/7ZvtKBQgZj2kDH/PjCLCdxiN1M+G7
         WNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123214; x=1764728014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbK5fZiutYhedIPWYxEBAuO5w3UfHl/USBKz0oqynIM=;
        b=YJX4Pm2ucEvrtFqJfymVM2J7q5t0AIEASFWICzeUPmAea7Mpt3O/D0fBNE2G5uHu9T
         tpiWkwxBYiG9cWhM6zAL22TmXSRORQrhXpw6cLsA9BCAqZDEE5OQF5yuT3SY5rCI0Fuf
         XECH8YWlPg1gGFmmFD/DU0yZGyxtPvEp/9jcQAJnc78q+qk3ocQjV3hmzrFKEiDTtrjI
         YWYmMyh5CBAE7sqAcUdmJl9mTuQCaOSB1SBka6V64tA/fqGwY2/K79CpaTroATHXj5H1
         JhHd9HeK4V0wrrw73H0sVmoDUT5Z7f5aAo5Toim5wyl6t6XR+jUWYQHEcmY1hMEWdrva
         WP+w==
X-Forwarded-Encrypted: i=1; AJvYcCUpm3F9tk8EyCBP5Je//U8xb/xZwaZNFCU/4yvq3PE26VSvUwNJFt3mCFiQMjrP+05oEoaWHiRmyRoH@lists.infradead.org
X-Gm-Message-State: AOJu0YxpiYVnAjZ1W4ixdwSGY3eIcV884nqbtnk/zOc+mWJ660IuQB66
	7NhhuO8epKtTWCr5fhjh3kR3Mh1W/58nUJIkYz/JN0w0qfxf6oNlfaJXeCOPn6z8144=
X-Gm-Gg: ASbGncvNZW+me10hgcUeGNACe7+Jr9zGxwuF4V+qJPt+UXJtV0W7G7PKC/J8rZgKy7q
	lbMZcS35dhGP0IfWPRZPByq3GtokY/rTJkVzq5cJPGZ5RFTVjMB5J2Ivc/A/Wp7F4UmhpauD5dY
	8AQmBN66UZdVe/PjcnBZilxtq+Jhjwa3STFP7HjGClm4n7EzfHXLaTJKt7pBzXqpNQZeLUSgB+N
	VVO6sg4ebAQwLgXPZ8TCKz17jusgKuRzR6xunKO+fCnoIuXnGVZ7EC9B61om0isnbymyHyeXdk9
	/+yIJGyphJ0/ODiicOJYm5aTIviGmZUTMvWz5hGb04re547DEP32EscouUe3ljZvJHc61/ya4Gn
	MFxP1Y1P3nHYdnmlCBiWRpv94zCNn64O4Wz7KaNRA7hVcH4IIqotKA7Oh81I86jCIl3Y10oB2Gc
	RTpTG1VFP6EuARCCbFu8C+fsufgFDb5zo62g==
X-Google-Smtp-Source: AGHT+IERM1coBAz6VHaGSPU/mKrv39LOQAC7fg3IEBFYYqWZMiyIxbaDOZPcp2pxCE0bN+fnmO+nJw==
X-Received: by 2002:a05:7022:797:b0:11b:ceee:a46d with SMTP id a92af1059eb24-11cb3edd0fbmr3397464c88.15.1764123214127;
        Tue, 25 Nov 2025 18:13:34 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:33 -0800 (PST)
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
Subject: [RFC PATCH 14/14] nvme-fc: Hold inflight requests while in RECOVERING state
Date: Tue, 25 Nov 2025 18:12:01 -0800
Message-ID: <20251126021250.2583630-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181335_634128_6EBD7F11 
X-CRM114-Status: GOOD (  21.40  )
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

nvme_fc_delete_association() called from error recovery codepath waits
for all requests to be completed. In RECOVERING state inflight IOs
should be held until it is safe to for them to be retried. Update
nvme_fc_fcpio_done() to not complete requests while in RECOVERING state.
Update recovery codepath to cancel inflight requests similar to what
nvme-tcp and nvme-rdma do today.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 50 +++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0e4d271bb4b6..1b4f42358f37 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -171,7 +171,7 @@ struct nvme_fc_ctrl {
 
 	struct kref		ref;
 	unsigned long		flags;
-	u32			iocnt;
+	atomic_t		iocnt;
 	wait_queue_head_t	ioabort_wait;
 
 	struct nvme_fc_fcp_op	aen_ops[NVME_NR_AEN_COMMANDS];
@@ -1816,7 +1816,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 		atomic_set(&op->state, opstate);
 	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
 		op->flags |= FCOP_FLAGS_TERMIO;
-		ctrl->iocnt++;
+		atomic_inc(&ctrl->iocnt);
 	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -1846,20 +1846,29 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
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
 
 static int nvme_fc_recover_ctrl(struct nvme_ctrl *ctrl)
@@ -1950,7 +1959,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool terminate_assoc = true;
+	bool op_term, terminate_assoc = true;
 	int opstate;
 
 	/*
@@ -2083,17 +2092,34 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
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
+	/* Error recovery completes inflight reqeusts when it is safe */
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_RECOVERING)
+		goto check_op_term;
+
 	if (!nvme_try_complete_req(rq, status, result))
 		nvme_fc_complete_rq(rq);
 
+check_op_term:
+	if (op_term)
+		__nvme_fc_fcpop_count_one_down(ctrl);
+
 check_error:
 	if (terminate_assoc)
 		nvme_fc_start_ioerr_recovery(ctrl, "io error");
@@ -2737,7 +2763,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		 * cmd with the csn was supposed to arrive.
 		 */
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 
 		if (!(op->flags & FCOP_FLAGS_AEN)) {
 			nvme_fc_unmap_data(ctrl, op->rq, op);
@@ -3206,7 +3233,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(FCCTRL_TERMIO, &ctrl->flags);
-	ctrl->iocnt = 0;
+	atomic_set(&ctrl->iocnt, 0);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
@@ -3215,8 +3242,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_abort_aen_ops(ctrl);
 
 	/* wait for all io that had to be aborted */
+	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
 	spin_lock_irq(&ctrl->lock);
-	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irq(&ctrl->lock);
 
@@ -3362,6 +3389,9 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
 	/* will block while waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
+	nvme_cancel_tagset(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
+
 	/* Do not reconnect if controller is being deleted */
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		return;
-- 
2.51.2


