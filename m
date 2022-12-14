Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40552C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RycHdq6IZGhCnaEVUHP4gOWgKDerpP+bzrtKQAhHdwk=; b=3K76IKyfLBIb9/mpyjNCM4Koe8
	+gr2v4O5cDWUFY1oM+nUAGD989nR0rqLxXCMPEory3BntN2BRZLVH4Xs0EeN+7q9iCEY+FLH3KN5k
	2BqYvq/CZGX+tCIi9R1E0/VI9ri32BzdBswahgE6Wdi6uhZ0G7mQQVnnjpKhtbaOtl/+F0aGimvrx
	pRC4MU22Rjwf9cEbIeLOdmf+iDvN9xYp9GmT635pl60q2bao9tFlSsqAlZq1ke4U582vvBWMZJbQz
	TVbr5hPD7DE3MihTD9VPEBToBDjzCUMagtwu+Aw7kVV0yEDrYH0USciIdAZ/MOTfyfSf08oit6Iq2
	vACqy8sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOg-000VWi-LB; Wed, 14 Dec 2022 16:14:18 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOR-000VOF-Vg; Wed, 14 Dec 2022 16:14:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/9] nvmet: allow async passthrough of commands that change logical block contents
Date: Wed, 14 Dec 2022 17:13:43 +0100
Message-Id: <20221214161347.764071-6-hch@lst.de>
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

Mask out the logical block change effect to allow to keep supporting
passthrough for Write commands once I/O Command effects are properly
propagated.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/passthru.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 63fe8aaf968486..f31537dd5714b1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -312,10 +312,10 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
 	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
 	struct request_queue *q = ctrl->admin_q;
+	u8 opcode = req->cmd->common.opcode;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
 	unsigned int timeout;
-	u32 effects;
 	u16 status;
 	int ret;
 
@@ -354,14 +354,12 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	}
 
 	/*
-	 * If there are effects for the command we are about to execute, or
-	 * an end_req function we need to use nvme_execute_passthru_rq()
-	 * synchronously in a work item seeing the end_req function and
-	 * nvme_passthru_end() can't be called in the request done callback
-	 * which is typically in interrupt context.
+	 * If a command needs post-exectuion fixups, or there are any non-trivial
+	 * effects, make sure to execute the command in a workqueue so that we
+	 * can execute the fixups and call nvme_passthru_end.
 	 */
-	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
-	if (nvmet_passthru_needs_fixup(req) || effects) {
+	if (nvmet_passthru_needs_fixup(req) ||
+	    (nvme_command_effects(ctrl, ns, opcode) & ~NVME_CMD_EFFECTS_LBCC)) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
 		req->p.rq = rq;
 		queue_work(nvmet_wq, &req->p.work);
-- 
2.35.1


