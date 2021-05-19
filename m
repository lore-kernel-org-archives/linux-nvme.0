Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA61C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:45:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A7F61007
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A7F61007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c7+bVe0GqSr/pTTb1OQsE181O2Yis31I7W6InZInZzs=; b=dIG2jPBetMFUa8RVzYIDpAlV1
	WXewjHYt+ALLM7vLnH5FYNhUa1nqmA8Ejbj5b2IITSPvU/q32qeHdn2r/3DA2jWGV6bftZjSC5G+Q
	iSWwCCDjhUkchgR4jFqZyrOXytEEALcaoE816fDhZGY1YhsGSEYdjHoWUn9CZb8prM2L3uGbBJ1Ci
	qoB890QT0NOEvN8b3e6mtpysIe/UTT3q8c7Brh3U+OPqpiA2S6+LhEU4ddqvejzNYgGNi8qum9S/v
	TWd6IvxeH44SWyO7YKWCQc5ZXmqlE7cntorQSsJ1xSoRQ32rrI9WmjtDegCy1fjJNvfrxVbOv0/Rf
	Qm3ICMpdQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljQFM-004gQa-JS; Wed, 19 May 2021 17:44:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEa-004gBu-Kd
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 17:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rcWqFCIEBBdA+NQHFGuk/hSf55nWBpvmRhq5L1dR5ok=; b=cLQoJxakigqy2LZm8Qz9EgsYZr
 pD3C31ruA/aTWslhzXF3NYTEFqCZHy+aTygJyCksuCwjTAIPYi/RwnSQWswNc2BqQQO0Twz1oajNF
 UEn6RHx0HbfQnDYnPvi49ISRu8VedGHRPdpycL5RjAZyFSKILKhHS0TJvsHQj/kLb+sczL3oNzfta
 NDKFstClNkPqY2CxQcb7sSG9sn+dG1Z3EJzWE7E/ZNpavRcWQKm/YgtTkJeKAJWwZQAOJO2pQdo2R
 2iFME215JcWVdGrD6kNwULYXpdeE1our8lUs5HiJJ1DZJHo+CnlTKuzyIhZzfOOuTu+yH0g3tpbkA
 B6Sph6bw==;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEX-00FfTy-JA
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 17:43:51 +0000
Received: by mail-pl1-f171.google.com with SMTP id n8so2245627plf.7
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 10:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rcWqFCIEBBdA+NQHFGuk/hSf55nWBpvmRhq5L1dR5ok=;
 b=qAEhmAZRz9gu2xpYmxUhTK5S60KtRdsXPKO8+g++XXL04T15VbFi4mZklX0wj9vj5O
 z2Eb5W9zWYbciQv15P59Zj5Pj2dZaxaBgtEj6QMhQEe64fHN0WHycKaPyBdoJAVSgMXs
 00ocWCRcJU6k3c5L8kh+zgCckK+oL0Ofg5iLWc/RQLxfEIOSDIMoA89FbF/fl9XVWjyh
 aKL6xu2TKb0Cnie4KBo9UsHH3f5KVBNj6Io3PuuWJBK2eouNFab7JnJKz5WI+a4uLEbO
 j9ooIIz1uJtmkJgbUXDbpIdihHTdyhu0vCPiQv4unLrxM+/dc6LPEaCAYWyaBJO+fxwJ
 PiEQ==
X-Gm-Message-State: AOAM533o66NssQsYuVLIDYZnKt/5jNHY5XSLfq2H1DklplrxLuBD8bW3
 OUrDXsvZ+nh/Ymvm133HyDqUCui286U=
X-Google-Smtp-Source: ABdhPJzUu9lf98/G/ezWnSIIYttxUYkztM2RVcOcrSyGzI8/FtIPur3iF/G01mbIXVt+iypUxXw9DQ==
X-Received: by 2002:a17:90a:4406:: with SMTP id s6mr111762pjg.93.1621446228074; 
 Wed, 19 May 2021 10:43:48 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:a498:37ce:5a01:2259])
 by smtp.gmail.com with ESMTPSA id l10sm46639pfc.125.2021.05.19.10.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 10:43:47 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 4/4] nvme: code command_id with a genctr for use-after-free
 validation
Date: Wed, 19 May 2021 10:43:40 -0700
Message-Id: <20210519174340.1144806-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519174340.1144806-1-sagi@grimberg.me>
References: <20210519174340.1144806-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_104349_654856_895991BD 
X-CRM114-Status: GOOD (  21.33  )
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
---
 drivers/nvme/host/core.c   |  3 ++-
 drivers/nvme/host/nvme.h   | 47 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  4 ++--
 drivers/nvme/host/tcp.c    | 26 ++++++++++-----------
 drivers/nvme/target/loop.c |  4 ++--
 6 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6612971f4eb..8308dd1e9e3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1006,7 +1006,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	cmd->common.command_id = req->tag;
+	nvme_req(req)->genctr++;
+	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05f31a2c64bb..e6f72c82582d 100644
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
+			tag, genctr, nvme_req(rq)->genctr);
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
index ac26d242b630..7398c5a76956 100644
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
index 203b47a8ec92..ab5b7d175488 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1727,10 +1727,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
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
index e189715ceca7..cf30568c9bbc 100644
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
 
@@ -599,7 +599,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	data->hdr.plen =
 		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
 	data->ttag = pdu->ttag;
-	data->command_id = rq->tag;
+	data->command_id = nvme_cid(rq);
 	data->data_offset = cpu_to_le32(req->data_sent);
 	data->data_length = cpu_to_le32(req->pdu_len);
 	return 0;
@@ -612,11 +612,11 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
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
@@ -696,7 +696,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	struct request *rq =
-		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
@@ -789,8 +789,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-						pdu->command_id);
+		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+					pdu->command_id);
 
 		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 		queue->nr_cqe++;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1b89a6bb819a..9f1f5d572960 100644
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
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
