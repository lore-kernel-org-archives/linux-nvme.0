Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99040C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 11:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644EA613A5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 644EA613A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T0BmexoKU1EyPU7mzZSVkfoVhSYbe9ZwVoAn9ckrq30=; b=Ecgj3oiE7H60pe
	rwVwghaWj8iNdySR7srcAUiGHXqlZvGTdZi0ATRH0qLeKI8Bd8ZH0b8QdIml4B3iWcdMf6stOHGO1
	Xp8RfNGtVz9WS7SNa6MvE1EbN8I86AzXVRhLrD7dRumjjvxIha+jlgbNaY0yyMs4L4ZQL+hVMKxOm
	kuyRJ56QIu9q4tynZsFMfbLRi6guMvfLkKAxjKe0uLf11miA52xg+XR7fsHnhuZQZ+ZbmAx984p5U
	GgGRWkNeybeAmrF96rEbgHNw9hj7yVD+F8IpuhKj+Wpr+Hsz3SRdX6nB2DT4bvx0xoLmGxMcu+yFV
	UDi9U86eTY1d/HS6IbiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOIhT-009CrG-CA; Thu, 09 Sep 2021 11:58:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOITp-0094wq-KQ
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 11:44:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF9461361;
 Thu,  9 Sep 2021 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631187873;
 bh=u2NMLRLaE5dXD07eIHxkM7fyI3PQPvv8nSibpj5SnjQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oMPGlMFFr0BKAk14hPS0f7q71OHHcvwWM/nKf5FUzxlhh9o+c+4tTePRWfCxgtGK8
 Dm2/TNJ06lZFX40Ko/IZh0DbQKK0d3uF+M0vgB5c7QFluTBCm9RYpR9PpIVeV9xjTz
 PAmaHVh+zbrTDT/n8vl7arAFLTCKuKNtwmpdOIirgSkZsTq3VryV+2hehyZnJfo4S7
 zGZL2/mBRmOk13NoHUVmhMxS/Xykx5bkdjF0gsQRG2QNKbGs1m03KHgRQJH8HRVCDT
 piDpU4Lf+C9Nn2GW8m4qmzcpn6+462bkJSClD5RKdxZEf5SVMH82/3ausFsP745g1a
 /rpOs3i3a+KAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.14 158/252] nvme: code command_id with a genctr for
 use-after-free validation
Date: Thu,  9 Sep 2021 07:39:32 -0400
Message-Id: <20210909114106.141462-158-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_044433_798919_B769DC6D 
X-CRM114-Status: GOOD (  18.97  )
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
index dfd9dec0c1f6..2f0cbaba12ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1029,7 +1029,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	cmd->common.command_id = req->tag;
+	nvme_req(req)->genctr++;
+	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5cd1fa3b8464..26511794629b 100644
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
index 51852085239e..c246fdacba2e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1014,7 +1014,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
+	req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
 	if (unlikely(!req)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7f6b3a991501..69ae67652f38 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1730,10 +1730,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
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
index d649b446da66..0a97ba02f61e 100644
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
index 3a17a7e26bbf..0285ccc7541f 100644
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
