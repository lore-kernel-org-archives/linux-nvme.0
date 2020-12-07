Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766FBC4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DF42388C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DF42388C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4x+ONNPWRX2QVbvpg6cOHZSzcQm9z4rIf3goDGYaPJg=; b=eL/NZB0MgBzBhPrhMkQ5ejPk3
	ln4dWS+5r0bfa3MiE63R7oCMsMsSSmKPKJ74y+31VaOTWy5ZOuefOWQnNpdjggMB4qRUZMcHvaYkN
	es+FWIchwmNgDapUK8FVGg/4zbIog3By1psWTfqxQeG38FoNMSorcTkpyrbWW55fgBaGBwlet2CFk
	24atzA7b+QPxPbbtPE7b+iXRaHRs9KPFEoyu/4CZmClAxwCULFzSi3wVy9dDD4BIQ9r83eExJVK6e
	uD0393pSYX1hzXkEnfPwnp2FbiQtEge0KiwFsn1BAAWYNAZpMMMjeaaUKqMjuul2wvA9A7TX+Qh77
	MhCEiB4WQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmNjS-0001E9-D7; Mon, 07 Dec 2020 21:07:42 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmNil-0000ur-6t
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 21:07:12 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 7 Dec 2020 23:06:54 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7L6qIM029788;
 Mon, 7 Dec 2020 23:06:54 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH v1 net-next 14/15] net/mlx5e: NVMEoTCP statistics
Date: Mon,  7 Dec 2020 23:06:48 +0200
Message-Id: <20201207210649.19194-15-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201207210649.19194-1-borisp@mellanox.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_160700_227119_C8C8BD3D 
X-CRM114-Status: GOOD (  14.99  )
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

NVMEoTCP offload statistics includes both control and data path
statistic: counters for ndo, offloaded packets/bytes , dropped packets
and resync operation.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 17 +++++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 16 ++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 37 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 24 ++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 843e653699e9..756decf53930 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -651,6 +651,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int max_wqe_sz_cap, queue_id, err;
+	struct mlx5e_rq_stats *stats;
 
 	if (tconfig->type != TCP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -700,6 +701,8 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	stats = &priv->channel_stats[queue->channel_ix].rq;
+	stats->nvmeotcp_queue_init++;
 	write_lock_bh(&sk->sk_callback_lock);
 	rcu_assign_pointer(inet_csk(sk)->icsk_ulp_ddp_data, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -714,6 +717,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	stats->nvmeotcp_queue_init_fail++;
 	return err;
 }
 
@@ -724,11 +728,15 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5e_rq_stats *stats;
 
 	queue = (struct mlx5e_nvmeotcp_queue *)tcp_ddp_get_ctx(sk);
 
 	napi_synchronize(&priv->channels.c[queue->channel_ix]->napi);
 
+	stats = &priv->channel_stats[queue->channel_ix].rq;
+	stats->nvmeotcp_queue_teardown++;
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	if (queue->zerocopy | queue->crc_rx)
 		mlx5e_nvmeotcp_destroy_rx(queue, mdev, queue->zerocopy);
@@ -750,6 +758,7 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct scatterlist *sg = ddp->sg_table.sgl;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5e_rq_stats *stats;
 	struct mlx5_core_dev *mdev;
 	int count = 0;
 
@@ -767,6 +776,11 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	queue->ccid_table[ddp->command_id].ccid_gen++;
 	queue->ccid_table[ddp->command_id].sgl_length = count;
 
+	stats = &priv->channel_stats[queue->channel_ix].rq;
+	stats->nvmeotcp_ddp_setup++;
+	if (unlikely(mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count)))
+		stats->nvmeotcp_ddp_setup_fail++;
+
 	return 0;
 }
 
@@ -808,6 +822,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 		(struct mlx5e_nvmeotcp_queue *)tcp_ddp_get_ctx(sk);
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_rq_stats *stats;
 
 	q_entry  = &queue->ccid_table[ddp->command_id];
 	WARN_ON(q_entry->sgl_length == 0);
@@ -816,6 +831,8 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
+	stats = &priv->channel_stats[queue->channel_ix].rq;
+	stats->nvmeotcp_ddp_teardown++;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index be5111b66cc9..298558ae2dcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -10,12 +10,16 @@ static void nvmeotcp_update_resync(struct mlx5e_nvmeotcp_queue *queue,
 				   struct mlx5e_cqe128 *cqe128)
 {
 	const struct tcp_ddp_ulp_ops *ulp_ops;
+	struct mlx5e_rq_stats *stats;
 	u32 seq;
 
 	seq = be32_to_cpu(cqe128->resync_tcp_sn);
 	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
 	if (ulp_ops && ulp_ops->resync_request)
 		ulp_ops->resync_request(queue->sk, seq, TCP_DDP_RESYNC_REQ);
+
+	stats = queue->priv->channels.c[queue->channel_ix]->rq.stats;
+	stats->nvmeotcp_resync++;
 }
 
 static void mlx5e_nvmeotcp_advance_sgl_iter(struct mlx5e_nvmeotcp_queue *queue)
@@ -61,10 +65,13 @@ mlx5_nvmeotcp_add_tail_nonlinear(struct mlx5e_nvmeotcp_queue *queue,
 				 int org_nr_frags, int frag_index)
 {
 	struct mlx5e_priv *priv = queue->priv;
+	struct mlx5e_rq_stats *stats;
 
 	while (org_nr_frags != frag_index) {
 		if (skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS) {
 			dev_kfree_skb_any(skb);
+			stats = priv->channels.c[queue->channel_ix]->rq.stats;
+			stats->nvmeotcp_drop++;
 			return NULL;
 		}
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
@@ -83,9 +90,12 @@ mlx5_nvmeotcp_add_tail(struct mlx5e_nvmeotcp_queue *queue, struct sk_buff *skb,
 		       int offset, int len)
 {
 	struct mlx5e_priv *priv = queue->priv;
+	struct mlx5e_rq_stats *stats;
 
 	if (skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS) {
 		dev_kfree_skb_any(skb);
+		stats = priv->channels.c[queue->channel_ix]->rq.stats;
+		stats->nvmeotcp_drop++;
 		return NULL;
 	}
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
@@ -146,6 +156,7 @@ mlx5e_nvmeotcp_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct nvmeotcp_queue_entry *nqe;
+	struct mlx5e_rq_stats *stats;
 	int org_nr_frags, frag_index;
 	struct mlx5e_cqe128 *cqe128;
 	u32 queue_id;
@@ -164,6 +175,8 @@ mlx5e_nvmeotcp_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 		return skb;
 	}
 
+	stats = priv->channels.c[queue->channel_ix]->rq.stats;
+
 	/* cc ddp from cqe */
 	ccid = be16_to_cpu(cqe128->ccid);
 	ccoff = be32_to_cpu(cqe128->ccoff);
@@ -206,6 +219,7 @@ mlx5e_nvmeotcp_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 	while (to_copy < cclen) {
 		if (skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS) {
 			dev_kfree_skb_any(skb);
+			stats->nvmeotcp_drop++;
 			mlx5e_nvmeotcp_put_queue(queue);
 			return NULL;
 		}
@@ -235,6 +249,8 @@ mlx5e_nvmeotcp_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 							       frag_index);
 	}
 
+	stats->nvmeotcp_offload_packets++;
+	stats->nvmeotcp_offload_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return skb;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 2cf2042b37c7..ca7d2cb5099f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -34,6 +34,7 @@
 #include "en.h"
 #include "en_accel/tls.h"
 #include "en_accel/en_accel.h"
+#include "en_accel/nvmeotcp.h"
 
 static unsigned int stats_grps_num(struct mlx5e_priv *priv)
 {
@@ -189,6 +190,18 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_resync_res_ok) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_resync_res_skip) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_err) },
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_queue_init) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_queue_init_fail) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_queue_teardown) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_ddp_setup) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_ddp_setup_fail) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_ddp_teardown) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_drop) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_resync) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_offload_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_nvmeotcp_offload_bytes) },
 #endif
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, ch_events) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, ch_poll) },
@@ -352,6 +365,18 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_tls_resync_res_skip     += rq_stats->tls_resync_res_skip;
 	s->rx_tls_err                 += rq_stats->tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	s->rx_nvmeotcp_queue_init      += rq_stats->nvmeotcp_queue_init;
+	s->rx_nvmeotcp_queue_init_fail += rq_stats->nvmeotcp_queue_init_fail;
+	s->rx_nvmeotcp_queue_teardown  += rq_stats->nvmeotcp_queue_teardown;
+	s->rx_nvmeotcp_ddp_setup       += rq_stats->nvmeotcp_ddp_setup;
+	s->rx_nvmeotcp_ddp_setup_fail  += rq_stats->nvmeotcp_ddp_setup_fail;
+	s->rx_nvmeotcp_ddp_teardown    += rq_stats->nvmeotcp_ddp_teardown;
+	s->rx_nvmeotcp_drop            += rq_stats->nvmeotcp_drop;
+	s->rx_nvmeotcp_resync          += rq_stats->nvmeotcp_resync;
+	s->rx_nvmeotcp_offload_packets += rq_stats->nvmeotcp_offload_packets;
+	s->rx_nvmeotcp_offload_bytes   += rq_stats->nvmeotcp_offload_bytes;
+#endif
 }
 
 static void mlx5e_stats_grp_sw_update_stats_ch_stats(struct mlx5e_sw_stats *s,
@@ -1612,6 +1637,18 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_resync_res_skip) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_err) },
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_queue_init) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_queue_init_fail) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_queue_teardown) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_ddp_setup) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_ddp_setup_fail) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_ddp_teardown) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_drop) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_resync) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_offload_packets) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, nvmeotcp_offload_bytes) },
+#endif
 };
 
 static const struct counter_desc sq_stats_desc[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index e41fc11f2ce7..a5cf8ec4295b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -179,6 +179,18 @@ struct mlx5e_sw_stats {
 	u64 rx_congst_umr;
 	u64 rx_arfs_err;
 	u64 rx_recover;
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 rx_nvmeotcp_queue_init;
+	u64 rx_nvmeotcp_queue_init_fail;
+	u64 rx_nvmeotcp_queue_teardown;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_offload_packets;
+	u64 rx_nvmeotcp_offload_bytes;
+#endif
 	u64 ch_events;
 	u64 ch_poll;
 	u64 ch_arm;
@@ -342,6 +354,18 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_queue_init;
+	u64 nvmeotcp_queue_init_fail;
+	u64 nvmeotcp_queue_teardown;
+	u64 nvmeotcp_ddp_setup;
+	u64 nvmeotcp_ddp_setup_fail;
+	u64 nvmeotcp_ddp_teardown;
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_offload_packets;
+	u64 nvmeotcp_offload_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
