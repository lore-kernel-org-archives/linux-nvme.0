Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903B0C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:17:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171A064DC4
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171A064DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hHWew+fady5+6Ro7BmbUNYSYUH5ZFLtRpCCtRb9XnJo=; b=kOAD4sgTCWf1d88Jtd7rcY05i
	a/0Rbs4jdA1W+uSESQiqa+bJ6wPca1/x3MgEYQGZlSEqsYNF7+OW0ci4qaDSESS84lYLq4nkDgQ4N
	CLqYA2Lnqznvi8Y+u6N2IOYsj0vHHGv7mrCWkUBoq+DHWaKVvSEN+xj5sbkdyQywmEhs2khxVrvh4
	dKKSOgIbgslIBfWqG7Ddr6KR8cWroBqWrw2F2uIruyRQg/S8N4L2jCEsrODTBwlVnMX7q0VrzkNjb
	puC93B3TNEtFiLoQsfZBrDiL4TFJB9/JpMNmjipdFlG33gCexbZ4rFQfn0ROp4pBXFcoaBulgoDJN
	FqKO18WxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6WGd-0000eW-Gv; Mon, 01 Feb 2021 10:17:11 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6W5B-00042X-VR
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 10:05:35 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 1 Feb 2021 12:05:13 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 111A5C01029353;
 Mon, 1 Feb 2021 12:05:13 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com,
 hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, smalin@marvell.com
Subject: [PATCH v3 net-next 08/21] nvme-tcp : Recalculate crc in the end of
 the capsule
Date: Mon,  1 Feb 2021 12:04:56 +0200
Message-Id: <20210201100509.27351-9-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210201100509.27351-1-borisp@mellanox.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_050522_673077_B485C53D 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ben Ben-ishay <benishay@nvidia.com>

crc offload of the nvme capsule. Check if all the skb bits
are on, and if not recalculate the crc in SW and check it.

This patch reworks the receive-side crc calculation to always
run at the end, so as to keep a single flow for both offload
and non-offload. This change simplifies the code, but it may degrade
performance for non-offload crc calculation.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/tcp.c | 118 ++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5cb46deb56e0..eb47cf6982d7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -69,6 +69,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -96,6 +97,7 @@ struct nvme_tcp_queue {
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
+	bool			ddgst_valid;
 
 	/* send state */
 	struct nvme_tcp_request *request;
@@ -234,7 +236,56 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
-#ifdef CONFIG_TCP_DDP
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{
+	if (queue->ddgst_valid)
+#ifdef CONFIG_TCP_DDP_CRC
+		queue->ddgst_valid = skb->ddp_crc;
+#else
+		queue->ddgst_valid = false;
+#endif
+}
+
+static int nvme_tcp_req_map_sg(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq)
+{
+	struct nvme_tcp_request *req;
+
+	if (!rq)
+		return;
+
+	req = blk_mq_rq_to_pdu(rq);
+
+	if (!req->offloaded && nvme_tcp_req_map_sg(req, rq))
+		return;
+
+	crypto_ahash_init(hash);
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, NULL,
+				le32_to_cpu(req->data_len));
+	crypto_ahash_update(hash);
+}
+
+#if defined(CONFIG_TCP_DDP) || defined(CONFIG_TCP_DDP_CRC)
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
@@ -290,12 +341,9 @@ int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 	}
 
 	req->ddp.command_id = command_id;
-	req->ddp.sg_table.sgl = req->ddp.first_sgl;
-	ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
-				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	ret = nvme_tcp_req_map_sg(req, rq);
 	if (ret)
 		return -ENOMEM;
-	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
 
 	ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
 						 queue->sock->sk,
@@ -317,7 +365,7 @@ int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return -ENODEV;
 	}
 
-	if (!(netdev->features & NETIF_F_HW_TCP_DDP)) {
+	if (!(netdev->features & (NETIF_F_HW_TCP_DDP | NETIF_F_HW_TCP_DDP_CRC_RX))) {
 		dev_put(netdev);
 		return -EOPNOTSUPP;
 	}
@@ -345,6 +393,9 @@ int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 	if (netdev->features & NETIF_F_HW_TCP_DDP)
 		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
 
+	if (netdev->features & NETIF_F_HW_TCP_DDP_CRC_RX)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
+
 	return ret;
 }
 
@@ -376,7 +427,7 @@ int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
 		return -ENODEV;
 	}
 
-	if (netdev->features & NETIF_F_HW_TCP_DDP &&
+	if ((netdev->features & (NETIF_F_HW_TCP_DDP | NETIF_F_HW_TCP_DDP_CRC_RX)) &&
 	    netdev->tcp_ddp_ops &&
 	    netdev->tcp_ddp_ops->tcp_ddp_limits)
 		ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
@@ -739,6 +790,7 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+	queue->ddgst_valid = true;
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -919,7 +971,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 	u64 pdu_seq = TCP_SKB_CB(skb)->seq + *offset - queue->pdu_offset;
 
-	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 		nvme_tcp_resync_response(queue, pdu_seq);
 
 	ret = skb_copy_bits(skb, *offset,
@@ -988,6 +1041,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct nvme_tcp_request *req;
 	struct request *rq;
 
+	if (queue->data_digest && test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -1025,15 +1080,17 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
-			if (queue->data_digest)
+		if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) { 
+			if (queue->data_digest &&
+			    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 				ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset,
 						&req->iter, recv_len, queue->rcv_hash);
 			else
 				ret = skb_ddp_copy_datagram_iter(skb, *offset,
 						&req->iter, recv_len);
 		} else {
-			if (queue->data_digest)
+			if (queue->data_digest &&
+			    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 				ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 						&req->iter, recv_len, queue->rcv_hash);
 			else
@@ -1055,7 +1112,6 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 	if (!queue->data_remaining) {
 		if (queue->data_digest) {
-			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
@@ -1076,8 +1132,12 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	bool offload_fail, offload_en;
+	struct request *rq = NULL;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1088,17 +1148,29 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
-	if (queue->recv_ddgst != queue->exp_ddgst) {
-		dev_err(queue->ctrl->ctrl.device,
-			"data digest error: recv %#x expected %#x\n",
-			le32_to_cpu(queue->recv_ddgst),
-			le32_to_cpu(queue->exp_ddgst));
-		return -EIO;
+	offload_fail = !nvme_tcp_ddp_ddgst_ok(queue);
+	offload_en = test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
+	if (!offload_en || offload_fail) {
+		if (offload_en && offload_fail) { // software-fallback
+			rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
+					      pdu->command_id);
+			nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq);
+		}
+
+		nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
+		if (queue->recv_ddgst != queue->exp_ddgst) {
+			dev_err(queue->ctrl->ctrl.device,
+				"data digest error: recv %#x expected %#x\n",
+				le32_to_cpu(queue->recv_ddgst),
+				le32_to_cpu(queue->exp_ddgst));
+			return -EIO;
+		}
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-						pdu->command_id);
+		if (!rq)
+			rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
+					      pdu->command_id);
 
 		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 		queue->nr_cqe++;
@@ -1841,8 +1913,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	nvme_tcp_restore_sock_calls(queue);
 	cancel_work_sync(&queue->io_work);
 
-	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 		nvme_tcp_unoffload_socket(queue);
+
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1970,8 +2044,6 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	to_tcp_ctrl(ctrl)->offloading_netdev = NULL;
-
 	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (ret)
 		return ret;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
