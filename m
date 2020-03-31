Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E539C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FF6206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gD0rvCgj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKfrKyEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FF6206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8oSgU+zhT7pl0w9aWJnX1Z5OGPFQuDY1xF02F0PKcrI=; b=gD0rvCgjxvk1W5dN9Asx5EfWwU
	V97f+MmvP+dQAtfPW5x7iSt4cngM+RCdxFZ+4a/Ny+DUwJIis70+8lqPzlIeBrQLCBX2BOeRdET8X
	e9P2hkUdofDVTGxMs5C8K73e/uI0uzyWIEEKRF8NSypqOuMJ3Ju6mo9tnpETY+Ud0doSN1HYFmand
	/WH/SNlaWzrCugqyXnJCEjI10OdNGazp6D8bxeK/cK1t6CDp+j+ekPeauy5aDIms7zfinyFZfVJ3q
	DrNI6vVtde3okLuSXGLz8q/Ia2VRIoyKnZxfSEDYa1cXkDM47igNbg3c3235UZ07OSLl5yQHWZbBV
	57QLuaYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK76-0005UP-QD; Tue, 31 Mar 2020 16:51:44 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5v-0004ZV-DT
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:33 +0000
Received: by mail-wm1-x344.google.com with SMTP id c81so3304368wmd.4
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T1P4GD9whIOiMX95Lpv3ViE89WXLB6iFJQxpK5kQxdA=;
 b=pKfrKyEas6k1pHejgSpCbOmlDhbyyt1LkLxakx5SGeLQ0EWygcXx2oJY7ohoqN9bJE
 EDe2DZ05FSCbongCZI8QpjPZ0x5fNl4lNEP5cQPWUGmzJAuodlmeYt4R/xTJ+RThYlR/
 A6VDlkriAMHdhoPIroI1klELhKv/X+0wbrUSvxpnlgjjlW8AUCQMdSWbukLPrUkT0bCV
 WyJdCrVt365DaXhG+aYnw5AeP/vMi2zPEh2BrLCPo83JSgNx0FgVuh0Z9nxfNOieubhn
 An0xXF6wBpun8KH6VT2uMEi/LkuqTuG9KIPtjmHpmnu4yBHPXVQHddjxju4KtwtjIhxI
 qZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T1P4GD9whIOiMX95Lpv3ViE89WXLB6iFJQxpK5kQxdA=;
 b=ZZeIJqvv4GJ0A2HQcsc4tC6+b27E6yCzKjHjJvb8zSSPAxSn2Wx/0IdmKEiUSJ27E0
 ASgD9+Qp7+zruCFBfRGCvokrvxrcNwVMehD21DwYj8NJn4rWHmkekKf55dSdH1Dr2c6C
 GdsjbAYKizSakvJGhXwWkiJPYQGth5BkpXEYa3zKNDh508EIurFAcm6/yT5jwk86nxTL
 8LRbIK+3YzxcLeFi7S2xKXZf4MMjVH3aQUvhYT8QH82mDL3O+5Kk7k9JW/WZVMm8LT3j
 Dw2d3F3mOGlAt5fqV7UjfgT0YD8qujSSyms2Y3Ppm+4LKN3RzHYho5lbzDKAHW8x47k8
 XTTw==
X-Gm-Message-State: ANhLgQ3m4RFMFKdVwomqM3SY/hSTPSBvU3baIg8wEdoRL1L5ddxWMCSc
 tyUeXGmnmPtN2ut7sVw2DqtlbrEs
X-Google-Smtp-Source: ADFU+vsolcB+oMYgeD9rrMk47vbdbHObdtLzLNKgf/6dCDH8DRSU7k71elGddETwp0mCwXaIEBEI3Q==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr4484943wmg.79.1585673429348;
 Tue, 31 Mar 2020 09:50:29 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:28 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 06/26] nvme-fc: convert assoc_active flag to bit op
Date: Tue, 31 Mar 2020 09:49:51 -0700
Message-Id: <20200331165011.15819-7-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095031_467274_02ACB4C8 
X-CRM114-Status: GOOD (  16.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Convert the assoc_active boolean flag to a bitop on the flags field.
The bit ops will provide atomicity.

To make this change, the flags field was converted to a long type,
which also affects the FCCTRL_TERMIO flag.  Both FCCTRL_TERMIO and
now ASSOC_ACTIVE flags are set/cleared by bit operations.

Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2:
  The v1 patch moved assoc_active from a bool flag to an atomic.
  The v2 patch removes the atomic and makes the flag an actual bit
   in the flags field. Flags field became a long to use in bitops.
   The existing flags field, FCCTRL_TERMIO, was converted to use
   bitops for set/clear for consistency.
  Deferring other recommendations of changing atomics to bit fields
    for a later patch
---
 drivers/nvme/host/fc.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8281e5dae93b..ca9efed2b560 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -127,9 +127,9 @@ struct nvme_fc_rport {
 	unsigned long			dev_loss_end;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
-enum nvme_fcctrl_flags {
-	FCCTRL_TERMIO		= (1 << 0),
-};
+/* fc_ctrl flags values - specified as bit positions */
+#define ASSOC_ACTIVE		0
+#define FCCTRL_TERMIO		1
 
 struct nvme_fc_ctrl {
 	spinlock_t		lock;
@@ -140,7 +140,6 @@ struct nvme_fc_ctrl {
 	u32			cnum;
 
 	bool			ioq_live;
-	bool			assoc_active;
 	atomic_t		err_work_active;
 	u64			association_id;
 
@@ -153,7 +152,7 @@ struct nvme_fc_ctrl {
 	struct work_struct	err_work;
 
 	struct kref		ref;
-	u32			flags;
+	unsigned long		flags;
 	u32			iocnt;
 	wait_queue_head_t	ioabort_wait;
 
@@ -1522,7 +1521,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 	opstate = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
 	if (opstate != FCPOP_STATE_ACTIVE)
 		atomic_set(&op->state, opstate);
-	else if (ctrl->flags & FCCTRL_TERMIO)
+	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags))
 		ctrl->iocnt++;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -1559,7 +1558,7 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 
 	if (opstate == FCPOP_STATE_ABORTED) {
 		spin_lock_irqsave(&ctrl->lock, flags);
-		if (ctrl->flags & FCCTRL_TERMIO) {
+		if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
 			if (!--ctrl->iocnt)
 				wake_up(&ctrl->ioabort_wait);
 		}
@@ -2389,16 +2388,9 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(arg);
 	struct nvme_fc_fcp_op *aen_op;
-	unsigned long flags;
-	bool terminating = false;
 	blk_status_t ret;
 
-	spin_lock_irqsave(&ctrl->lock, flags);
-	if (ctrl->flags & FCCTRL_TERMIO)
-		terminating = true;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-
-	if (terminating)
+	if (test_bit(FCCTRL_TERMIO, &ctrl->flags))
 		return;
 
 	aen_op = &ctrl->aen_ops[0];
@@ -2607,10 +2599,9 @@ nvme_fc_ctlr_active_on_rport(struct nvme_fc_ctrl *ctrl)
 	struct nvme_fc_rport *rport = ctrl->rport;
 	u32 cnt;
 
-	if (ctrl->assoc_active)
+	if (test_and_set_bit(ASSOC_ACTIVE, &ctrl->flags))
 		return 1;
 
-	ctrl->assoc_active = true;
 	cnt = atomic_inc_return(&rport->act_ctrl_cnt);
 	if (cnt == 1)
 		nvme_fc_rport_active_on_lport(rport);
@@ -2625,7 +2616,7 @@ nvme_fc_ctlr_inactive_on_rport(struct nvme_fc_ctrl *ctrl)
 	struct nvme_fc_lport *lport = rport->lport;
 	u32 cnt;
 
-	/* ctrl->assoc_active=false will be set independently */
+	/* clearing of ctrl->flags ASSOC_ACTIVE bit is in association delete */
 
 	cnt = atomic_dec_return(&rport->act_ctrl_cnt);
 	if (cnt == 0) {
@@ -2767,7 +2758,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
 out_free_queue:
 	nvme_fc_free_queue(&ctrl->queues[0]);
-	ctrl->assoc_active = false;
+	clear_bit(ASSOC_ACTIVE, &ctrl->flags);
 	nvme_fc_ctlr_inactive_on_rport(ctrl);
 
 	return ret;
@@ -2784,12 +2775,11 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 {
 	unsigned long flags;
 
-	if (!ctrl->assoc_active)
+	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
 		return;
-	ctrl->assoc_active = false;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
-	ctrl->flags |= FCCTRL_TERMIO;
+	set_bit(FCCTRL_TERMIO, &ctrl->flags);
 	ctrl->iocnt = 0;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -2840,7 +2830,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	/* wait for all io that had to be aborted */
 	spin_lock_irq(&ctrl->lock);
 	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
-	ctrl->flags &= ~FCCTRL_TERMIO;
+	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irq(&ctrl->lock);
 
 	nvme_fc_term_aen_ops(ctrl);
@@ -3117,7 +3107,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->dev = lport->dev;
 	ctrl->cnum = idx;
 	ctrl->ioq_live = false;
-	ctrl->assoc_active = false;
 	atomic_set(&ctrl->err_work_active, 0);
 	init_waitqueue_head(&ctrl->ioabort_wait);
 
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
