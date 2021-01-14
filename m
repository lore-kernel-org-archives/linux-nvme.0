Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD2C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:11:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC09E23A69
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC09E23A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ll3dYSD9z9/RS5KEz+hRUBeQY72Vsmv+TJ1W7BIZaVE=; b=fyueN+0AMMd94rc4F9ids4o03
	WIiX5pRqYm+mUA+huh50gIV9T9KNh8j88mVuHEkdClnPbZKta112VgG/9s1w7f+yPVancZh/gc9nv
	xB11Nvwy/dCPR1WlgwOku11ShEfrwuK6nvlxyJ5RXNp2nlDAepdY7Ra/+U74QcLXvhLyO+Rtdl4UW
	D/p+F608APPftgwBYJkY5DiHXGATDQiI6KulVjAlo3I8DK7Z7WOC/cwuuXPnPdZiIWXLdeOgDM+mx
	Y6Vo3DLhyXG0tKc7dzzPWQN05xNwYDxu3BT3SqKmw78EF7CcuhCG31wvUb3+nMdL8N9wLAW4yuTiq
	R9gTc/7Zg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l04HR-0000tG-Dh; Thu, 14 Jan 2021 15:11:21 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l04Gv-0000gB-MJ
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 15:10:57 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 14 Jan 2021 17:10:44 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 10EFAh06000835;
 Thu, 14 Jan 2021 17:10:44 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, dsahern@gmail.com,
 smalin@marvell.com
Subject: [PATCH v2 net-next 06/21] nvme-tcp: Add DDP offload control path
Date: Thu, 14 Jan 2021 17:10:18 +0200
Message-Id: <20210114151033.13020-7-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210114151033.13020-1-borisp@mellanox.com>
References: <20210114151033.13020-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_101050_432152_48A7C037 
X-CRM114-Status: GOOD (  21.17  )
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

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the tcp_ddp_sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (tcp_ddp_resync), which will update the HW,
and resume offload when all is successful.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via tcp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/tcp.c | 199 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..31bf9e3ea236 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -14,6 +14,7 @@
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
+#include <net/tcp_ddp.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -110,6 +112,8 @@ struct nvme_tcp_queue {
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
+
+	atomic64_t  resync_req;
 };
 
 struct nvme_tcp_ctrl {
@@ -128,6 +132,8 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device       *offloading_netdev;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -222,6 +228,182 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_TCP_DDP
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static
+int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
+	struct nvme_tcp_ddp_config config = {};
+	int ret;
+
+	if (!netdev) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return -ENODEV;
+	}
+
+	if (!(netdev->features & NETIF_F_HW_TCP_DDP)) {
+		dev_put(netdev);
+		return -EOPNOTSUPP;
+	}
+
+	config.cfg.type		= TCP_DDP_NVME;
+	config.pfv		= NVME_TCP_PFV_1_0;
+	config.cpda		= 0;
+	config.dgst		= queue->hdr_digest ?
+		NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.dgst		|= queue->data_digest ?
+		NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.queue_size	= queue->queue_size;
+	config.queue_id		= nvme_tcp_queue_id(queue);
+	config.io_cpu		= queue->io_cpu;
+
+	ret = netdev->tcp_ddp_ops->tcp_ddp_sk_add(netdev,
+						  queue->sock->sk,
+						  (struct tcp_ddp_config *)&config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
+	if (netdev->features & NETIF_F_HW_TCP_DDP)
+		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return ret;
+}
+
+static
+void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+
+	if (!netdev) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return;
+	}
+
+	netdev->tcp_ddp_ops->tcp_ddp_sk_del(netdev, queue->sock->sk);
+
+	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev); /* put the queue_init get_netdev_for_sock() */
+}
+
+static
+int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
+	struct tcp_ddp_limits limits;
+	int ret = 0;
+
+	if (!netdev) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return -ENODEV;
+	}
+
+	if (netdev->features & NETIF_F_HW_TCP_DDP &&
+	    netdev->tcp_ddp_ops &&
+	    netdev->tcp_ddp_ops->tcp_ddp_limits)
+		ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
+	else
+		ret = -EOPNOTSUPP;
+
+	if (!ret) {
+		queue->ctrl->offloading_netdev = netdev;
+		dev_dbg_ratelimited(queue->ctrl->ctrl.device,
+				    "netdev %s offload limits: max_ddp_sgl_len %d\n",
+				    netdev->name, limits.max_ddp_sgl_len);
+		queue->ctrl->ctrl.max_segments = limits.max_ddp_sgl_len;
+		queue->ctrl->ctrl.max_hw_sectors =
+			limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
+	} else {
+		queue->ctrl->offloading_netdev = NULL;
+	}
+
+	dev_put(netdev);
+
+	return ret;
+}
+
+static
+void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+			      unsigned int pdu_seq)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_req);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & TCP_DDP_RESYNC_REQ) == 0)
+		return;
+
+	/* Obtain and check requested sequence number: is this PDU header before the request? */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	if (unlikely(!netdev)) {
+		pr_info_ratelimited("%s: netdev not found\n", __func__);
+		return;
+	}
+
+	/**
+	 * The atomic operation gurarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_req, resync_val,
+			     resync_val & ~TCP_DDP_RESYNC_REQ))
+		netdev->tcp_ddp_ops->tcp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static
+bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	atomic64_set(&queue->resync_req,
+		     (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static
+int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return -EINVAL;
+}
+
+static
+void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static
+int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
+{
+	return -EINVAL;
+}
+
+static
+void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+			      unsigned int pdu_seq)
+{}
+
+static
+bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	return false;
+}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -627,6 +809,11 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + *offset - queue->pdu_offset;
+
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, pdu_seq);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1517,6 +1704,9 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_calls(queue);
 	cancel_work_sync(&queue->io_work);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1534,10 +1724,13 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	int ret;
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx, false);
-	else
+		nvme_tcp_offload_socket(&ctrl->queues[idx]);
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		nvme_tcp_offload_limits(&ctrl->queues[idx]);
+	}
 
 	if (!ret) {
 		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
@@ -1640,6 +1833,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
+	to_tcp_ctrl(ctrl)->offloading_netdev = NULL;
+
 	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (ret)
 		return ret;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
