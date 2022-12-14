Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F19BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FdF8GDxhvCfHHY90T4EvPcNxQcliN4NIhiYzNNisxdE=; b=PUACalhq3BcTkCAHJUJ38rSGyp
	9BSD9qiiRZ7A0YZ+z9A+y6/D5TOx5u+umlTBWV4MAO58KY3HNjtge8UMk+wHyDznlK2wr8ivyVgxs
	cea5nrPDq323IOaK8hAVVGo+D4uc73PXyMVeX4OUlLRB4b5i0bNRXjW9K4Y/yneHPxy9g5dejk7KV
	rDp2rJcOEvOy+r1qvU37gt471TJNe3z6chvE5ZKBzq1zo/n/2kkDhbN55pG7MFcP5aWZo4yT9mcwI
	b1Fu9CHCLNJwjP+m4u/m4xBguAJdP356eWv1OzLJ5RbJl8PyS5qRNA8RaWtmC+lyr5IoK3sgqM1MV
	ptZjUAeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOb-000VTs-LL; Wed, 14 Dec 2022 16:14:13 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOP-000VNG-8S; Wed, 14 Dec 2022 16:14:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/9] nvmet: refactor passthru fixup code
Date: Wed, 14 Dec 2022 17:13:42 +0100
Message-Id: <20221214161347.764071-5-hch@lst.de>
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

Add a helper to check if a given command needs a fixup and use that
instead of setting the use_workqueue flag that can get out of sync.
Also move the fixup into a separate out of line function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/nvmet.h    |  1 -
 drivers/nvme/target/passthru.c | 50 ++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 89bedfcd974c41..b4f7d2aa869142 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -369,7 +369,6 @@ struct nvmet_req {
 			struct bio		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
-			bool			use_workqueue;
 		} p;
 #ifdef CONFIG_BLK_DEV_ZONED
 		struct {
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0b238fce2c11f2..63fe8aaf968486 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -211,19 +211,20 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	return status;
 }
 
-static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
+static bool nvmet_passthru_needs_fixup(struct nvmet_req *req)
 {
-	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
-	struct request *rq = req->p.rq;
-	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
-	struct nvme_ns *ns = rq->q->queuedata;
-	u32 effects;
-	int status;
+	/*
+	 * Some CNS values of Identify need fixups after I/O completion and
+	 * thus need to be handled in a workqueue.  Don't bother selecting the
+	 * specific ones as Identify performance doesn't matter too much.
+	 */
+	return req->cmd->common.opcode == nvme_admin_identify;
+}
 
-	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
-	status = nvme_execute_rq(rq, false);
-	if (status == NVME_SC_SUCCESS &&
-	    req->cmd->common.opcode == nvme_admin_identify) {
+static void nvmet_passthru_fixup(struct nvmet_req *req)
+{
+	switch (req->cmd->common.opcode) {
+	case nvme_admin_identify:
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
 			nvmet_passthru_override_id_ctrl(req);
@@ -234,8 +235,26 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 		case NVME_ID_CNS_NS_DESC_LIST:
 			nvmet_passthru_override_id_descs(req);
 			break;
+		default:
+			break;
 		}
-	} else if (status < 0)
+	}
+}
+
+static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
+	struct request *rq = req->p.rq;
+	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
+	u32 effects;
+	int status;
+
+	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
+	status = nvme_execute_rq(rq, false);
+	if (status == NVME_SC_SUCCESS && nvmet_passthru_needs_fixup(req))
+		nvmet_passthru_fixup(req);
+	else if (status < 0)
 		status = NVME_SC_INTERNAL;
 
 	req->cqe->result = nvme_req(rq)->result;
@@ -342,7 +361,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	 * which is typically in interrupt context.
 	 */
 	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
-	if (req->p.use_workqueue || effects) {
+	if (nvmet_passthru_needs_fixup(req) || effects) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
 		req->p.rq = rq;
 		queue_work(nvmet_wq, &req->p.work);
@@ -404,7 +423,6 @@ static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
 
 static u16 nvmet_setup_passthru_command(struct nvmet_req *req)
 {
-	req->p.use_workqueue = false;
 	req->execute = nvmet_passthru_execute_cmd;
 	return NVME_SC_SUCCESS;
 }
@@ -538,25 +556,21 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
 			req->execute = nvmet_passthru_execute_cmd;
-			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
 		case NVME_ID_CNS_CS_CTRL:
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
 				req->execute = nvmet_passthru_execute_cmd;
-				req->p.use_workqueue = true;
 				return NVME_SC_SUCCESS;
 			}
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_passthru_execute_cmd;
-			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
 		case NVME_ID_CNS_CS_NS:
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
 				req->execute = nvmet_passthru_execute_cmd;
-				req->p.use_workqueue = true;
 				return NVME_SC_SUCCESS;
 			}
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-- 
2.35.1


