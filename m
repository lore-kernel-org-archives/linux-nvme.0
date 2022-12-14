Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F06C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rSJAr32W5cBhiu+fid3qr//jmw/H3KvEcXR29vGj7OE=; b=Zz3nbcChAVH2W0bEWxY8ymn7hI
	sqVjF9cXc1QnMdbr7FWvnB2nrpt19ROUwr+8DQ7cEV3heOrNN1M51ysvp7sJrH1wtPCZRmTm5Rg8h
	5yVFE7+lQim6+zt3BsSG7wJg043WmvKiT3mKaYmhsXTJCLkwT8yr8Ex9ByoM7X1PZ/X1EMd5LkIZF
	M6RM8/ngA/Mlza/VL6NtU1VN+hcadiN4bVKeMqkSrr15Yhf1hrSRdNpvomIUa5mbik08rN65PFq1P
	/cUJQ8Zaj/aek6UZGwq2Mr2CGcZsNb475PXIx/fGJ2sahZzd+T+YQtjAKZIVM0NuZMecuRygQFLTk
	GMYhBbHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOX-000VRT-0O; Wed, 14 Dec 2022 16:14:09 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOM-000VMB-JS; Wed, 14 Dec 2022 16:13:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/9] nvme: remove nvme_execute_passthru_rq
Date: Wed, 14 Dec 2022 17:13:41 +0100
Message-Id: <20221214161347.764071-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214161347.764071-1-hch@lst.de>
References: <20221214161347.764071-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After moving the nvme_passthru_end call to the callers of
nvme_execute_passthru_rq, this function has become quite pointless,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c       | 18 ++++--------------
 drivers/nvme/host/ioctl.c      |  5 +++--
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/nvme/target/passthru.c |  5 +++--
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e26b085a007aea..d6f3ac102e9488 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1004,7 +1004,7 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
  * >0: nvme controller's cqe status response
  * <0: kernel error in lieu of controller response
  */
-static int nvme_execute_rq(struct request *rq, bool at_head)
+int nvme_execute_rq(struct request *rq, bool at_head)
 {
 	blk_status_t status;
 
@@ -1015,6 +1015,7 @@ static int nvme_execute_rq(struct request *rq, bool at_head)
 		return nvme_req(rq)->status;
 	return blk_status_to_errno(status);
 }
+EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
 
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
@@ -1096,8 +1097,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
 
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			       u8 opcode)
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 {
 	u32 effects = nvme_command_effects(ctrl, ns, opcode);
 
@@ -1115,6 +1115,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 	return effects;
 }
+EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
 
 void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		       struct nvme_command *cmd, int status)
@@ -1156,17 +1157,6 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
 
-int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
-{
-	struct nvme_command *cmd = nvme_req(rq)->cmd;
-	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
-	struct nvme_ns *ns = rq->q->queuedata;
-
-	*effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	return nvme_execute_rq(rq, false);
-}
-EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
-
 /*
  * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
  * 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9ddda571f0461f..a371209ee5e6d4 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -187,6 +187,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
@@ -209,8 +210,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
-	ret = nvme_execute_passthru_rq(req, &effects);
-
+	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (meta)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6bbb73ef8b2548..a52e854e894b70 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1070,7 +1070,8 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-int nvme_execute_passthru_rq(struct request *rq, u32 *effects);
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
+int nvme_execute_rq(struct request *rq, bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 79af5140af8bfe..0b238fce2c11f2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,11 +216,12 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
 	u32 effects;
 	int status;
 
-	status = nvme_execute_passthru_rq(rq, &effects);
-
+	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
+	status = nvme_execute_rq(rq, false);
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
-- 
2.35.1


