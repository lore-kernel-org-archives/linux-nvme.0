Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B18EE6452
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2fAnK6rxixFAebjPyoQZL41Eo7ou5Z9tU+qchiCyObg=; b=b5vF0AIQEn90NTRdbWhc83EIIL
	kBDWTwLfsUzN2f+RCKXSGo9Wm9+SrX5t/lQIAFa1XC0ko83qSO/tYynjAu3rJxEzIQtuMzDSjtHf/
	fWBrrrtw8pf3ki2XR0jkQAXnsDP1wyk2ciJLnG3sw/cRdlH0a2aIOtcUEXV72yR4tJmt66U+oayz2
	t+rJsvMWw0tIpmR9uiG/XM1ukMMXdHjlmO+ncf30gKcI1z4UEvnyN/4pw1yCJ2JTLygDxXzw9pzlh
	b7CutHBsTRV464Dq36En74YOEILlZTOGqZbGUkX9ZtfNuT7E+X6MmNoc7XZl0oDBclhZGMA1xKsf1
	H9As4fKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYh-0000000C3PL-25Oi;
	Thu, 12 Sep 2024 06:44:03 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYa-0000000C3KW-0RHm
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:58 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com DF9DBC000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123433; bh=2fAnK6rxixFAebjPyoQZL41Eo7ou5Z9tU+qchiCyObg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FiYC8ixsq5yP3hvwtA1S7U1ZO3FQgli/Nkqpx3CcMMHkNTA8/GN30KMzHd4m+PPNl
	 aF4WCk2R2VJIb/uYiwkzvDLmSZRffpT17SdQFAQ60mHisBTBsWJpITvgAy4nE5lRsG
	 u76rpFR5PMOSwK1NueW91wPxyitnM7OY/v39vahIt2Y5DzSSAdenkts6FPybOjR1tE
	 IptZ2OiL0rLBMu9nh84mYJWEHReLH/VAEbOQh9QItWqYMyREKLHmTwcQCnXlbDC6N4
	 nzDPcBC1zv3iDKjl9P6O4lr69OcISqwvrptTG2k5rjiS8wc+VDFydhb7oFU/zudoH8
	 Sc/IuV4zBuwQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123433; bh=2fAnK6rxixFAebjPyoQZL41Eo7ou5Z9tU+qchiCyObg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=cx7Q3rRFglFeM9+OU0qNXGGbqOB1v7BoZ5s3V/25ti9q+HFkhMBD28dmE5CRmddcg
	 y2xPb3R+FcOMNb/TgKr99FjeJdnnFey+Et+5IQ5v4e5ZW1r1vlZbisU7D1KV8TxXS9
	 HTzssrST0Bddn/o/HyA2Te4pdkMBUirb7+YEn786WQQK1IM/XJFLNNBRFIrm+HageS
	 LTNcbdy2d/gDmf4I9Acvm64p7VLmmjRFJbAAgT9TA/aXPjNW71JTvlyq47vWthOY/5
	 HmorSIn5IEOAMppe5k5xXCSnGzLd5jSs9ew2B/UGvJksyrZ2XevYrk1qXFTI1vRa/z
	 dUprHoA5SPH5Q==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 5/7] nvmet: add support of fused operations
Date: Thu, 12 Sep 2024 09:42:57 +0300
Message-ID: <20240912064259.5228-6-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234356_517342_542CE484 
X-CRM114-Status: GOOD (  28.68  )
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

Add support of Compare And Write fused operation.
There can be several different Fused pairs inflight.
Atomicity is garanteed for just one logical block.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/admin-cmd.c |   2 +
 drivers/nvme/target/core.c      | 326 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/fc.c        |   2 +-
 drivers/nvme/target/nvmet.h     |  12 +-
 include/linux/nvme.h            |   2 +
 5 files changed, 338 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e555b9efebfb..b1ca1e371212 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -437,6 +437,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 			NVME_CTRL_ONCS_WRITE_ZEROES |
 			NVME_CTRL_ONCS_COMPARE);
 
+	id->fuses = cpu_to_le16(NVME_CTRL_FUSES_COMPARE_AND_WRITE);
+
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b7b2bf7b460c..b4fb66037e45 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -804,9 +804,98 @@ int nvmet_compare_sg(struct nvmet_req *req)
 	return ret;
 }
 
+static void nvmet_fused_failed(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, fused_work);
+
+	nvmet_req_complete(req, NVME_SC_FUSED_FAIL);
+}
+
+static void nvmet_fused_succeeded(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, fused_work);
+
+	req->execute(req);
+}
+
+static void __nvmet_fused_req_complete(struct nvmet_req *req,
+				       struct nvmet_req *fused_req,
+				       u16 status)
+{
+	struct nvmet_req *first_req, *second_req;
+	unsigned long flags;
+
+	if (req->cmd->common.flags & NVME_CMD_FUSE_FIRST) {
+		first_req = req;
+		second_req = fused_req;
+	} else {
+		first_req = fused_req;
+		second_req = req;
+	}
+
+	spin_lock_irqsave(&first_req->fused_lock, flags);
+	spin_lock(&second_req->fused_lock);
+
+	req->fused_state = NVMET_FUSED_STATE_COMPLETED;
+
+	switch (fused_req->fused_state) {
+	case NVMET_FUSED_STATE_INIT:
+		fallthrough;
+	case NVMET_FUSED_STATE_FAILED:
+		/* if second command is not yet executing then the first
+		 * was failed, so fail the second one
+		 */
+		WARN_ON(!status);
+		fused_req->fused_state = NVMET_FUSED_STATE_FAILED;
+		/* wait for fused request complete/execute */
+		spin_unlock(&second_req->fused_lock);
+		spin_unlock_irqrestore(&first_req->fused_lock, flags);
+		return;
+	case NVMET_FUSED_STATE_EXECUTING:
+		/* The second fused command is waiting for completion of the first
+		 * command. Continue handling of the second command depending on
+		 * the completion status.
+		 */
+		if (status)
+			INIT_WORK(&fused_req->fused_work, nvmet_fused_failed);
+		else
+			INIT_WORK(&fused_req->fused_work, nvmet_fused_succeeded);
+
+		queue_work(nvmet_wq, &fused_req->fused_work);
+
+		spin_unlock(&second_req->fused_lock);
+		spin_unlock_irqrestore(&first_req->fused_lock, flags);
+
+		return;
+	case NVMET_FUSED_STATE_COMPLETED:
+		/* both fused command completed - send responses */
+		spin_unlock(&second_req->fused_lock);
+		spin_unlock_irqrestore(&first_req->fused_lock, flags);
+
+		if (first_req->ns)
+			nvmet_put_namespace(first_req->ns);
+		first_req->ops->queue_response(first_req);
+
+		if (second_req->ns)
+			nvmet_put_namespace(second_req->ns);
+		second_req->ops->queue_response(second_req);
+
+		return;
+	}
+	/* must not be here */
+	WARN_ON(1);
+	spin_unlock(&second_req->fused_lock);
+	spin_unlock_irqrestore(&first_req->fused_lock, flags);
+
+	if (req->ns)
+		nvmet_put_namespace(req->ns);
+	req->ops->queue_response(req);
+}
+
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	struct nvmet_ns *ns = req->ns;
+	unsigned long flags;
 
 	if (!req->sq->sqhd_disabled)
 		nvmet_update_sq_head(req);
@@ -818,6 +907,62 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 
 	trace_nvmet_req_complete(req);
 
+	if (unlikely(req->cmd->common.flags & NVME_CMD_FUSE_FIRST)) {
+		struct nvmet_req *fused_req = NULL;
+
+		spin_lock_irqsave(&req->sq->fused_lock, flags);
+		if (req->sq->first_fused_req == req) {
+			req->sq->first_fused_req = NULL;
+			spin_unlock_irqrestore(&req->sq->fused_lock, flags);
+			/* There is no the second fused command yet, so just
+			 * complete this one. The second command will fail with
+			 * MISSING code because sq->first_fused_req is NULL..
+			 */
+			goto queue_resp;
+		}
+		/* This command is not the first fused waiting for the second
+		 * fused, either the second is received or there was no second
+		 * and this one is failed.
+		 * req->fused_pair is safe to read without spin_lock, because
+		 * sq->first_fused_req != req and req->fused_pair will not set.
+		 */
+		fused_req = req->fused_pair;
+		if (!fused_req) {
+			spin_unlock_irqrestore(&req->sq->fused_lock, flags);
+			/* There is no the second fused command yet, so just
+			 * complete this one.
+			 */
+			goto queue_resp;
+		}
+		spin_unlock_irqrestore(&req->sq->fused_lock, flags);
+
+		/* There is the second fused command */
+
+		__nvmet_fused_req_complete(req, fused_req, status);
+
+		return;
+	} else if (unlikely(req->cmd->common.flags & NVME_CMD_FUSE_SECOND)) {
+		struct nvmet_req *fused_req = NULL;
+
+		spin_lock_irqsave(&req->fused_lock, flags);
+		if (!req->fused_pair) {
+			/* There is no the first fused command, so just
+			 * complete this one
+			 */
+			spin_unlock_irqrestore(&req->fused_lock, flags);
+			goto queue_resp;
+		}
+		fused_req = req->fused_pair;
+		req->fused_state = NVMET_FUSED_STATE_COMPLETED;
+		spin_unlock_irqrestore(&req->fused_lock, flags);
+
+		__nvmet_fused_req_complete(req, fused_req, status);
+
+		/* unlock LBA */
+		return;
+	}
+
+queue_resp:
 	req->ops->queue_response(req);
 	if (ns)
 		nvmet_put_namespace(ns);
@@ -866,6 +1011,11 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 */
 	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
 		nvmet_async_events_failall(ctrl);
+
+	/* Complete the first fused command waiting for the second one */
+	if (sq->first_fused_req)
+		nvmet_req_complete(sq->first_fused_req, NVME_SC_FUSED_MISSING);
+
 	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
@@ -915,6 +1065,7 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 	init_completion(&sq->free_done);
 	init_completion(&sq->confirm_done);
 	nvmet_auth_sq_init(sq);
+	spin_lock_init(&sq->fused_lock);
 
 	return 0;
 }
@@ -950,6 +1101,107 @@ static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 	return 0;
 }
 
+/* Fail the first fused command that does not have a fused pair */
+static void nvmet_fail_first_fused(struct nvmet_req *req)
+{
+	spin_lock(&req->fused_lock);
+	if (req->fused_state == NVMET_FUSED_STATE_INIT) {
+		/* command still collects a data, just set state */
+		req->fused_state = NVMET_FUSED_STATE_FAILED;
+		spin_unlock(&req->fused_lock);
+		return;
+	} else if (req->fused_state == NVMET_FUSED_STATE_EXECUTING) {
+		req->fused_state = NVMET_FUSED_STATE_FAILED;
+		spin_unlock(&req->fused_lock);
+		nvmet_req_complete(req, NVME_SC_FUSED_MISSING);
+		return;
+	}
+	spin_unlock(&req->fused_lock);
+}
+
+/* This function is called always in the same thread,
+ * but req->sq->first_fused_req and req->fused_* are used in different threads.
+ * Therefore locks are used to synchronize an access to them.
+ */
+static u16 nvmet_cmd_check_fused(struct nvmet_req *req)
+{
+	struct nvmet_req *first_req;
+
+	if (likely(!(req->cmd->common.flags & NVME_CMD_FUSE_MASK))) {
+		if (unlikely(req->sq->first_fused_req)) {
+			spin_lock(&req->sq->fused_lock);
+			first_req = req->sq->first_fused_req;
+			if (req->sq->first_fused_req) {
+				req->sq->first_fused_req = NULL;
+				spin_unlock(&req->sq->fused_lock);
+				nvmet_fail_first_fused(first_req);
+			} else {
+				spin_unlock(&req->sq->fused_lock);
+			}
+		}
+		return 0;
+	} else if ((req->cmd->common.flags & NVME_CMD_FUSE_MASK) == NVME_CMD_FUSE_MASK) {
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	spin_lock(&req->sq->fused_lock);
+	first_req = req->sq->first_fused_req;
+	if (req->cmd->common.flags & NVME_CMD_FUSE_FIRST) {
+		if (first_req) {
+			req->sq->first_fused_req = NULL;
+			spin_unlock(&req->sq->fused_lock);
+
+			nvmet_fail_first_fused(first_req);
+
+			spin_lock(&req->sq->fused_lock);
+		}
+
+		if (req->cmd->common.opcode != nvme_cmd_compare) {
+			spin_unlock(&req->sq->fused_lock);
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		}
+
+		/* only one logical block is supported for Compare And Write */
+		if (req->cmd->rw.length > 0) {
+			spin_unlock(&req->sq->fused_lock);
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		}
+
+		req->sq->first_fused_req = req;
+	} else if (unlikely(req->cmd->common.flags & NVME_CMD_FUSE_SECOND)) {
+		if (!first_req) {
+			spin_unlock(&req->sq->fused_lock);
+			return NVME_SC_FUSED_MISSING;
+		}
+
+		if (req->cmd->common.opcode != nvme_cmd_write) {
+			req->sq->first_fused_req = NULL;
+			spin_unlock(&req->sq->fused_lock);
+
+			nvmet_fail_first_fused(first_req);
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		}
+
+		if (req->cmd->rw.length > 0 ||
+		    req->cmd->rw.slba != first_req->cmd->rw.slba) {
+			req->sq->first_fused_req = NULL;
+			spin_unlock(&req->sq->fused_lock);
+
+			nvmet_fail_first_fused(first_req);
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		}
+
+		req->fused_pair = first_req;
+		first_req->fused_pair = req;
+		req->sq->first_fused_req = NULL;
+	}
+
+	req->fused_state = NVMET_FUSED_STATE_INIT;
+	spin_unlock(&req->sq->fused_lock);
+
+	return 0;
+}
+
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -1019,11 +1272,14 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->ns = NULL;
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
+	req->fused_pair = NULL;
+
+	spin_lock_init(&req->fused_lock);
 
-	/* no support for fused commands yet */
-	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
+
+	status = nvmet_cmd_check_fused(req);
+	if (unlikely(status)) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -1100,7 +1356,69 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 
 void nvmet_req_execute(struct nvmet_req *req)
 {
-	req->execute(req);
+	if (likely(!(req->cmd->common.flags & NVME_CMD_FUSE_MASK))) {
+		req->execute(req);
+		return;
+	}
+
+	if (req->cmd->common.flags & NVME_CMD_FUSE_FIRST) {
+		spin_lock(&req->fused_lock);
+		if (req->fused_state == NVMET_FUSED_STATE_FAILED) {
+			spin_unlock(&req->fused_lock);
+			nvmet_req_complete(req, NVME_SC_FUSED_MISSING);
+			return;
+		}
+
+		req->fused_state = NVMET_FUSED_STATE_EXECUTING;
+
+		if (req->fused_pair) {
+			spin_lock(&req->fused_pair->fused_lock);
+			if (req->fused_pair->fused_state == NVMET_FUSED_STATE_EXECUTING) {
+				spin_unlock(&req->fused_pair->fused_lock);
+				spin_unlock(&req->fused_lock);
+				req->execute(req);
+				return;
+			}
+			spin_unlock(&req->fused_pair->fused_lock);
+		}
+		spin_unlock(&req->fused_lock);
+		/* wait for both fused command ready to execute */
+		return;
+	} else if (req->cmd->common.flags & NVME_CMD_FUSE_SECOND) {
+		struct nvmet_req *first_req = NULL;
+
+		spin_lock(&req->fused_lock);
+		if (!req->fused_pair) {
+			spin_unlock(&req->fused_lock);
+			nvmet_req_complete(req, NVME_SC_FUSED_MISSING);
+			return;
+		}
+
+		if (req->fused_state == NVMET_FUSED_STATE_FAILED) {
+			spin_unlock(&req->fused_lock);
+			nvmet_req_complete(req, NVME_SC_FUSED_MISSING);
+			return;
+		}
+		first_req = req->fused_pair;
+		spin_unlock(&req->fused_lock);
+
+		/* take locks in the same order */
+		spin_lock(&first_req->fused_lock);
+		spin_lock(&req->fused_lock);
+		req->fused_state = NVMET_FUSED_STATE_EXECUTING;
+
+		if (first_req->fused_state == NVMET_FUSED_STATE_EXECUTING) {
+			spin_unlock(&req->fused_lock);
+			spin_unlock(&first_req->fused_lock);
+			/* both fused command are ready to execute */
+			first_req->execute(first_req);
+			return;
+		}
+
+		spin_unlock(&req->fused_lock);
+		spin_unlock(&first_req->fused_lock);
+		/* wait for both fused command ready to execute */
+	}
 }
 EXPORT_SYMBOL_GPL(nvmet_req_execute);
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a77f0e05c174..804c2d0be6bc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2186,7 +2186,7 @@ nvmet_fc_prep_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
 	    nvme_is_fabrics((struct nvme_command *) sqe) ||
 	    xfr_length != fod->req.transfer_len ||
 	    (le16_to_cpu(cqe->status) & 0xFFFE) || cqewd[0] || cqewd[1] ||
-	    (sqe->flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND)) ||
+	    (sqe->flags & NVME_CMD_FUSE_MASK) ||
 	    queue_90percent_full(fod->queue, le16_to_cpu(cqe->sq_head)))
 		send_ersp = true;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 41e4eec9a251..1278b81c85a7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -102,6 +102,7 @@ struct nvmet_cq {
 	u16			size;
 };
 
+struct nvmet_req;
 struct nvmet_sq {
 	struct nvmet_ctrl	*ctrl;
 	struct percpu_ref	ref;
@@ -124,6 +125,8 @@ struct nvmet_sq {
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
+	struct nvmet_req	*first_fused_req;
+	spinlock_t		fused_lock;
 };
 
 struct nvmet_ana_group {
@@ -340,7 +343,6 @@ struct nvmet_subsys_link {
 	struct nvmet_subsys	*subsys;
 };
 
-struct nvmet_req;
 struct nvmet_fabrics_ops {
 	struct module *owner;
 	unsigned int type;
@@ -374,6 +376,14 @@ struct nvmet_req {
 	struct scatterlist	*sg;
 	struct scatterlist	*metadata_sg;
 	struct scatterlist	*cmp_sg;
+	struct nvmet_req	*fused_pair;
+	struct work_struct	fused_work;
+	spinlock_t		fused_lock;
+	int			fused_state;
+#define NVMET_FUSED_STATE_INIT		0
+#define NVMET_FUSED_STATE_EXECUTING	1
+#define NVMET_FUSED_STATE_COMPLETED	2
+#define NVMET_FUSED_STATE_FAILED	3
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..af6fbff74dcc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -374,6 +374,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_FUSES_COMPARE_AND_WRITE	= 1 << 0,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -949,6 +950,7 @@ union nvme_data_ptr {
 enum {
 	NVME_CMD_FUSE_FIRST	= (1 << 0),
 	NVME_CMD_FUSE_SECOND	= (1 << 1),
+	NVME_CMD_FUSE_MASK	= NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND,
 
 	NVME_CMD_SGL_METABUF	= (1 << 6),
 	NVME_CMD_SGL_METASEG	= (1 << 7),
-- 
2.25.1


