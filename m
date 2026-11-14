Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509D606A8B4
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1dv67oFH;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=EBwqo00m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qu0QicR3v2Y9fiT7BuqjEd+nN52bTpIsNe3RHBYUUYQ=; b=1dv67oFH+icdhi
	v1KSz1xnAlFpZFuNAYiXC79vp2xHcoNL+NpYHwWMiv8JOIqNS8kPl5tNW1O9STpSGE57vvX/T5nXC
	lolX0KADltOBEy5ndTzw/J875UXNXSF0fxo/KmRur+X18kRf0GdI5mzcLfrDj5ZQ17qAsqqBpEGW8
	towzssN7CVYxxWP2GlWZfR0QEIHP7GXCUY6tNM4B58QIP2J7j6Js5k5w7sFN8uw8xXukqNpK5ziUu
	+VLpb236Y0+7us9JmQzriDxqVE/NrzewhfGHqdLXQ+X/+RUkpHyTdtsb4VKcuWKpVwFMPAXywBkRH
	hWtoxe86JUqh/1UD2UFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45k-0000000FAGH-3OrI;
	Sat, 14 Nov 2026 03:06:12 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45a-0000000F9yn-1NfZ
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:10 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1b244fb7fffso1860768c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625561; x=1795230361; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qu0QicR3v2Y9fiT7BuqjEd+nN52bTpIsNe3RHBYUUYQ=;
        b=EBwqo00mQBRUDUEQgxuSNugtFtt6CM7fq6wR2wc66l35Dbi9lX3CFChGmFabT9e/GO
         x4H3x6tw4wzoZ5Xf3X7XsYhbcWFPiYYrc4lqxTAlcxUohPdyYoJrwmzz4PMBwWIqr3hP
         LY+w2cd7DixYdenJXfbs5tCXiz9jstWGJ+r2BXmI5XcSwG2FP6vh7TeM+anE8NWwkU95
         UwahhYtE4xpe9Z3eJdUv//Y3Brm4uwGBk83Tma99BgzRGgWCkDx2NjG3UVzaRMX8Vuym
         YYm93BWU1NGoSrZ/iMGwRGMhg4aTN7v7+BDzu+GgHmnS3TAoxdQjIsUlHzRRhX0UX9dH
         GtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625561; x=1795230361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qu0QicR3v2Y9fiT7BuqjEd+nN52bTpIsNe3RHBYUUYQ=;
        b=x2Zb85ppvqX0aM/CNBlHXKBEfbzLGh0FP8bOHNqxp1LfSZgrFgiRVi8FKtOQSjvh5O
         DFvguB5FRoTK83F5cBy7Z7y6LTW9bQEM27pwMEEWh1qIxHTU28s/NQwbSnUKOlCvHrS7
         EcVCKTJZ4KO3eYL/glPMbD7VAfPtqAb79S2LPWzY4lj+GzNRDCnndohK0U92pvzKIvz3
         f3imgs/nm+p9Ukz6qbks9pD+rSzrYM3+fKeYNteBIoZLCdA5V9IGHcCeuTOqTCJvOWxL
         Zs0VOEgdK0/S0fuE9gIMuGVMeiAw15Vq4pbVHv4RVDdBhXM1+B9m8HOuuKin50l++4tl
         iZRg==
X-Forwarded-Encrypted: i=1; AL+hErGJgLuil/CrWVI8Opxc61XCYKFDpjCVA2W+hv59zdn8F+6BQs9yvwhh8xNY7N49cGrZXbbYC6y7n99j@lists.infradead.org
X-Gm-Message-State: APuU4Z958XCYugLLlngx+x0l4s0/Z+TtLmjLhQZTLTI3O0LYE5kB3YMe
	/TV5lTY/xVve/Vx4yJcogfz1Co+8Q5a/HBp59Zr7k5PtWfph094HIk71/IWOT3qOqFQ=
X-Gm-Gg: AYBFou1BmrsoZK8nxmhKWNm59UajLJ7w4XWAW1SOF/V8TopTEYyJgUiN4FVf0HFOxGt
	Zl3waTxZ8cvoRtolq6Q4FU2ZOTSEfn/Ui1rPZcr7leX8Hm1NOg1obSSIicNnumPdnjL9Lo2o8Zm
	jN5BBGgcsD+oWCfHoEdjFs9ixTr3WGoE95Mus+NHAtoiXLQgtERrLeZ8IdDDi6VdLrxQfe1+SRO
	r6i29K5o4EMNcX6cdob8m1vED6HUSMDfaqO/+XszY3ZToTG5AauwkBszm9Uaz8VYQzth/dC0jXf
	U3PEqgK2WEvhbLJNHcfNwdSxbJuFLO4Gx8ncIQnVUmPar/NkdyKuA1Eazj32HjfkjlkxZ9w5Um+
	U6UFDf9dixo1Riq7CXXRBL0vkCYFs3XcY/apru92R2myag7bL29IjIckFDUE2tOkruWBmoNLVCU
	w+nfrd1I2L1N684eYaxWiHVc2ADLbH5wBRB59t1WD4H5UJwi9vsNMxToSuQMqOmBsuVUd5TG/Uc
	2yFDZ7NngI9BB1mV6B8W75o++4WEtBkpfetA11Po6WciEWUtNbIQIUesE1T2XsHcVBEek2DNxmk
	cOeO5RuV4hQXNIGi3sQz1w5sc6BzLROL6Qi45h4leV6ifLUlbX/5GMKperBWm36s/DKeVvtGiQ=
	=
X-Received: by 2002:a05:701b:290a:b0:16c:3408:760b with SMTP id a92af1059eb24-1b503121292mr3585620c88.32.1794625560977;
        Fri, 13 Nov 2026 19:06:00 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:06:00 -0800 (PST)
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
Subject: [PATCH v7 11/17] nvme-rdma: Use CCR to recover controller that hits an error
Date: Fri, 13 Nov 2026 19:04:25 -0800
Message-ID: <20261114030454.2836543-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190604_073521_74D696A4 
X-CRM114-Status: GOOD (  17.67  )
X-Spam-Score: -2.1 (--)
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

A LIVE controller that hits an error now moves to FENCING instead of
RESETTING. ctrl->fencing_work attempts CCR to terminate inflight IOs.
Regardless of the success or failure of the CCR operation, the
controller then moves to RESETTING to continue error recovery.

A request that times out while the controller is FENCING is not
completed. Its timer is rearmed, since inflight requests must not be
retried before the fence is over. nvme_rdma_stop_ctrl() flushes
fencing_work, so deleting a controller that is fencing waits for the
fence to finish.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/rdma.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 32189fdfc0f5..da1ec2dd6205 100644
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
 
@@ -1991,17 +2015,19 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
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
-		 * If we are resetting, connecting or deleting we should
-		 * complete immediately because we may block controller
-		 * teardown or setup sequence
+		 * If fencing has finished or we are resetting, connecting,
+		 * or deleting we should complete immediately because we may
+		 * block controller teardown or setup sequence
 		 * - ctrl disable/shutdown fabrics requests
 		 * - connect requests
 		 * - initialization admin requests
@@ -2017,7 +2043,9 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 
 	/*
 	 * LIVE state should trigger the normal error recovery which will
-	 * handle completing this request.
+	 * handle completing this request. In FENCING state the request must
+	 * not be completed before fencing has finished, so just rearm the
+	 * timer and let the error recovery pick it up.
 	 */
 	nvme_rdma_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
@@ -2328,6 +2356,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.56.0


