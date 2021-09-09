Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2922C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 12:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A82560698
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 12:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A82560698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xVpephOhswASGPA+6lH7Ah4o1dYcojj93dEz4sLjAjQ=; b=zRachEt8bVbl2Q
	R1MZURYUgIismmllJdkhPmmqWXQ49LB+lDgQiOuY60C7S9rt0vDG5yejoB1c3GL02Xm4HfxeNBDVu
	NxRdc2fIG/RNTd7EDAn6INDksVTrADKDiyMbsHx7x0WSRClHkDdWf7FvQZCfh/CTVXFRpgsJn4jTk
	Z99Be+X1mWmzin48KHShluoIoZhsDtismW0gBbxI7ro8tpfwSPq/vboPWhdd8tPY5/WXx0teJzgAg
	npxVqvewyFgzo6wNPi75WFTiku7hAQOct0A1ekGCF1boPzAaYy87lT4AfSPRIbS6BSIB2ze1gaUAU
	tN3BtNDjopGtMI426zJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOJDR-009S0i-Sg; Thu, 09 Sep 2021 12:31:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOIYj-0097zZ-Hf
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 11:49:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74BC961A6E;
 Thu,  9 Sep 2021 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631188177;
 bh=T9yjMbIYIVx2KMQKFjQjpdt1fRLiN7c2Kz54/96fY/Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ir5rPL5b0Tcgaqcw9w2uud+rBNjzJ7SdinIdOd4YMbPXOO66QSrBxK3wmkMpwhtg0
 UiJMlx/3yEQEZ1SDjmkBbfNgEzYxgijWxDQPWY/76+BacQUqcdv35+/fj4iiqb7la+
 MIItOdcSwLaAxnD8V362eCKL8OqfsePsTaPHxjZfYWNVZ+gq2ygPLQgLdCBKdYHrgz
 VWT1ZgrY6AQpdYkGeTbuzke+i8lqIKDo7GUZJ2fopFBNQkof0pm51K49uOSK1v7Xi1
 eLnJS/Qxe79/Ny0Cp0PeLM92iGM6gwtFWCaUAYByXu9NdtVbrYjARTZhfbyzXFxRR3
 offZcej3+0QoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.13 140/219] nvme: code command_id with a genctr for
 use-after-free validation
Date: Thu,  9 Sep 2021 07:45:16 -0400
Message-Id: <20210909114635.143983-140-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114635.143983-1-sashal@kernel.org>
References: <20210909114635.143983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_044937_677562_61E3F77D 
X-CRM114-Status: GOOD (  19.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit e7006de6c23803799be000a5dcce4d916a36541a ]

We cannot detect a (perhaps buggy) controller that is sending us
a completion for a request that was already completed (for example
sending a completion twice), this phenomenon was seen in the wild
a few times.

So to protect against this, we use the upper 4 msbits of the nvme sqe
command_id to use as a 4-bit generation counter and verify it matches
the existing request generation that is incrementing on every execution.

The 16-bit command_id structure now is constructed by:
| xxxx | xxxxxxxxxxxx |
  gen    request tag

This means that we are giving up some possible queue depth as 12 bits
allow for a maximum queue depth of 4095 instead of 65536, however we
never create such long queues anyways so no real harm done.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c   |  3 ++-
 drivers/nvme/host/nvme.h   | 47 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  4 ++--
 drivers/nvme/host/tcp.c    | 26 ++++++++++-----------
 drivers/nvme/target/loop.c |  4 ++--
 6 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 148e756857a8..a13eec2fca5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1009,7 +1009,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	cmd->common.command_id = req->tag;
+	nvme_req(req)->genctr++;
+	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0015860ec12b..632076b9c1c9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -158,6 +158,7 @@ enum nvme_quirks {
 struct nvme_request {
 	struct nvme_command	*cmd;
 	union nvme_result	result;
+	u8			genctr;
 	u8			retries;
 	u8			flags;
 	u16			status;
@@ -497,6 +498,49 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 };
 
+/*
+ * nvme command_id is constructed as such:
+ * | xxxx | xxxxxxxxxxxx |
+ *   gen    request tag
+ */
+#define nvme_genctr_mask(gen)			(gen & 0xf)
+#define nvme_cid_install_genctr(gen)		(nvme_genctr_mask(gen) << 12)
+#define nvme_genctr_from_cid(cid)		((cid & 0xf000) >> 12)
+#define nvme_tag_from_cid(cid)			(cid & 0xfff)
+
+static inline u16 nvme_cid(struct request *rq)
+{
+	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
+}
+
+static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
+		u16 command_id)
+{
+	u8 genctr = nvme_genctr_from_cid(command_id);
+	u16 tag = nvme_tag_from_cid(command_id);
+	struct request *rq;
+
+	rq = blk_mq_tag_to_rq(tags, tag);
+	if (unlikely(!rq)) {
+		pr_err("could not locate request for tag %#x\n",
+			tag);
+		return NULL;
+	}
+	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
+		dev_err(nvme_req(rq)->ctrl->device,
+			"request %#x genctr mismatch (got %#x expected %#x)\n",
+			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
+		return NULL;
+	}
+	return rq;
+}
+
+static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
+                u16 command_id)
+{
+	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
+}
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
@@ -594,7 +638,8 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 
 static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 {
-	return !qid && command_id >= NVME_AQ_BLK_MQ_DEPTH;
+	return !qid &&
+		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
 void nvme_complete_rq(struct request *req);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d963f25fc7ae..01feb1c2278d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1017,7 +1017,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
+	req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
 	if (unlikely(!req)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4697a94c0945..f61bf39c39a0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1731,10 +1731,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	struct request *rq;
 	struct nvme_rdma_request *req;
 
-	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
+	rq = nvme_find_rq(nvme_rdma_tagset(queue), cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
-			"tag 0x%x on QP %#x not found\n",
+			"got bad command_id %#x on QP %#x\n",
 			cqe->command_id, queue->qp->qp_num);
 		nvme_rdma_error_recovery(queue->ctrl);
 		return;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7a949f6d5aea..d87ef76e36f9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -487,11 +487,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 {
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag 0x%x not found\n",
-			nvme_tcp_queue_id(queue), cqe->command_id);
+			"got bad cqe.command_id %#x on queue %d\n",
+			cqe->command_id, nvme_tcp_queue_id(queue));
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 		return -EINVAL;
 	}
@@ -508,11 +508,11 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 {
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+			"got bad c2hdata.command_id %#x on queue %d\n",
+			pdu->command_id, nvme_tcp_queue_id(queue));
 		return -ENOENT;
 	}
 
@@ -606,7 +606,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	data->hdr.plen =
 		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
 	data->ttag = pdu->ttag;
-	data->command_id = rq->tag;
+	data->command_id = nvme_cid(rq);
 	data->data_offset = cpu_to_le32(req->data_sent);
 	data->data_length = cpu_to_le32(req->pdu_len);
 	return 0;
@@ -619,11 +619,11 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct request *rq;
 	int ret;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+			"got bad r2t.command_id %#x on queue %d\n",
+			pdu->command_id, nvme_tcp_queue_id(queue));
 		return -ENOENT;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -703,7 +703,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	struct request *rq =
-		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
@@ -796,8 +796,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-						pdu->command_id);
+		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+					pdu->command_id);
 
 		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 		queue->nr_cqe++;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a5c4a1865026..f6ee47de3038 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -107,10 +107,10 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	} else {
 		struct request *rq;
 
-		rq = blk_mq_tag_to_rq(nvme_loop_tagset(queue), cqe->command_id);
+		rq = nvme_find_rq(nvme_loop_tagset(queue), cqe->command_id);
 		if (!rq) {
 			dev_err(queue->ctrl->ctrl.device,
-				"tag 0x%x on queue %d not found\n",
+				"got bad command_id %#x on queue %d\n",
 				cqe->command_id, nvme_loop_queue_idx(queue));
 			return;
 		}
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
