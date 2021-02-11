Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89941C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:12:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C09964E42
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C09964E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kxrEB67dcc/A+W5N5Nel7hOkH/D8qCEoHiWz4qRJRBY=; b=b2xNIRCMg9r2taHHj6AyyCnDR
	dOvj2ve45ACVq9uyUEMXf5yVbS1DEEvchH394IIpghCwsatMehwlxZK7mi6NPr3ahAClK70OmYkki
	/3hXspRkHwli0ZFtsz2Y7HRt33OCceZmCxD6DsE2/YmK4JIMBD8lROv72lanZ1BnK86mOfbS0FQEn
	PSNActAUkVlJI0MjwSu8u9RwlwE65oQsYQJjYdvOD+5x6/6AwTHnENFRZjH8nwgNcQ39smQOHZ0BM
	5ZJ0Xgh4fN1/RI9iPbYPsJIJmKeXWXrdy5VeiOqvG8cudnIPoscTmkfrIAG+VPlrbO1OI8WyZhuCC
	jiHjBEY1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAJFh-0004De-Qn; Thu, 11 Feb 2021 21:11:53 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAJFQ-00046C-8G
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 21:11:38 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60259d870001>; Thu, 11 Feb 2021 13:11:35 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 21:11:28 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 21:11:23 +0000
From: Boris Pismenny <borisp@mellanox.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
Subject: [PATCH v4 net-next  07/21] nvme-tcp: Add DDP data-path
Date: Thu, 11 Feb 2021 23:10:30 +0200
Message-ID: <20210211211044.32701-8-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210211211044.32701-1-borisp@mellanox.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_161136_443665_5F1F183A 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: tcp_ddp_setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/tcp.c | 158 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 146 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 36de4391ba76..188e26ab7116 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -57,6 +57,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+	bool			offloaded;
+	struct tcp_ddp_io	ddp;
+	__le16			status;
+	union nvme_result	result;
 };
 
 enum nvme_tcp_queue_flags {
@@ -229,13 +234,82 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
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
 #ifdef CONFIG_TCP_DDP
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				 u16 command_id,
+				 struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	int ret;
+
+	if (unlikely(!netdev)) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return -EINVAL;
+	}
+
+	ret = netdev->tcp_ddp_ops->tcp_ddp_teardown(netdev, queue->sock->sk,
+						    &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	return ret;
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			      u16 command_id,
+			      struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	int ret;
+
+	if (unlikely(!netdev)) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return -EINVAL;
+	}
+
+	req->ddp.command_id = command_id;
+	ret = nvme_tcp_req_map_sg(req, rq);
+	if (ret)
+		return -ENOMEM;
+
+	ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
+						 queue->sock->sk,
+						 &req->ddp);
+	if (!ret)
+		req->offloaded = true;
+	return ret;
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct net_device *netdev = queue->ctrl->offloading_netdev;
@@ -343,7 +417,7 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 		return;
 
 	if (unlikely(!netdev)) {
-		pr_info_ratelimited("%s: netdev not found\n", __func__);
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
 		return;
 	}
 
@@ -368,6 +442,20 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			      u16 command_id,
+			      struct request *rq)
+{
+	return -EINVAL;
+}
+
+static int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				 u16 command_id,
+				 struct request *rq)
+{
+	return -EINVAL;
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	return -EINVAL;
@@ -643,6 +731,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+
+	if (req->offloaded) {
+		req->status = status;
+		req->result = result;
+		nvme_tcp_teardown_ddp(queue, command_id, rq);
+	} else {
+		if (!nvme_try_complete_req(rq, status, result))
+			nvme_complete_rq(rq);
+	}
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -657,10 +763,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cqe->status, cqe->result, cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -849,10 +953,39 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res, pdu->command_id);
+}
+
+
+static int nvme_tcp_consume_skb(struct nvme_tcp_queue *queue, struct sk_buff *skb,
+				unsigned int *offset, struct iov_iter *iter, int recv_len)
+{
+	int ret;
+
+#ifdef CONFIG_TCP_DDP
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
+		if (queue->data_digest)
+			ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
+					queue->rcv_hash);
+		else
+			ret = skb_ddp_copy_datagram_iter(skb, *offset, iter, recv_len);
+	} else {
+#endif
+		if (queue->data_digest)
+			ret = skb_copy_and_hash_datagram_iter(skb, *offset, iter, recv_len,
+					queue->rcv_hash);
+		else
+			ret = skb_copy_datagram_iter(skb, *offset, iter, recv_len);
+#ifdef CONFIG_TCP_DDP
+	}
+#endif
+
+	return ret;
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -899,12 +1032,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
-			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
-				&req->iter, recv_len, queue->rcv_hash);
-		else
-			ret = skb_copy_datagram_iter(skb, *offset,
-					&req->iter, recv_len);
+		ret = nvme_tcp_consume_skb(queue, skb, offset, &req->iter, recv_len);
 		if (ret) {
 			dev_err(queue->ctrl->ctrl.device,
 				"queue %d failed to copy request %#x data",
@@ -1128,6 +1256,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
+	struct request *rq = blk_mq_rq_from_pdu(req);
 	int flags = MSG_DONTWAIT;
 	int ret;
 
@@ -1136,6 +1265,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) &&
+	    blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
+		nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2441,6 +2574,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
+	req->offloaded = false;
 
 	if (rq_data_dir(rq) == WRITE &&
 	    req->data_len <= nvme_tcp_inline_data_size(queue))
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
