Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF34EDF17E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fq5iuFqiPF/Ft8LgP12Pou/FFdH+onXHL70j0HtoixQ=; b=4XHIbdxQooSzV9DohuX07cVHcp
	1sG/k/PcZeVT+qTG/sooTPO7YgLamqD6glpxQ24NRUsLiRwpcEEBZwdpQDUAhtM+UjL9tSVxoRD2b
	VXKqF8+ZdpN7x4XS0/0rBGI66SvI5mwp3OQd/QKFHGwtMdaURancrXMTU3VCAwkE6L2iPlSZU/iFD
	LeFrZQAGAzoXEjESyyMdPvHWvl4qt3pEw+90tng56BTg2ayRCsNr3NLjT8SL6zblEyJ9NcpAeZyGY
	F+FDuvnF/AOlF+0j+mttj1HnRkuBdiyTwFl3YomvxZivo5DlrmPYnTAyt1qrwNsgzWKbNEnMt83GE
	37G7Fy2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Go-00000004FG1-02EZ;
	Sat, 14 Feb 2026 04:28:38 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gj-00000004F5t-1i6h
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:34 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-124a635476fso2000848c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043313; x=1771648113; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq5iuFqiPF/Ft8LgP12Pou/FFdH+onXHL70j0HtoixQ=;
        b=AOJxbW6B6eYAFqgCX9vX8d2JHSbiBNYwt/tEUt1dio9IOZwLY744zn9zOAMYr99Nxv
         oZcSyR92zA87GWaGxEQgiR6nfUr1nVMEd2ps9x9PHr+QUgbjQfj8uubWPG4RK8EgNr3A
         CeV9617kMJIvMBaqYSj5OkaOCdYfUY4M9E7tkxuuklM8OUI/8eNBzn/1TZUMGD+DpaVq
         fOopepON2ZGfsTrAKkrE6By+z8FyNlWav6z5Blj0YtKOoicrqSFIXQ23ovK6phQD6eSz
         UpTP1SfB/x3qC0YC9Zztoume9+34zJKazF9dJGGPBzglbO2tZOvunMlFutVj89QGEEMp
         Zzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043313; x=1771648113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fq5iuFqiPF/Ft8LgP12Pou/FFdH+onXHL70j0HtoixQ=;
        b=OTGsYLS1JbRvHUDZCeQiGryEzU0qLkwnrlC9CPfu37z8qQMwX5b1IAd8j4SrqCnkU6
         PrsW2ChSr3yUzcUtCOOx7oE2YdR74HCJQBX9oQRp5zn4sBU200LTuJ0EaWcC1W3xmXEV
         J4MSRsaC7Tk5VCNrDTyhEA+mHR5+INw2LTA92gfHf3Oc2k3//He811sv9B01wuz4XTDl
         PrgAOVDGDmhMaSNGIoXW2ncnQ52bPc+GEl7V4RP9GDCSWeATnDWmhz6hpO/hVCy4VLck
         T+sNrYzS8l/+SejlT5yqIwUH+AzaZUHq7P5d3ayRC3oxZak7cBvaOI9s2EtzMwD/YWJn
         /PXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjmrcmZS5Kkkxe/x+I9S2B6qKTF8p4VOFpZ1GQeDabrAc0rDBkQyCw059L7H1UmH/VtfhAXlbpqVvg@lists.infradead.org
X-Gm-Message-State: AOJu0YzOT4XuwotDMymdS6WGiPP0RdlmHmHnevMf0gxa+kX5OWxpzX+0
	3PVbjYKOTG5oyno+uZv5adkaX7qfB1myJXu5h39TrZwZGpf/n0JZ2NsF5u13/i80h78=
X-Gm-Gg: AZuq6aK6ROVDBqKLHl6CsysjC/BLV6028fal85U8o3F/vMBHmmlUuK5X8OmP3P590en
	iz2uEzy1Tkvm+ewUERHjn7UM0AgIgaDxLsT1hy/i5ScWM8mBuCkSnq98Fo2In4Wo8fK5D/NYMmG
	ncvayfUHYpX235aKlvpvXXwJs4jIlTBosY253z2pOWZeXz2dKcoTgfw/0bnQOtqkw0SpHG2Rsd/
	43tjy9wIdwktUdkINI8/7/7ZNVC/gxzvKBBcByxYINRtXRc+JHi5WjqnTKI21x+mkEc7hpKjzpb
	z3u8hvDcsoezJg39fr+HSF08xJiBqY0ASUjO/atcwpPSiVMiR/1fwkwV7ghn8MYiVXKUcj/Xt13
	Y5gQE4+GRBtYvmzG63e8w8547KEWCKhFdDTgZTQPen8KDsSOgnBiyp8zSMQP19R3aWQSzs+jVxr
	lbd5NQRKjx1XsN5Q+FnKHsMb2aNxTf0LaD2KLDkk6dJc8Y5g==
X-Received: by 2002:a05:7022:f102:b0:11d:f0d3:c5da with SMTP id a92af1059eb24-1273ae66557mr1331974c88.43.1771043312566;
        Fri, 13 Feb 2026 20:28:32 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:32 -0800 (PST)
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
Subject: [PATCH v3 14/21] nvme-fc: Hold inflight requests while in FENCING state
Date: Fri, 13 Feb 2026 20:25:15 -0800
Message-ID: <20260214042753.4073668-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202833_447752_77C2C50A 
X-CRM114-Status: GOOD (  21.96  )
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
---
 drivers/nvme/host/fc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6ebabfb7e76d..e605dd3f4a40 100644
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
@@ -1969,7 +1978,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool terminate_assoc = true;
+	bool op_term, terminate_assoc = true;
+	enum nvme_ctrl_state state;
 	int opstate;
 
 	/*
@@ -2102,16 +2112,38 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
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
@@ -2750,7 +2782,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		 * cmd with the csn was supposed to arrive.
 		 */
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
-		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+		if (__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate))
+			__nvme_fc_fcpop_count_one_down(ctrl);
 
 		if (!(op->flags & FCOP_FLAGS_AEN)) {
 			nvme_fc_unmap_data(ctrl, op->rq, op);
@@ -3219,7 +3252,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(FCCTRL_TERMIO, &ctrl->flags);
-	ctrl->iocnt = 0;
+	atomic_set(&ctrl->iocnt, 0);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
@@ -3228,11 +3261,19 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
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


