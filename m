Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B9C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0UuleHNrFJL7Ac1BNRBp4u482qJaS6x4l4kwP4ak8U=; b=Gq+TVjczaXiJXiVjYAofnt/J76
	G1kM3VL/NeyJeFZE8TlZjw7dYHh1vUKKd7l4IZlqoh3bQGqabxCE0azxPtElfOE/lXwEsZm+/znOk
	5+ULe5yWQd6vwD0a/9yTFWwxgTdux+bVR85p+Tk9XFceayMseP6lyg+SwKV/YFTp3gPe6wFDNjekd
	Utr6ljzkHf6RTgvMXI2V9OFXJpOXIvpgFiKnlQjqn0LHfP1HmOTrMxc3CCV9LwlHJi4wk+89keTWo
	XaauHw1dTj/7ceG0Jko/zZiy8jnGyJLloLOKMFOnUS7UCKyu7GiCxPZoJ4nLCL5nen3HQfa1qrUQ/
	P7FOgbMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d99-0000000FHE1-3RHu;
	Fri, 18 Sep 2026 18:17:15 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d96-0000000FH7p-2ADr
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:13 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2dd77300825so11236565ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755432; x=1790360232; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0UuleHNrFJL7Ac1BNRBp4u482qJaS6x4l4kwP4ak8U=;
        b=LfOBxFYzvUivOvLL0J30/+kG85Nbc7L4PySisii6HkEmvKaeGmalR8QSdsdZxiGP9i
         PCJnLTEsu5Go7mgHXjci9nYf9qAAC0hnr2nyNs6ihoOwROdYlH8JDGPQMxEwGEr5SNrx
         stTUd+bgO+NRseXLdd5XVkiumzESjbGMO7VGGSNfS1IFhu3pWD+L5F6xpT73vLy57Xl/
         aBgM3LASaP1a9AYHmTC2wMI7EphgmXrm23gGY+jbt2ctqOp750S86gGNoEdSG/vUmvdU
         /g/p1AZqryV9ZiiMmWFB+YLce01GPMvW7+7YK7taYJSIHIaK1z/fOPJWW5FouZlrwMwe
         +i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755432; x=1790360232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i0UuleHNrFJL7Ac1BNRBp4u482qJaS6x4l4kwP4ak8U=;
        b=cqKmP0VBTl0vtQFVEEywGRNsyPdZmEvhFkwyxdoufSgV68CG1gd/UmNH36MAHXSQmB
         xNg6lQza7Iib5B1PFkTjD7L34j0BIUuLq5skpOIXoL2/nMMl3saZXpnlpbIjrVva651l
         W9StqiMF68AZjFvaO6AFdaUpcPDwOKzCkt0gI9Bb2N3FViN/wzE0eaeg49byZCJkC7t4
         Gm/yrWZ52/N0hqrLF6CNz0eKrVaK4JQBymWr2rffTuQwSMhYaXdHqO+LzNXoWYXT/OMW
         Pg13ZGlgtEC8zUFNuxEHAhEBH5923+KJZHGaJe9lvMRlejnf7fsxlbW4JMTtK6SUNb9j
         dytg==
X-Forwarded-Encrypted: i=1; AKwUvBzhFPLizgCjEw12JEUxKkZ6zUWo/C4by0t7CEYxZVb/Oy5O/VJ1QBiuN2c2D+sNWoMJVeBzpKIZbiPi@lists.infradead.org
X-Gm-Message-State: AFuF++mNoVLuHCqgQRd3K+ZfN2Ll0PYbnJinXTjLU3Yyh4Vdqo/wNarq
	dp2g/r1AD9JadKTqRepMmdk22C2llx7OpW+Y2o+Z+Y0BxvoVuLmtNBjHS0WVPlghyYC8SFl3jLF
	XMxI8xXM=
X-Gm-Gg: AYBFou0ACeGCqmEOoJe1H1zDZYY779fnjx8UHRlNs/JN0X8gUv2ykYTjhQiX68TG5Qn
	Hyj6+IgPqXTBRFEhX7l2q5F7P+d3UkRYVpzOvFfbzYrKtLL+UTd3ko11rBmlk7fS14xRjLojsX4
	3oRHJnjsPaxdWb9Ro8J8q/aDErIx/iF0M8nRLyYDvIJcatECFnDM7BuNNj3kssoCSeoYd2hugvF
	EufUa/2wdxcNbmEoKafbsdEabYXXF/SLWcH8TSs++vDLkmk0+o2SyiyVwFT9ykjlbo3Q2NJRlF9
	oF58hxbsPG0SJQ4zRrngI4M9i6NseynWwxZhymjTCEaZBhaK7Wd3R5wJVSvVnDuMTegZuBcwcH4
	92M6xeakrYVNpeWxymh6O9wD4iaHdUPnJmz2NNHAi6YR/1H4znjoO4w65vCJIX0kH1OkMPI3EU+
	oaP8nII9ynNpMfjBArWzbw2Nk6LLYvthrpapqdwoyIgkExY5Tg3flC8kVFZPCaB4DRVuV3KkV6f
	2LDGHfJlDzdoIuapp3VZA==
X-Received: by 2002:a17:90b:3b8d:b0:39e:4c7e:f03d with SMTP id 98e67ed59e1d1-39e54f0e5e7mr6453388a91.26.1789755431659;
        Fri, 18 Sep 2026 11:17:11 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:11 -0700 (PDT)
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
Subject: [PATCH 11/18] nvme-rdma: Use CCR to recover controller that hits an error
Date: Fri, 18 Sep 2026 11:14:11 -0700
Message-ID: <20260918181614.3947933-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111712_556489_018C31A8 
X-CRM114-Status: GOOD (  16.71  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. Regardless of the success or failure of CCR
operation the controller is transitioned to RESETTING state to continue
error recovery process.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/rdma.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 29ecbe71bb2e..9c50421d79c4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -119,6 +119,7 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -992,6 +993,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
+	flush_work(&ctrl->fencing_work);
 	flush_work(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 }
@@ -1153,6 +1155,22 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fencing_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
+			struct nvme_rdma_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
@@ -1180,6 +1198,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device, "starting controller fencing\n");
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -1990,13 +2014,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->ctrl.device,
 		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2327,6 +2353,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.55.0


